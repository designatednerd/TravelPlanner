//
//  IntentHandler.swift
//  IntentsExtension
//
//  Created by Ellen Shapiro on 9/13/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import Intents
import SharedFramework

class IntentHandler: INExtension {
    
    override func handler(for intent: INIntent) -> Any {
        if intent is ArrivalTimeIntent {
            return ArrivalTimeIntentHandler()
        } else if intent is DepartureTimeIntent {
            return DepartureTimeIntentHandler()
        } else if intent is TripDetailClipboardIntent {
            return TripDetailsClipboardIntentHandler()
        }
        
        return self
    }
    
}
