//
//  TripInfoCell.swift
//  TravelPlanner
//
//  Created by Ellen Shapiro (Work) on 9/10/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import UIKit

public class TripInfoCell: UITableViewCell {

    @IBOutlet public var destinationLabel: UILabel!
    @IBOutlet public var startDateLabel: UILabel!
    @IBOutlet public var endDateLabel: UILabel!

    func configure(for trip: Trip) {
        self.destinationLabel.text = trip.destination ?? "(Unknown)"
        self.startDateLabel.text = trip.detailFormattedStartDate
        self.endDateLabel.text = trip.detailFormattedEndDate
    }
}

extension TripInfoCell: NibLoadable {}
