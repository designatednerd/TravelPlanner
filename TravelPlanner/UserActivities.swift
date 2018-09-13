//
//  UserActivities.swift
//  TravelPlanner
//
//  Created by Ellen Shapiro on 9/12/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import CoreSpotlight // for CSSearchableItemAttributeSet
import Intents // for suggestedInvocationPhrase
import MobileCoreServices // For kUTTypeContent
import SharedFramework
import UIKit

enum UserActivityType: String {
    case viewTrip = "com.designatednerd.TravelPlanner.TripView"
    
    func create(with trip: Trip) -> NSUserActivity {
        let userActivity = NSUserActivity(activityType: self.rawValue)
        
        userActivity.isEligibleForSearch = true
        userActivity.isEligibleForPrediction = true
        
        let attributes = CSSearchableItemAttributeSet(itemContentType: kUTTypeContent as String)
        
        switch self {
        case .viewTrip:
            userActivity.title = "View \(trip.name ?? "") Trip"
            userActivity.suggestedInvocationPhrase = "View \(trip.name ?? "") trip"
            userActivity.requiredUserInfoKeys = [ UserActivityInfoKey.trip.rawValue ]
            
            /*
             Don't do this - use a real identifier, preferably the same for
             both of these so it's obvious what shortcuts you need to delete if
             something changes and so if the user is constantly looking at
             the same thing they don't wind up with a zillion shortcuts.
            */
            userActivity.userInfo = [ UserActivityInfoKey.trip.rawValue: trip.name ?? "" ]
            userActivity.persistentIdentifier = NSUUID().uuidString
 
            if let destination = trip.destination {
                attributes.contentDescription = """
                🗺 \(destination)
                📅 \(trip.formattedTripInterval)
                """
            }
            
            // TODO: Y U NO WORK?!
            attributes.thumbnailData = UIImage(named: "trip")?.pngData()
        }
        
        userActivity.contentAttributeSet = attributes
        
        return userActivity
    }
}

enum UserActivityInfoKey: String {
    case trip
}


