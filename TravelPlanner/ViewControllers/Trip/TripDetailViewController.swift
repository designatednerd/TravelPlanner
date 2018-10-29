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

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        FlightInfoCell.register(in: self.tableView)
        BusInfoCell.register(in: self.tableView)
        HotelInfoCell.register(in: self.tableView)
        TrainInfoCell.register(in: self.tableView)

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
        self.tableView.reloadData()
        
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

extension TripDetailViewController: UITableViewDataSource {

    enum TripDetailSection: Int, CaseIterable {
        case tripInfo
        case plans
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return TripDetailSection.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch TripDetailSection.dns_forIndex(section) {
        case .tripInfo:
            return 1
        case .plans:
            return self.trip.planCount
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch TripDetailSection.dns_forSection(in: indexPath) {
        case .tripInfo:
            let cell = tableView.dequeueReusableCell(withIdentifier: TripInfoCell.identifier) as! TripInfoCell
            cell.configure(for: self.trip)
            return cell
        case .plans:
            let plan = self.trip.plansByDate[indexPath.row]

            if let flight = plan as? Flight {
               return FlightInfoCell.dequeueAndConfigure(in: tableView, at: indexPath, for: flight)
            } else if let bus = plan as? Bus {
                return BusInfoCell.dequeueAndConfigure(in: tableView, at: indexPath, for: bus)
            } else if let hotel = plan as? Hotel {
                return HotelInfoCell.dequeueAndConfigure(in: tableView, at: indexPath, for: hotel)
            } else if let train = plan as? Train {
                return TrainInfoCell.dequeueAndConfigure(in: tableView, at: indexPath, for: train)
            } else {
                fatalError("Unhandled plan type: \(type(of: plan))")
            }
        }
    }
}

extension TripDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch TripDetailSection.dns_forSection(in: indexPath) {
        case .tripInfo:
            // Nothing to do here.
            break
        case .plans:
            let plan = self.trip.plansByDate[indexPath.row]
            self.coordinator?.editPlan(plan)
        }
    }
}
