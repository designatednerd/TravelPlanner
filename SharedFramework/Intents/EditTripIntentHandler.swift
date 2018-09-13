//
//  EditTripIntentHandler.swift
//  TravelPlanner
//
//  Created by Ellen Shapiro on 9/13/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import Intents
import UIKit

public class EditTripIntentHandler: NSObject, EditTripIntentHandling {
    public func handle(intent: EditTripIntent, completion: @escaping (EditTripIntentResponse) -> Void) {
    
//        CoreDataManager.shared.workInBackground { context in
//            let name = intent.name
//            let destination = intent.destination
//            
//            let trip = Trip.dns_create(in: context)
//            trip.name = intent.name
//            trip.destination = intent.destination
//            
//            do {
//                try context.save()
//                if name != nil && destination != nil {
//                    completion(.success(name: name!, destination: destination!))
//                } else if name != nil {
//                    completion(.successNameOnly(name: name!))
//                } else if destination != nil {
//                    completion(.successDestinationOnly(destination: destination!))
//                } else {
//                    assertionFailure("We should have at least one of these!")
//                    completion(EditTripIntentResponse(code: .failure, userActivity: nil))
//                }
//            } catch let error {
//                debugPrint("Error saving MOC: \(error)")
//                completion(EditTripIntentResponse(code: .failure, userActivity: nil))
//            }
//        }
    }
    
    // OPTIONAL
    
//    public func confirm(intent: EditTripIntent, completion: @escaping (EditTripIntentResponse) -> Void) {
//
//    }
}
