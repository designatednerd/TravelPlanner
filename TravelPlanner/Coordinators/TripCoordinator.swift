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

    var flightCoordinator: FlightCoordinator?
    
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

    // MARK: - Private navigation

    private func showTripViewController(with trip: Trip) {
        let tripVC = TripDetailViewController.loadFromStoryboard()
        tripVC.coordinator = self
        tripVC.trip = trip

        self.navController.pushViewController(tripVC, animated: true)
    }

    private func showEditController<T: Plan>(for item: T) {
        if let bus = item as? Bus {
            self.showBusEditViewController(for: bus)
        } else if let flight = item as? Flight {
            self.showFlightEditViewController(for: flight)
        } else if let hotel = item as? Hotel {
            self.showHotelEditViewController(for: hotel)
        } else if let train = item as? Train {
            self.showTrainEditViewController(for: train)
        } else {
            fatalError("Unhandled item type: \(type(of: item))")
        }
    }

    private func showBusEditViewController(for bus: Bus) {
        let busEditVC = BusEditViewController()
        busEditVC.coordinator = self
        busEditVC.bus = bus

        self.navController.present(busEditVC, animated: true)
    }

    private func showHotelEditViewController(for hotel: Hotel) {
        let hotelEditVC = HotelEditViewController()
        hotelEditVC.coordinator = self
        hotelEditVC.hotel = hotel

        self.navController.present(hotelEditVC, animated: true)
    }

    private func showFlightEditViewController(for flight: Flight) {
        self.flightCoordinator = FlightCoordinator(flight: flight)
        self.navController.present(self.flightCoordinator!.navController, animated: true)
    }

    private func showTrainEditViewController(for train: Train) {
        let trainEditVC = TrainEditViewController()
        trainEditVC.train = train
        trainEditVC.coordinator = self

        self.navController.present(trainEditVC, animated: true)
    }

    private func showTripEditViewController(with trip: Trip) {
        let tripEditVC = TripEditViewController.loadFromStoryboard()
        tripEditVC.coordinator = self
        tripEditVC.trip = trip

        self.navController.present(tripEditVC, animated: true)
    }
}
