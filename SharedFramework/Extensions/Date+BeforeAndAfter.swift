//
//  Date+BeforeAndAfter.swift
//  SharedFramework
//
//  Created by Ellen Shapiro on 11/7/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import Foundation

extension Date {
    
    func dns_isBefore(_ otherDate: Date) -> Bool {
        return self.compare(otherDate) == .orderedAscending
    }
    
    func dns_isAfter(_ otherDate: Date) -> Bool {
        return self.compare(otherDate) == .orderedDescending
    }
    
    func dns_isEqual(to otherDate: Date) -> Bool {
        return self.compare(otherDate) == .orderedSame
    }
}
