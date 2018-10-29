//
//  BusEditViewController.swift
//  TravelPlanner
//
//  Created by Ellen Shapiro (Work) on 9/10/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import UIKit

public class BusEditViewController: UIViewController {

    public weak var coordinator: PlanEditCoordinator?
    public var bus: Bus!
    
    @IBAction private func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension BusEditViewController: StoryboardHosted {
    
    public static var storyboard: Storyboard {
        return SharedStoryboard.bus
    }
}

extension BusEditViewController: PlanEditing {
    
    func savePressed() {
        debugPrint("Save bus!")
    }
    
    var plan: Plan {
        get {
            return self.bus
        }
        set {
            guard let bus = newValue as? Bus else {
                fatalError("THIS IS NOT A Bus")
            }
            
            self.bus = bus
        }
    }
}
