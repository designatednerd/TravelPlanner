//
//  Train+Extensions.swift
//  SharedFramework
//
//  Created by Ellen Shapiro on 11/8/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import Foundation

public extension Train {
    
    public var clipboardFormattedString: String {
        let company = self.companyName ?? "(Unknown Company)"
        let number = self.trainNumber ?? "(Unknown Train Number)"
        
        let dateLine: String
        let arrival: String
        if self.formattedStartDate == self.formattedEndDate {
            dateLine = self.formattedStartDate
            arrival = self.formattedEndTime
        } else {
            dateLine = "\(self.formattedStartDate) - \(self.formattedEndDate)"
            arrival = "\(self.formattedEndTime) (\(self.formattedEndDate))"
        }
        return """
        \(dateLine)🚃 \(company) \(number)
        Departs \(self.originName) \(self.formattedStartTime)
        Arrives \(self.destinationName) \(arrival)
        """
    }
}
