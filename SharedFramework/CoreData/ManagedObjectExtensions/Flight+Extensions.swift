//
//  Flight+Extensions.swift
//  SharedFramework
//
//  Created by Ellen Shapiro (Work) on 9/10/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import Foundation

public extension Flight {

    public var flightDescription: String {
        return "\(self.airline!) flight \(self.flightNumber!)"
    }

    public var formattedTakeoffDate: String {
        return Formatters.shared.planDateFormatter.string(from: self.startDate!)
    }

    public var formattedTakeoffTime: String {
        return Formatters.shared.planTimeFormatter.string(from: self.startDate!)
    }

    public var formattedLandingDate: String {
        return Formatters.shared.planDateFormatter.string(from: self.endDate!)
    }

    public var formattedLandingTime: String {
        return Formatters.shared.planTimeFormatter.string(from: self.endDate!)
    }

    public var formattedDuration: String {
        return "✈️ \(Formatters.shared.planDateIntervalFormatter.string(from: self.startDate!, to: self.endDate!))"
    }
}
