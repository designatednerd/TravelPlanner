//
//  TripCoordinator.swift
//  TravelPlanner
//
//  Created by Ellen Shapiro (Work) on 9/10/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import Intents
import UIKit
import SharedFramework

class TripCoordinator {

    lazy var navController: UINavigationController = {
        let tripListVC = TripListViewController.loadFromStoryboard()
        tripListVC.coordinator = self
        let navController = UINavigationController(rootViewController: tripListVC)

        return navController
    }()

    var editCoordinator: PlanEditCoordinator?
    var intentDonor: IntentDonor?
    
    // MARK: - Public actions

    func addNewTrip() {
        let trip = Trip.dns_create()

        self.showTripEditViewController(with: trip)        
    }

    func viewTrip(_ trip: Trip) {
        self.showTripViewController(with: trip)
    }

    func editTrip(_ trip: Trip) {
        self.showTripEditViewController(with: trip)
    }

    func addPlanToTrip<T: Plan>(_ type: T.Type, to trip: Trip) {
        let plan = T.dns_create()
        trip.addToPlans(plan)

        self.showEditController(for: plan)
    }

    func editPlan<T: Plan>(_ plan: T) {
        self.showEditController(for: plan)
    }
    
    func viewPlan<T: Plan>(_ plan: T) {
        self.showEditController(for: plan, mode: .view)
    }

    // MARK: - Private navigation

    private func showTripViewController(with trip: Trip) {
        let tripVC = TripDetailViewController.loadFromStoryboard()
        tripVC.coordinator = self
        tripVC.trip = trip
        
        self.intentDonor?.donateClipboardIntent(for: trip)

        self.navController.pushViewController(tripVC, animated: true)
    }

    private func showEditController<T: Plan>(for item: T, mode: PlanViewMode = .edit) {
        self.editCoordinator = PlanEditCoordinator(plan: item, initialMode: mode, intentDonor: self.intentDonor)
        self.navController.present(self.editCoordinator!.navController, animated: true)
    }

    private func showTripEditViewController(with trip: Trip) {
        let tripEditVC = TripEditViewController.loadFromStoryboard()
        tripEditVC.coordinator = self
        tripEditVC.trip = trip

        self.navController.present(tripEditVC, animated: true)
    }
}
