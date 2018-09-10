//
//  Identifiable.swift
//  TravelPlanner
//
//  Created by Ellen Shapiro (Work) on 9/10/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import Foundation

protocol Identifiable {
    static var identifier: String { get }
}

extension Identifiable {

    static var identifier: String {
        return String(describing: self)
    }
}
