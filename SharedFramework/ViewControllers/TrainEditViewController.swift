//
//  TrainEditViewController.swift
//  TravelPlanner
//
//  Created by Ellen Shapiro (Work) on 9/10/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import UIKit

public class TrainEditViewController: UIViewController {

    public weak var coordinator: PlanEditCoordinator?
    public var train: Train!
    
    public var mode: PlanViewMode = .edit {
        didSet {
            switch self.mode {
            case .edit:
                break
            case .view:
                break
            }
        }
    }
    
    @IBAction private func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension TrainEditViewController: StoryboardHosted {
    
    public static var storyboard: Storyboard {
        return SharedStoryboard.train
    }
}

extension TrainEditViewController: PlanEditing {
    
    var contentHeight: CGFloat {
        return 0
    }
    
    func savePressed() {
        debugPrint("Save train!")
    }
    
    var plan: Plan {
        get {
            return self.train
        }
        set {
            guard let train = newValue as? Train else {
                fatalError("THIS IS NOT A TRAIN")
            }
            
            self.train = train
        }
    }
}
