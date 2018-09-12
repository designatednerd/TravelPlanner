//
//  FlightCoordinator.swift
//  TravelPlanner
//
//  Created by Ellen Shapiro on 9/11/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import SharedFramework
import UIKit

class FlightCoordinator {
    
    private let flight: Flight
    let navController: UINavigationController
    
    init(flight: Flight) {
        self.flight = flight
        let root = FlightEditViewController.loadFromStoryboard()
        self.navController = UINavigationController(rootViewController: root)
        
        root.coordinator = self
        root.flight = flight
    }
    
    func showAirlineSelector(completion: @escaping (Airline) -> Void) {
        let selector = AirlineSelectionViewController(
            title: "Select Airline",
            currentSelectedAirline: self.flight.airline,
            completion: { [weak self] airline in
                completion(airline)
                self?.navController.popViewController(animated: true)
            })
        
        self.navController.pushViewController(selector, animated: true)
    }
    
    func showDepartureAirportSelector(completion: @escaping (Airport) -> Void) {
        self.showAirportSelector(title: "Select Departure Airport",
                                 
                                 currentSelected: self.flight.departureAirport,
                                 completion: completion)
    }
    
    func showArrivalAirportSelector(completion: @escaping (Airport) -> Void) {
        self.showAirportSelector(title: "Select Arrival Airport",
                                 currentSelected: self.flight.arrivalAirport,
                                 completion: completion)
    }
    

    private func showAirportSelector(title: String,
                                     currentSelected: Airport?,
                                     completion: @escaping (Airport) -> Void) {
        let selector = AirportSelectionViewController(
            title: title,
            currentSelectedAirport: currentSelected,
            completion: { [weak self] airport in
                completion(airport)
                self?.navController.popViewController(animated: true)
            })
        
        self.navController.pushViewController(selector, animated: true)
    }
}
