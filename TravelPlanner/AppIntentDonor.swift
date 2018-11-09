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
        let arrivalInteraction = INInteraction(intent: arrivalIntent, response: nil)
        arrivalInteraction.donate { error in
            if let error = error {
                debugPrint("Error donating arrival intent: \(error)")
            }
        }
        
        let departureIntent = DepartureTimeIntent()
        departureIntent.origin = plan.originName
        departureIntent.destination = plan.destinationName
        departureIntent.suggestedInvocationPhrase = "\(plan.destinationName) departrure"
        let departureInteraction = INInteraction(intent: departureIntent, response: nil)
        departureInteraction.donate { error in
            if let error = error {
                debugPrint("Error donating departure intent: \(error)")
            }
        }
    }
    
    func donateClipboardIntent(for trip: Trip?) {
        guard let trip = trip else {
            assertionFailure("No trip provided!")
            return
        }
        
        let intent = trip.toClipboardIntent        
        let interaction = INInteraction(intent: intent, response: nil)
        
        interaction.donate { error in
            if let error = error {
                debugPrint("Error donating clipboard intent: \(error)")
            }
        }
    }
}
