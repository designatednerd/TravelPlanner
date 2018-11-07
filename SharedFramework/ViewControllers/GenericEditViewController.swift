//
//  GenericEditViewController.swift
//  SharedFramework
//
//  Created by Ellen Shapiro on 10/29/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import UIKit

protocol PlanEditing {
    var plan: Plan { get set }
    var coordinator: PlanEditCoordinator? { get set }
    
    func savePressed()
    func cancelPressed()
}

extension PlanEditing where Self: UIViewController {
    
    func cancelPressed() {
        if plan.dns_hasNoPersistedValues {
            CoreDataManager.shared.mainContext.delete(self.plan)
        } else {
            plan.dns_discardUnsavedChanges()
        }
        
        self.dismiss(animated: true, completion: nil)
    }
}

typealias EditPlanViewController = UIViewController & PlanEditing & StoryboardHosted

class GenericEditViewController: UIViewController {
    
    var editPlanViewController: EditPlanViewController?
    
    var intentDonor: IntentDonor?
    
    @IBOutlet private var embeddedView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let editVC = self.editPlanViewController {
            self.embed(viewController: editVC)
        }
    }
    
    func embed(viewController: EditPlanViewController) {
        guard self.embeddedView != nil else {
            // The view hasn't loaded yet, store this and come back to it.
            self.editPlanViewController = viewController
            return
        }
        
        // NOTE: These must be in this order, because of course they must.
        self.addChild(viewController)
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        self.embeddedView.addSubview(viewController.view)
        viewController.didMove(toParent: self)
        
        self.embeddedView.addConstraints([
            viewController.view.topAnchor.constraint(equalTo: self.embeddedView.topAnchor),
            viewController.view.leftAnchor.constraint(equalTo: self.embeddedView.leftAnchor),
            viewController.view.bottomAnchor.constraint(equalTo: self.embeddedView.bottomAnchor),
            viewController.view.rightAnchor.constraint(equalTo: self.embeddedView.rightAnchor)
        ])
        
    }
    
    @IBAction func cancel() {
        guard let vc = self.editPlanViewController else {
            assertionFailure("Trying to save without a reference to the VC")
            return
        }
        
        vc.cancelPressed()
    }
    
    @IBAction func save() {
        guard let vc = self.editPlanViewController else {
            assertionFailure("Trying to save without a reference to the VC")
            return
        }
        
        self.intentDonor?.donateDepartureAndArrivalIntents(for: self.editPlanViewController?.plan)
        vc.savePressed()
    }
}

extension GenericEditViewController: StoryboardHosted {
    
    static var storyboard: Storyboard {
        return SharedStoryboard.generic
    }
}

