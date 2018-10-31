//
//  FlightInfoCell.swift
//  TravelPlanner
//
//  Created by Ellen Shapiro (Work) on 9/10/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import UIKit

class FlightInfoCell: UITableViewCell {

    @IBOutlet private var airlineFlightLabel: UILabel!
    @IBOutlet private var departureDateLabel: UILabel!
    @IBOutlet private var departureTimeLabel: UILabel!
    @IBOutlet private var departureAirportLabel: UILabel!
    @IBOutlet private var arrivalDateLabel: UILabel!
    @IBOutlet private var arrivalTimeLabel: UILabel!
    @IBOutlet private var arrivalAirportLabel: UILabel!
    @IBOutlet private var durationLabel: UILabel!
}

extension FlightInfoCell: NibLoadable {}

extension FlightInfoCell: PlanInfoCell {
    typealias PlanType = Flight

    func configure(for flight: Flight) {
        self.airlineFlightLabel.text = flight.flightDescription

        self.departureDateLabel.text = flight.formattedTakeoffDate
        self.departureTimeLabel.text = flight.formattedTakeoffTime
        self.departureAirportLabel.text = flight.departureAirport?.displayName

        self.arrivalDateLabel.text = flight.formattedLandingDate
        self.arrivalTimeLabel.text = flight.formattedLandingTime
        self.arrivalAirportLabel.text = flight.arrivalAirport?.displayName

        self.durationLabel.text = flight.formattedDuration
    }
}
