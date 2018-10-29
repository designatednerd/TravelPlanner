//
//  AppStoryboard.swift
//  TravelPlanner
//
//  Created by Ellen Shapiro (Work) on 9/10/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import UIKit
import SharedFramework

// An enum of all the Storyboards in the app, with the name of the storyboard as the raw value.
enum AppStoryboard: String, Storyboard {
    case main = "Main"

    var bundle: Bundle {
        return .main
    }
    
    var name: String {
        return self.rawValue
    }
}
