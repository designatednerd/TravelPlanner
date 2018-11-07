//
//  DepartureTimeIntentHandler.swift
//  SharedFramework
//
//  Created by Ellen Shapiro on 11/7/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import Intents

public class DepartureTimeIntentHandler: NSObject, DepartureTimeIntentHandling {
    
    public func handle(intent: DepartureTimeIntent, completion: @escaping (DepartureTimeIntentResponse) -> Void) {
        guard let plan = Plan.fromDepartureIntent(intent, in: CoreDataManager.shared.mainContext) else {
            if let destination = intent.destination {
                completion(.failureNoFuturePlansToDestination(destination))
            } else {
                completion(DepartureTimeIntentResponse(code: .failureNoDestination, userActivity: nil))
            }
            
            return
        }
        
        completion(plan.toDepartureIntentResponse)
    }

    // MARK: - Optional Method
    
//    public func confirm(intent: DepartureTimeIntent, completion: @escaping (DepartureTimeIntentResponse) -> Void) {
//
//    }
}
