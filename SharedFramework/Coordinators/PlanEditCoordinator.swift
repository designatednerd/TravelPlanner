//
//  PlanEditCoordinator.swift
//  SharedFramework
//
//  Created by Ellen Shapiro on 10/29/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import UIKit

public class PlanEditCoordinator {
    let plan: Plan
    public let navController: UINavigationController
    
    /// Initializes with a nav controller that's already been spun up
    ///
    /// - Parameters:
    ///   - navController: A navigation controller with a root VC which should already exist.
    ///   - plan: The plan associated with this coordinator.
    init(navController: UINavigationController, plan: Plan) {
        self.navController = navController
        self.plan = plan
    }
    
    /// Designated initializer
    ///
    /// - Parameter plan: The plan to spin up a nav controller for
    public init(plan: Plan) {
        self.plan = plan
        let generic = GenericEditViewController.loadFromStoryboard()
        self.navController = UINavigationController(rootViewController: generic)
        
        var embedded = PlanEditCoordinator.editControllerType(for: plan).loadFromStoryboard()
        
        generic.embed(viewController: embedded)
        embedded.plan = plan
        embedded.coordinator = self
    }
    
    private static func editControllerType(for item: Plan) -> EditPlanViewController.Type {
        if item is Bus {
            return BusEditViewController.self
        } else if item is Flight {
            return FlightEditViewController.self
        } else if item is Hotel {
            return HotelEditViewController.self
        } else if item is Train {
            return TrainEditViewController.self
        } else {
            fatalError("Unhandled item type: \(type(of: item))")
        }
    }
}
