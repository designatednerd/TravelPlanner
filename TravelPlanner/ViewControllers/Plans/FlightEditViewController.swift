//
//  FlightEditViewController.swift
//  TravelPlanner
//
//  Created by Ellen Shapiro (Work) on 9/10/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import SharedFramework
import UIKit

class FlightEditViewController: UIViewController {

    var coordinator: TripCoordinator?
    var flight: Flight!

    @IBOutlet private var airlineNameTextField: UITextField!
    @IBOutlet private var flightNumberTextField: UITextField!
    @IBOutlet private var departureDateTextField: UITextField!
    @IBOutlet private var departureTimeTextField: UITextField!
    @IBOutlet private var originAirportTextField: UITextField!
    @IBOutlet private var arrivalDateTextField: UITextField!
    @IBOutlet private var arrivalTimeTextField: UITextField!
    @IBOutlet private var destinationAirportTextField: UITextField!


    private var departureDate = Date()
    private var arrivalDate = Date()

    @IBAction func save() {
        guard self.validate() else { return }

        self.flight.airline = self.airlineNameTextField.text
        self.flight.flightNumber = self.flightNumberTextField.text
        self.flight.startDate = self.departureDate
        self.flight.originAirport = self.originAirportTextField.text

        self.flight.endDate = self.arrivalDate
        self.flight.destinationAirport = self.destinationAirportTextField.text

        do {
            try self.flight.managedObjectContext?.dns_saveIfHasChanges()
            self.dismiss(animated: true, completion: nil)
        } catch let error {
            print("Error saving: \(error)")
        }

    }


    func validate() -> Bool {
        return false
    }

}

extension FlightEditViewController: StoryboardHosted {}
