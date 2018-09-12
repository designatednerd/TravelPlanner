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
    var trip: Trip!

    @IBOutlet private var nameTextField: UITextField!
    @IBOutlet private var destinationTextField: UITextField!
    @IBOutlet private var startDateTextField: UITextField!
    @IBOutlet private var endDateTextField: UITextField!
    
    private lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.addTarget(self,
                         action: #selector(pickerValueChanged(for:)),
                         for: .valueChanged)
        
        return picker
    }()

    private var selectedStartDate: Date? {
        didSet {
            guard let date = self.selectedStartDate else {
                self.startDateTextField.text = nil
                return
            }

            self.startDateTextField.text = Formatters.shared.planDateFormatter.string(from: date)
        }
    }

    private var selectedEndDate: Date? {
        didSet {
            guard let date = self.selectedEndDate else {
                self.endDateTextField?.text = nil
                return
            }

            self.endDateTextField?.text = Formatters.shared.planDateFormatter.string(from: date)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.startDateTextField.inputView = self.datePicker
        self.endDateTextField.inputView = self.datePicker
     
        self.configure(for: self.trip)
    }
    
    private func configure(for trip: Trip) {
        self.nameTextField.text = trip.name
        self.destinationTextField.text = trip.destination
        self.selectedStartDate = trip.startDate
        self.selectedEndDate = trip.endDate
    }
    
    @objc private func pickerValueChanged(for datePicker: UIDatePicker) {
        if self.startDateTextField.isFirstResponder {
            self.selectedStartDate = self.datePicker.date
        } else {
            self.selectedEndDate = self.datePicker.date
        }
    }

    @IBAction private func cancel() {
        if self.trip.dns_hasNoPersistedValues {
            CoreDataManager.shared.mainContext.delete(self.trip)
        }
        
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

extension TripEditViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField === self.startDateTextField {
            self.datePicker.date = self.selectedStartDate ?? self.selectedEndDate ?? Date()
        } else if textField === self.endDateTextField {
            self.datePicker.date = self.selectedEndDate ?? self.selectedStartDate ?? Date()
        }
        
        return true
    }
}
