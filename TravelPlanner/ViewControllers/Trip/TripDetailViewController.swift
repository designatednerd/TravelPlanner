//
//  TripViewController.swift
//  TravelPlanner
//
//  Created by Ellen Shapiro (Work) on 9/10/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import SharedFramework
import UIKit

class TripDetailViewController: UIViewController {

    weak var coordinator: TripCoordinator?
    var trip: Trip! {
        didSet {
            self.title = self.trip.name
        }
    }
    
    private lazy var dataSource: TripDetailDataSource = {
        return TripDetailDataSource(trip: self.trip, tableView: self.tableView)
    }()

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self.dataSource

        self.navigationItem.rightBarButtonItems = [
                UIBarButtonItem(barButtonSystemItem: .edit,
                                target: self,
                                action: #selector(editTrip)),
                UIBarButtonItem(barButtonSystemItem: .add,
                                target: self,
                                action: #selector(addPlan))
            ]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.dataSource.reloadData()
        
        let userActivity = UserActivityType.viewTrip.create(with: self.trip)
        
        self.userActivity = userActivity
        
        // ALSO donates, but only if you've set the user activity on the vc
        userActivity.becomeCurrent()
    }
    
    @objc private func addPlan() {
        let alertController = UIAlertController(title: "What kind of plan would you like to add?", message: nil, preferredStyle: .actionSheet)

        alertController.addAction(UIAlertAction(title: "Bus", style: .default, handler: { _ in
            self.coordinator?.addPlanToTrip(Bus.self, to: self.trip)
        }))

        alertController.addAction(UIAlertAction(title: "Flight", style: .default, handler: { _ in
            self.coordinator?.addPlanToTrip(Flight.self, to: self.trip)
        }))

        alertController.addAction(UIAlertAction(title: "Hotel", style: .default, handler: { _ in
            self.coordinator?.addPlanToTrip(Hotel.self, to: self.trip)
        }))

        alertController.addAction(UIAlertAction(title: "Train", style: .default, handler: { _ in
            self.coordinator?.addPlanToTrip(Train.self, to: self.trip)
        }))

        self.present(alertController, animated: true, completion: nil)
    }

    @objc private func editTrip() {
        self.coordinator?.editTrip(self.trip)
    }
}

extension TripDetailViewController: StoryboardHosted {
    
    static var storyboard: Storyboard {
        return AppStoryboard.main
    }
}

extension TripDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let plan = self.dataSource.item(ofType: Plan.self, at: indexPath) else {
            // Not a plan that was selected
            return
        }
        
        self.coordinator?.viewPlan(plan)
    }
}
