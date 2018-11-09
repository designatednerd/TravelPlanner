//
//  PlanCoordinator.swift
//  SharedFramework
//
//  Created by Ellen Shapiro on 11/8/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import Foundation

public class EmbeddedPlanCoordinator {
    public let plan: Plan
    public var contentHeight: CGFloat = 0
    
    public init(plan: Plan) {
        self.plan = plan
    }
    
    public func configureIn(viewController: UIViewController) {
        let vcToEmbed = PlanEditCoordinator.editControllerType(for: plan).loadFromStoryboard()
        vcToEmbed.plan = self.plan
        vcToEmbed.mode = .view
        
        viewController.dns_addChild(vcToEmbed, in: viewController.view)
        
        vcToEmbed.view.layoutIfNeeded()
        self.contentHeight = vcToEmbed.contentHeight
    }
}
