//
//  HotelEditViewController.swift
//  TravelPlanner
//
//  Created by Ellen Shapiro (Work) on 9/10/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import UIKit

public class HotelEditViewController: UIViewController {

    public weak var coordinator: PlanEditCoordinator?
    public var hotel: Hotel!

    @IBAction private func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension HotelEditViewController: StoryboardHosted {
    
    public static var storyboard: Storyboard {
        return SharedStoryboard.hotel
    }
}

extension HotelEditViewController: PlanEditing {
    
    func savePressed() {
        debugPrint("Save hotel!")
    }
    
    var plan: Plan {
        get {
            return self.hotel
        }
        set {
            guard let hotel = newValue as? Hotel else {
                fatalError("THIS IS NOT A Hotel")
            }
            
            self.hotel = hotel
        }
    }
}
