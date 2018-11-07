//
//  IntentDonor.swift
//  TravelPlanner
//
//  Created by Ellen Shapiro on 11/7/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import Intents
import SharedFramework

struct AppIntentDonor: IntentDonor {
    
    func donateDepartureAndArrivalIntents(for plan: Plan?) {
        guard
            let plan = plan,
            !(plan is Hotel) else {
                // Nothing to donate
                return
        }
                
        let arrivalIntent = ArrivalTimeIntent()
        arrivalIntent.origin = plan.originName
        arrivalIntent.destination = plan.destinationName
        arrivalIntent.suggestedInvocationPhrase = "\(plan.destinationName) arrival"
        let arrivalInteraction = INInteraction(intent: arrivalIntent, response: plan.toArrivalIntentResponse)
        arrivalInteraction.donate { error in
            if let error = error {
                debugPrint("Error donating arrival intent: \(error)")
            }
        }
        
        let departureIntent = DepartureTimeIntent()
        departureIntent.origin = plan.originName
        departureIntent.destination = plan.destinationName
        departureIntent.suggestedInvocationPhrase = "\(plan.destinationName) departure"
        let departureInteraction = INInteraction(intent: departureIntent, response: plan.toDepartureIntentResponse)
        departureInteraction.donate { error in
            if let error = error {
                debugPrint("Error donating departure intent: \(error)")
            }
        }
    }
}
