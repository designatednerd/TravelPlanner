//
//  Airline+Extensions.swift
//  SharedFramework
//
//  Created by Ellen Shapiro on 9/12/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import Foundation

public extension Airline {
    
    public var displayName: String {
        return self.name ?? self.callSign ?? self.iataCode ?? "(Unknown)"
    }
}
