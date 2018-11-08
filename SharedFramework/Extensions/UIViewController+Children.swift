//
//  UIViewController+Children.swift
//  SharedFramework
//
//  Created by Ellen Shapiro on 11/8/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func dns_addChild(_ childViewController: UIViewController, in childContainer: UIView) {
        
        // NOTE: These must be in this order, because of course they must.
        self.addChild(childViewController)
        childViewController.view.translatesAutoresizingMaskIntoConstraints = false
        childContainer.addSubview(childViewController.view)
        childViewController.didMove(toParent: self)
        
        childContainer.addConstraints([
            childViewController.view.topAnchor.constraint(equalTo: childContainer.topAnchor),
            childViewController.view.leftAnchor.constraint(equalTo: childContainer.leftAnchor),
            childViewController.view.bottomAnchor.constraint(equalTo: childContainer.bottomAnchor),
            childViewController.view.rightAnchor.constraint(equalTo: childContainer.rightAnchor)
        ])
    }
}
