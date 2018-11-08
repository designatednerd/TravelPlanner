//
//  HotelInfoCell.swift
//  TravelPlanner
//
//  Created by Ellen Shapiro (Work) on 9/10/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import UIKit

class HotelInfoCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var cityStateCountryLabel: UILabel!
    @IBOutlet var arrivalDateLabel: UILabel!
    @IBOutlet var arrivalTimeLabel: UILabel!
    @IBOutlet var stayLengthLabel: UILabel!
    @IBOutlet var departureDateLabel: UILabel!
    @IBOutlet var departureTimeLabel: UILabel!

}

extension HotelInfoCell: NibLoadable {}

extension HotelInfoCell: PlanInfoCell {
    typealias PlanType = Hotel

    func configure(for hotel: Hotel) {
        self.nameLabel.text = hotel.name
        self.addressLabel.text = hotel.streetAddress
        self.cityStateCountryLabel.text = hotel.cityStateCountryText
        self.arrivalDateLabel.text = hotel.formattedArrivalDate
        self.arrivalTimeLabel.text = hotel.formattedArrivalTime
        self.stayLengthLabel.text = hotel.formattedDuration
        self.departureDateLabel.text = hotel.formattedDepartureDate
        self.departureTimeLabel.text = hotel.formattedDepartureTime
    }
}
