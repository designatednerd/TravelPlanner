//
//  Trip+Extensions.swift
//  TravelPlanner
//
//  Created by Ellen Shapiro (Work) on 9/10/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import Foundation
import CoreData

public extension Trip {

    public var formattedStartDate: String {
        guard let date = self.startDate else {
            return "(Unknown)"
        }

        return Formatters.shared.tripDateFormatter.string(from: date)
    }
    
    public var detailFormattedStartDate: String {
        guard let date = self.startDate else {
            return "(Unknown)"
        }
        
        return Formatters.shared.planDateFormatter.string(from: date)
    }

    public var formattedEndDate: String {
        guard let date = self.endDate else {
            return "(Unknown)"
        }

        return Formatters.shared.tripDateFormatter.string(from: date)
    }
    
    public var detailFormattedEndDate: String {
        guard let date = self.endDate else {
            return "(Unknown)"
        }
        
        return Formatters.shared.planDateFormatter.string(from: date)
    }

    public var formattedTripInterval: String {
        if
            let start = self.startDate,
            let end = self.endDate {
                return Formatters.shared.tripDateIntervalFormatter.string(from: start, to: end)
        }

        return "\(self.formattedStartDate) - \(self.formattedEndDate)"
    }

    public var planCount: Int {
        return self.plans?.count ?? 0
    }

    public var plansByDate: [Plan] {
        guard let plans = self.plans as? Set<Plan> else {
            return []
        }

        return plans.sorted { $0.startDate ?? Date.distantPast < $1.startDate ?? Date.distantFuture }
    }
    
    public var clipboardFormattedString: String {
        let plans = self.plansByDate
        guard !plans.isEmpty else {
            return "No Plans Yet"
        }

        let planString = plans
            .compactMap { plan -> String? in
                if let flight = plan as? Flight {
                    return flight.clipboardFormattedString
                } else if let train = plan as? Train {
                    return train.clipboardFormattedString
                } else if let hotel = plan as? Hotel {
                    return hotel.clipboardFormattedString
                } else if let bus = plan as? Bus {
                    return "🚌: \(bus.carrier ?? "TODO")"
                } else {
                    assertionFailure("Unhandled type!")
                    return nil
                }
            }
            .joined(separator: "\n\n")
        
        let name = self.name ?? "(Unnamed Trip)"
        let destination = self.destination ?? "(Unknown Destination)"
        
        return """
        Trip Name: \(name)
        Destination: \(destination)
        
        \(planString)
        """
    }
}
