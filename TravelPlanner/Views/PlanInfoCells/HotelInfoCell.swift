//
//  HotelInfoCell.swift
//  TravelPlanner
//
//  Created by Ellen Shapiro (Work) on 9/10/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import SharedFramework
import UIKit

class HotelInfoCell: UITableViewCell {

}

extension HotelInfoCell: NibLoadable {}

extension HotelInfoCell: PlanInfoCell {
    typealias PlanType = Hotel

    func configure(for item: Hotel) {
        // TODO
    }
}
