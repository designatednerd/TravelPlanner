//
//  IntentViewController.swift
//  IntentUIExtension
//
//  Created by Ellen Shapiro on 11/8/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import IntentsUI
import SharedFramework

// As an example, this extension's Info.plist has been configured to handle interactions for INSendMessageIntent.
// You will want to replace this or add other intents as appropriate.
// The intents whose interactions you wish to handle must be declared in the extension's Info.plist.

// You can test this example integration by saying things to Siri like:
// "Send a message using <myApp>"

class IntentViewController: UIViewController, INUIHostedViewControlling {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
        
    // MARK: - INUIHostedViewControlling
    
    // Prepare your view controller for the interaction to handle.
    func configureView(for parameters: Set<INParameter>,
                       of interaction: INInteraction,
                       interactiveBehavior: INUIInteractiveBehavior,
                       context: INUIHostedViewContext,
                       completion: @escaping (Bool, Set<INParameter>, CGSize) -> Void) {
        // Do configuration here, including preparing views and calculating a desired size for presentation.
        var plan: Plan? = nil
        let moc = CoreDataManager.shared.mainContext
        if let departureIntent = interaction.intent as? DepartureTimeIntent {
            plan = Plan.fromDepartureIntent(departureIntent, in: moc)
        } else if let arrivalIntent = interaction.intent as? ArrivalTimeIntent {
            plan = Plan.fromArrivalIntent(arrivalIntent, in: moc)
        }
        
        guard let retrievedPlan = plan else {
            completion(false, parameters, .zero)
            return
        }
        
        let coordinator = EmbeddedPlanCoordinator(plan: retrievedPlan)
        coordinator.configureIn(viewController: self)
        
        
        completion(true, parameters, self.desiredSize)
    }
    
    var desiredSize: CGSize {
        return self.extensionContext!.hostedViewMaximumAllowedSize
    }
    
}
