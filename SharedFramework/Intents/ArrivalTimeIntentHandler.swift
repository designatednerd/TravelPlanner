//
//  ArrivalTimeResponseHandler.swift
//  SharedFramework
//
//  Created by Ellen Shapiro on 11/7/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import Intents

public class ArrivalTimeIntentHandler: NSObject, ArrivalTimeIntentHandling {
    
    public func handle(intent: ArrivalTimeIntent, completion: @escaping (ArrivalTimeIntentResponse) -> Void) {
        guard let plan = Plan.fromArrivalIntent(intent, in: CoreDataManager.shared.mainContext) else {
            if let destination = intent.destination {
                completion(.failureNoFuturePlansToDestination(destination))
            } else {
                completion(ArrivalTimeIntentResponse(code: .failureNoDestination, userActivity: nil))
            }
            return
        }

        completion(plan.toArrivalIntentResponse)
    }
    
    // OPTIONAL
    
//    public func confirm(intent: ArrivalTimeIntent, completion: @escaping (ArrivalTimeIntentResponse) -> Void) {
//        
//    }
}
