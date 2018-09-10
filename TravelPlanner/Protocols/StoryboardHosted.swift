//
//  StoryboardHosted.swift
//  TravelPlanner
//
//  Created by Ellen Shapiro (Work) on 9/10/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import UIKit

// An enum of all the Storyboards in the app, with the name of the storyboard as the raw value.
enum Storyboard: String {
    case main = "Main"

    var storyboard: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: nil)
    }
}

// MARK: - Protocol for things hosted in a storyboard

protocol StoryboardHosted: Identifiable {

    static var storyboard: Storyboard { get }
}

// MARK: - Default implementation for protocol for things hosted in a storyboard

extension StoryboardHosted where Self: UIViewController {

    static var storyboard: Storyboard {
        return Storyboard.main
    }

    static var identifier: String {
        return String(describing: self)
    }

    static func loadFromStoryboard() -> Self {
        let vc = self.storyboard.storyboard.instantiateViewController(withIdentifier: identifier)
        guard let typedVC = vc as? Self else {
            fatalError("Could not cast VC with identifier \(self.identifier) to the correct type")
        }

        return typedVC
    }
}
