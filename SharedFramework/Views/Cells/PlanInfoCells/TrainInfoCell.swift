//
//  TrainInfoCell.swift
//  TravelPlanner
//
//  Created by Ellen Shapiro (Work) on 9/10/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import UIKit

class TrainInfoCell: UITableViewCell {

}

extension TrainInfoCell: NibLoadable {}

extension TrainInfoCell: PlanInfoCell {
    typealias PlanType = Train

    func configure(for item: Train) {
        // TODO
    }
}
