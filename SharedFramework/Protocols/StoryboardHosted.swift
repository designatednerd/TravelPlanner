//
//  StoryboardHosted.swift
//  SharedFramework
//
//  Created by Ellen Shapiro on 10/29/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import Foundation

// MARK: - Protocol for things hosted in a storyboard

public protocol StoryboardHosted: Identifiable {
    
    static var storyboard: Storyboard { get }
}

// MARK: - Default implementation for protocol for things hosted in a storyboard

public extension StoryboardHosted where Self: UIViewController {
    
    public static var identifier: String {
        return String(describing: self)
    }
    
    public static func loadFromStoryboard() -> Self {
        let vc = self.storyboard.storyboard.instantiateViewController(withIdentifier: identifier)
        guard let typedVC = vc as? Self else {
            fatalError("Could not cast VC with identifier \(self.identifier) to the correct type")
        }
        
        return typedVC
    }
}
