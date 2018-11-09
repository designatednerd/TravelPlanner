//
//  Hotel+Extensions.swift
//  SharedFramework
//
//  Created by Ellen Shapiro on 11/7/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import Foundation

extension Hotel {
    
    public var cityStateCountryText: String {
        guard
            let city = self.city,
            let state = self.stateOrProvince,
            let country = self.country else {
                return ""
        }
        
        return "\(city), \(state), \(country)"
    }
    
    public var formattedArrivalDate: String {
        return Formatters.shared.planDateFormatter.string(from: self.startDate!)
    }
    
    public var formattedArrivalTime: String {
        return Formatters.shared.planTimeFormatter.string(from: self.startDate!)
    }
    
    public var formattedDepartureDate: String {
        return Formatters.shared.planDateFormatter.string(from: self.endDate!)
    }
    
    public var formattedDepartureTime: String {
        return Formatters.shared.planTimeFormatter.string(from: self.endDate!)
    }
    
    public var formattedDuration: String {
        let dateComponents = Calendar.current.dateComponents([.day, .hour], from: self.startDate!, to: self.endDate!)
        guard
            let days = dateComponents.day,
            let hours = dateComponents.hour else {
                return "(Unknown Duration)"
        }
        
        return "🏨 \(days)d \(hours)h"
    }
    
    public var clipboardFormattedString: String {
        return """
        \(self.formattedArrivalDate) - \(self.formattedDepartureDate)
        🏨 \(self.name ?? "(Unknown hotel)")
        \(self.cityStateCountryText)
        """
    }
}
