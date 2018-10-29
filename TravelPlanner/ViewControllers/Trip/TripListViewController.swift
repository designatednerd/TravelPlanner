//
//  ViewController.swift
//  TravelPlanner
//
//  Created by Ellen Shapiro (Work) on 9/10/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import SharedFramework
import UIKit

class TripListViewController: UIViewController {

    var coordinator: TripCoordinator?
    var trips: [Trip]?

    @IBOutlet private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My Trips"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        trips = CoreDataManager.shared.mainContext.dns_allOf(Trip.self)
        tableView.reloadData()
    }
    
    override func restoreUserActivityState(_ activity: NSUserActivity) {
        super.restoreUserActivityState(activity)
        guard let type = UserActivityType(rawValue: activity.activityType) else {
            return
        }
        
        guard let nav = self.coordinator?.navController else {
            return
        }
        
        nav.popToRootViewController(animated: false)
        if nav.presentedViewController != nil {
            dismiss(animated: false, completion: nil)
        }
        
        switch type {
        case .viewTrip:
            guard let tripName = activity.userInfo?[UserActivityInfoKey.trip.rawValue] as? String else {
                return
            }
            
            let predicate = NSPredicate(format: "%K == %@", "name", tripName)
            
            guard let trip = CoreDataManager.shared.mainContext.dns_fetch(Trip.self, with: predicate).first else {
                return
            }
            
            self.coordinator?.viewTrip(trip)
        }
    }


    @IBAction func addTrip() {
        self.coordinator?.addNewTrip()
    }
}

extension TripListViewController: StoryboardHosted {
    
    static var storyboard: Storyboard {
        return AppStoryboard.main
    }
}

extension TripListViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trips?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let trip = self.trips?[indexPath.row] else {
            return UITableViewCell()
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: "TripCell", for: indexPath)
        cell.textLabel?.text = trip.name ?? "(Unnamed)"
        cell.detailTextLabel?.text = trip.formattedTripInterval

        return cell
    }
}

extension TripListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let trip = self.trips?[indexPath.row] else {
            assertionFailure("Selected nonexistent trip!")
            return
        }

        coordinator?.viewTrip(trip)
    }
}

