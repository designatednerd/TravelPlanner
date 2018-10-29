//
//  Storyboard.swift
//  SharedFramework
//
//  Created by Ellen Shapiro on 10/29/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import UIKit

public protocol Storyboard {
    var name: String { get }
    var bundle: Bundle { get }
    var storyboard: UIStoryboard { get }
}

public extension Storyboard {
    
    public var storyboard: UIStoryboard {
        return UIStoryboard(name: self.name, bundle: self.bundle)
    }
}

public enum SharedStoryboard: String, Storyboard {
    case bus = "Bus"
    case flight = "Flight"
    case generic = "Generic"
    case hotel = "Hotel"
    case train = "Train"
    
    public var name: String {
        return self.rawValue
    }
    
    public var bundle: Bundle {
        return Bundle.dns_sharedCode
    }
}
