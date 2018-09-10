//
//  TripEditViewController.swift
//  TravelPlanner
//
//  Created by Ellen Shapiro (Work) on 9/10/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import SharedFramework
import UIKit

class TripEditViewController: UIViewController {

    weak var coordinator: TripCoordinator?
    var trip: Trip! {
        didSet {
            self.selectedStartDate = trip.startDate
            self.selectedEndDate = trip.endDate
        }
    }

    @IBOutlet private var nameTextField: UITextField!
    @IBOutlet private var destinationTextField: UITextField!
    @IBOutlet private var startDateTextField: UITextField!
    @IBOutlet private var endDateTextField: UITextField!

    private var selectedStartDate: Date? {
        didSet {
            guard let date = self.selectedStartDate else {
                self.startDateTextField?.text = nil
                return
            }

            self.startDateTextField?.text = Formatters.shared.tripDateFormatter.string(from: date)
        }
    }

    private var selectedEndDate: Date? {
        didSet {
            guard let date = self.selectedEndDate else {
                self.endDateTextField?.text = nil
                return
            }

            self.endDateTextField?.text = Formatters.shared.tripDateFormatter.string(from: date)
        }
    }

    @IBAction private func cancel() {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction private func save() {
        guard self.validate() else { return }

        self.trip.name = self.nameTextField.text
        self.trip.destination = self.destinationTextField.text
        self.trip.startDate = self.selectedStartDate
        self.trip.endDate = self.selectedEndDate

        do {
            try self.trip.managedObjectContext?.dns_saveIfHasChanges()
            self.dismiss(animated: true, completion: nil)
        } catch let error {
            debugPrint("Error saving! \(error)")
        }
    }

    private func validate() -> Bool {
        guard self.nameTextField.text?.isEmpty == false else {
            return false
        }

        return true
    }
}

extension TripEditViewController: StoryboardHosted {}
