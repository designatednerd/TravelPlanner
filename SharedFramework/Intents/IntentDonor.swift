//
//  IntentDonor.swift
//  SharedFramework
//
//  Created by Ellen Shapiro on 11/7/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import Foundation

public protocol IntentDonor {
    
    func donateDepartureAndArrivalIntents(for: Plan?)
}
