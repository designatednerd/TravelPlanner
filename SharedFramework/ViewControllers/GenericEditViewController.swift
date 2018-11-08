//
//  GenericEditViewController.swift
//  SharedFramework
//
//  Created by Ellen Shapiro on 10/29/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import UIKit

public enum PlanViewMode {
    case edit
    case view
    
    func leftBarButtonItem(for target: GenericEditViewController) -> UIBarButtonItem {
        switch self {
        case .edit:
            return UIBarButtonItem(barButtonSystemItem: .cancel, target: target, action: #selector(target.cancel))
        case .view:
            return UIBarButtonItem(barButtonSystemItem: .edit, target: target, action: #selector(target.edit))
        }
    }
    
    func rightBarButtonItem(for target: GenericEditViewController) -> UIBarButtonItem {
        switch self {
        case .edit:
            return UIBarButtonItem(barButtonSystemItem: .save, target: target, action: #selector(target.save))
        case .view:
            return UIBarButtonItem(barButtonSystemItem: .done, target: target, action: #selector(target.close))

        }
    }
}

protocol PlanEditing: class {
    var plan: Plan { get set }
    var coordinator: PlanEditCoordinator? { get set }
    
    var mode: PlanViewMode { get set }
    
    func editPressed()
    func closePressed()
    func savePressed()
    func cancelPressed()
}

extension PlanEditing where Self: UIViewController {
    
    func editPressed() {
        self.mode = .edit
    }
    
    func closePressed() {
        if plan.dns_hasNoPersistedValues {
            CoreDataManager.shared.mainContext.delete(self.plan)
        } else {
            plan.dns_discardUnsavedChanges()
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func cancelPressed() {
        self.mode = .view
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
        
        self.updateBarButtonItems(for: viewController)
        
        self.embeddedView.addConstraints([
            viewController.view.topAnchor.constraint(equalTo: self.embeddedView.topAnchor),
            viewController.view.leftAnchor.constraint(equalTo: self.embeddedView.leftAnchor),
            viewController.view.bottomAnchor.constraint(equalTo: self.embeddedView.bottomAnchor),
            viewController.view.rightAnchor.constraint(equalTo: self.embeddedView.rightAnchor)
        ])
    }
    
    @objc func edit() {
        guard let vc = self.editPlanViewController else {
            assertionFailure("Trying to edit without a reference to the VC")
            return
        }
        
        vc.editPressed()
        self.updateBarButtonItems(for: vc)
    }
    
    @objc func cancel() {
        guard let vc = self.editPlanViewController else {
            assertionFailure("Trying to cancel without a reference to the VC")
            return
        }
        
        vc.cancelPressed()
        self.updateBarButtonItems(for: vc)
    }
    
    @objc func save() {
        guard let vc = self.editPlanViewController else {
            assertionFailure("Trying to save without a reference to the VC")
            return
        }
        
        self.intentDonor?.donateDepartureAndArrivalIntents(for: self.editPlanViewController?.plan)
        vc.savePressed()
        self.updateBarButtonItems(for: vc)
    }
    
    @objc func close() {
        guard let vc = self.editPlanViewController else {
            assertionFailure("Trying to close without a reference to the VC")
            return
        }
        
        vc.closePressed()
    }
    
    private func updateBarButtonItems(for vc: EditPlanViewController) {
        self.navigationItem.leftBarButtonItem = vc.mode.leftBarButtonItem(for: self)
        self.navigationItem.rightBarButtonItem = vc.mode.rightBarButtonItem(for: self)
        self.title = vc.title
    }
}

extension GenericEditViewController: StoryboardHosted {
    
    static var storyboard: Storyboard {
        return SharedStoryboard.generic
    }
}

