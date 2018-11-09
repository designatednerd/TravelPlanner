//
//  Trip+IntentAndResponseTranslations.swift
//  SharedFramework
//
//  Created by Ellen Shapiro on 11/8/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import CoreData
import Foundation

public extension Trip {
    
    static func fromClipboardIntent(_ intent: TripDetailClipboardIntent, in context: NSManagedObjectContext) -> Trip? {
        var predicates = [NSPredicate]()
        if let destination = intent.destination {
            let destinationPredicate = NSPredicate(keyPath: \Trip.destination, value: destination)
            predicates.append(destinationPredicate)
        }
        
        if let tripName = intent.tripName {
            let tripNamePredicate = NSPredicate(keyPath: \Trip.name, value: tripName)
            predicates.append(tripNamePredicate)
        }
        
        let finalPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        
        let sort = NSSortDescriptor(keyPath: \Trip.endDate, ascending: true)
        
        return context.dns_fetch(Trip.self,
                                           with: finalPredicate,
                                           sortDescriptors: [sort]).first
    }
    
    var toClipboardIntent: TripDetailClipboardIntent {
        let intent = TripDetailClipboardIntent()
        intent.destination = self.destination
        intent.tripName = self.name
        
        return intent 
    }
}
