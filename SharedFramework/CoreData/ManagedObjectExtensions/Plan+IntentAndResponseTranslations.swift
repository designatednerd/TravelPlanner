//
//  Plan+IntentAndResponseTranslations.swift
//  SharedFramework
//
//  Created by Ellen Shapiro on 11/7/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import CoreData
import Foundation

extension Plan {
    
    public static func soonestForDestination(_ destination: String,
                                             origin: String?,
                                             in context: NSManagedObjectContext) -> Plan? {
        let futurePlans = self.futurePlans(in: context)
        guard !futurePlans.isEmpty else { return nil }
        
        var destinationPlans = futurePlans.filter { $0.destinationName == destination }
        
        if let origin = origin {
            destinationPlans = destinationPlans.filter { $0.originName == origin }
        }
        
        return destinationPlans.first
    }
    
    public static func fromArrivalIntent(_ intent: ArrivalTimeIntent, in context: NSManagedObjectContext) -> Plan? {
        guard let destination = intent.destination else {
            assertionFailure("No destination on intent?")
            return nil
        }
        
        guard let plan = self.soonestForDestination(destination,
                                                    origin: intent.origin,
                                                    in: context) else {
            assertionFailure("No plans for destination!")
            return nil
        }
        
        return plan
    }
    
    public static func fromDepartureIntent(_ intent: DepartureTimeIntent, in context: NSManagedObjectContext) -> Plan? {
        guard let destination = intent.destination else {
            assertionFailure("No destination on intent?")
            return nil
        }
        
        guard let plan = self.soonestForDestination(destination,
                                                    origin: intent.origin,
                                                    in: context) else {
            assertionFailure("No plans for destination!")
            return nil
        }
        
        return plan
    }
    
    public var toArrivalIntentResponse: ArrivalTimeIntentResponse {
        return .success(destination: self.destinationName,
                        method: self.methodName,
                        origin: self.originName,
                        time: self.formattedEndTime,
                        date: self.formattedEndDate)
    }
    
    public var toDepartureIntentResponse: DepartureTimeIntentResponse {
        return .success(origin: self.originName,
                        method: self.methodName,
                        destination: self.destinationName,
                        date: self.formattedStartDate,
                        time: self.formattedStartTime)
    }
}
