//
//  BusInfoCell.swift
//  TravelPlanner
//
//  Created by Ellen Shapiro (Work) on 9/10/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import UIKit
import SharedFramework

class BusInfoCell: UITableViewCell {

}

extension BusInfoCell: NibLoadable {}

extension BusInfoCell: PlanInfoCell {

    typealias PlanType = Bus

    func configure(for item: Bus) {
        //TODO
    }
}


