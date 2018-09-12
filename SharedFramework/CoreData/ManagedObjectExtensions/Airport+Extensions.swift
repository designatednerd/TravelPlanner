//
//  Airport+Extensions.swift
//  SharedFramework
//
//  Created by Ellen Shapiro on 9/11/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import Foundation

public extension Airport {
    
    public var timeZone: TimeZone {
        guard let name = self.timeZoneName else {
            fatalError("No Time zone name for \(String(describing: self.name))")
        }
        
        guard let timeZone = TimeZone(identifier: name) else {
            fatalError("Could not create time zone from \(name)")
        }
        
        return timeZone
    }
    
    public var displayName: String {
        if let name = self.name {
            if let code = self.iataCode {
                return "\(name) (\(code))"
            } else {
                return name
            }
        }
        
        return "(unknown)"
    }
}
