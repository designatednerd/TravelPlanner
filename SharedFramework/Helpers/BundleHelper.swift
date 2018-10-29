//
//  BundleHelper.swift
//  SharedFramework
//
//  Created by Ellen Shapiro on 10/29/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import Foundation

private class BundleHelper {}

public extension Bundle {
    
    public static var dns_sharedCode: Bundle {
        return Bundle(for: BundleHelper.self)
    }
}
