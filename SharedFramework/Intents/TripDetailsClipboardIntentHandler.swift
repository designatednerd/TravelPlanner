//
//  TripDetailsClipboardIntentHandler.swift
//  SharedFramework
//
//  Created by Ellen Shapiro on 11/8/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import Intents

public class TripDetailsClipboardIntentHandler: NSObject, TripDetailClipboardIntentHandling {
    public func handle(intent: TripDetailClipboardIntent, completion: @escaping (TripDetailClipboardIntentResponse) -> Void) {
        
        guard (intent.destination != nil || intent.tripName != nil),
        let trip = Trip.fromClipboardIntent(intent, in: CoreDataManager.shared.mainContext) else {
            completion(TripDetailClipboardIntentResponse(code: .failure, userActivity: nil))
            return
        }
        
        let clipboard = trip.clipboardFormattedString
        UIPasteboard.general.setValue(clipboard, forPasteboardType: clipboard)
        
        completion(TripDetailClipboardIntentResponse(code: .success, userActivity: nil))
    }
}
