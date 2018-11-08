//
//  Plan+Extensions.swift
//  SharedFramework
//
//  Created by Ellen Shapiro on 11/7/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import Foundation
import CoreData

extension Plan {
    
    private static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        return dateFormatter
    }()
    
    private static let timeFormatter: DateFormatter = {
        let timeFormatter = DateFormatter()
        
        timeFormatter.dateStyle = .none
        timeFormatter.timeStyle = .short
        
        return timeFormatter
    }()
    
    public var methodName: String {
        // TODO: Localize
        switch self {
        case is Flight:
            return "plane"
        case is Train:
            return "train"
        case is Bus:
            return "bus"
        default:
            return self.unknownString.lowercased()
        }
    }
    
    public var destinationName: String {
        var string: String?
        if let flight = self as? Flight {
            string = flight.arrivalAirport?.city
        } else if let train = self as? Train {
            string = train.destination
        } else if let bus = self as? Bus {
            string = bus.destination
        }
        
        return string ?? self.unknownString
    }
    
    public var originName: String {
        var string: String?
        if let flight = self as? Flight {
            string = flight.departureAirport?.city
        } else if let train = self as? Train {
            string =  train.origin
        } else if let bus = self as? Bus {
            string = bus.origin
        }
        
        return string ?? self.unknownString
    }
    
    public var formattedStartDate: String {
        guard let startDate = self.startDate else {
            return self.unknownString
        }
        
        return Plan.dateFormatter.string(from: startDate)
    }
    
    public var formattedStartTime: String {
        guard let startDate = self.startDate else {
            return self.unknownString
        }
        
        return Plan.timeFormatter.string(from: startDate)
    }
    
    public var formattedEndDate: String {
        guard let endDate = self.endDate else {
            return self.unknownString
        }
        
        return Plan.dateFormatter.string(from: endDate)
    }
    
    public var formattedEndTime: String {
        guard let endDate = self.endDate else {
            return self.unknownString
        }
        
        return Plan.timeFormatter.string(from: endDate)
    }
    
    private var unknownString: String {
        // TODO: Localize
        return "Unknown"
    }
    
    public static func futurePlans(in context: NSManagedObjectContext) -> [Plan] {
        let endsInFuturePredicate = NSPredicate(keyPath: \Plan.endDate,
                                                operatorType: .greaterThanOrEqualTo,
                                                value: Date())
        
        let sortDescriptor = NSSortDescriptor(keyPath: \Plan.startDate, ascending: true)
        
        return context.dns_fetch(Plan.self,
                                 with: endsInFuturePredicate,
                                 sortDescriptors: [sortDescriptor])
    }
   
}
