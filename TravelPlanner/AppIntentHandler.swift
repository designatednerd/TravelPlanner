//
//  AppIntentHandler.swift
//  TravelPlanner
//
//  Created by Ellen Shapiro on 11/7/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import Foundation
import Intents
import SharedFramework

struct AppIntentHandler {
    
    // MARK: - Public API

    static func isHandled(intent: INIntent) -> Bool {
        guard (intent is DepartureTimeIntent || intent is ArrivalTimeIntent) else {
            return false
        }
        
        return true
    }
    
    static func handle(intent: INIntent, with coordinator: TripCoordinator) -> Bool {
        if let arrivalIntent = intent as? ArrivalTimeIntent {
            return self.handleArrivalIntent(arrivalIntent, with: coordinator)
        } else if let departureIntent = intent as? DepartureTimeIntent {
            return self.handleDepartureIntent(departureIntent, with: coordinator)
        } else {
            assertionFailure("Shoulda checked that this intent is handled first!")
            return false
        }
    }
    
    // MARK: - Individual intent handlers
    
    private static func handleArrivalIntent(_ arrivalIntent: ArrivalTimeIntent, with coordinator: TripCoordinator) -> Bool {
        guard let plan = Plan.fromArrivalIntent(arrivalIntent, in: CoreDataManager.shared.mainContext) else {
            return false
        }
        
        coordinator.viewPlan(plan)
        return true
    }
    
    private static func handleDepartureIntent(_ departureIntent: DepartureTimeIntent, with coordinator: TripCoordinator) -> Bool {
        guard let plan = Plan.fromDepartureIntent(departureIntent, in: CoreDataManager.shared.mainContext) else {
            return false
        }
        
        coordinator.viewPlan(plan)
        return true
    }
}
