//
//  Identifiable.swift
//  TravelPlanner
//
//  Created by Ellen Shapiro (Work) on 9/10/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import Foundation

public protocol Identifiable {
    static var identifier: String { get }
}

public extension Identifiable {

    public static var identifier: String {
        return String(describing: self)
    }
}
