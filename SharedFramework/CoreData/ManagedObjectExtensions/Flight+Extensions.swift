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
        return "\(self.airline!.name!) flight \(self.flightNumber!)"
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
        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: self.startDate!, to: self.endDate!)
        guard let hours = dateComponents.hour,
            let minutes = dateComponents.minute else {
                return "(Unknown Duration)"
        }
        
        return "✈️ \(hours)h \(minutes)m"
    }
    
    
    public var clipboardFormattedString: String {
        let departureDate: String
        let arrivalTime: String
        
        if self.formattedStartDate == self.formattedEndDate {
            departureDate = self.formattedStartDate
            arrivalTime = self.formattedEndTime
        } else {
            departureDate = "\(self.formattedStartDate) - \(self.formattedEndDate)"
            arrivalTime = "\(self.formattedEndTime) (\(self.formattedEndDate))"
        }
        
        let departureAirport = self.departureAirport?.name ?? ""
        let arrivalAirport = self.arrivalAirport?.name ?? ""
        let airline = self.airline?.name ?? "(Unknown Carrier)"
        let flightNumber = self.flightNumber ?? "(Unknown flight number)"
        
        return """
        \(departureDate)
        ✈️ \(airline) flight \(flightNumber)
        Departs \(departureAirport) \(self.formattedStartTime)
        Arrives \(arrivalAirport) \(arrivalTime)
        """
    }
}
