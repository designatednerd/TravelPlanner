//
//  FlightEditViewController.swift
//  TravelPlanner
//
//  Created by Ellen Shapiro (Work) on 9/10/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import UIKit

public class FlightEditViewController: UIViewController {

    public weak var coordinator: PlanEditCoordinator? {
        didSet {
            guard let planCoord = coordinator else {
                self.flightCoordinator = nil
                return
            }
            
            self.flightCoordinator = FlightCoordinator(navController: planCoord.navController, plan: planCoord.plan)
        }
    }
    
    var flightCoordinator: FlightCoordinator?
    public var flight: Flight!

    @IBOutlet private var airlineButton: UIButton!
    @IBOutlet private var flightNumberTextField: UITextField!
    @IBOutlet private var departureDateTextField: UITextField!
    @IBOutlet private var departureTimeTextField: UITextField!
    @IBOutlet private var departureAirportButton: UIButton!
    @IBOutlet private var arrivalDateTextField: UITextField!
    @IBOutlet private var arrivalTimeTextField: UITextField!
    @IBOutlet private var arrivalAirportButton: UIButton!
    
    private lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.addTarget(self,
                         action: #selector(pickerValueChanged(for:)),
                         for: .valueChanged)
        
        return picker
    }()
    
    private lazy var timePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .time
        picker.addTarget(self,
                         action: #selector(pickerValueChanged(for:)),
                         for: .valueChanged)
        
        return picker
    }()
    
    private var departureDate = Date() {
        didSet {
            let date = Formatters.shared.planDateFormatter.string(from: self.departureDate)
            self.departureDateTextField.text = date
            let time = Formatters.shared.planTimeFormatter.string(from: self.departureDate)
            self.departureTimeTextField.text = time
        }
    }
    private var arrivalDate = Date() {
        didSet {
            let date = Formatters.shared.planDateFormatter.string(from: self.arrivalDate)
            self.arrivalDateTextField.text = date
            let time = Formatters.shared.planTimeFormatter.string(from: self.arrivalDate)
            self.arrivalTimeTextField.text = time
        }
    }
    
    private var selectedAirline: Airline? {
        didSet {
            guard let airline = self.selectedAirline else {
                self.airlineButton.setTitle("Select Airline", for: .normal)
                return
            }
            
            self.airlineButton.setTitle(airline.name!, for: .normal)
        }
    }
    
    private var selectedDepartureAirport: Airport? {
        didSet {
            guard let airport = self.selectedDepartureAirport else {
                self.departureAirportButton.setTitle("Select Departure Airport", for: .normal)
                return
            }
            
            self.departureAirportButton.setTitle(airport.displayName, for: .normal)
        }
    }
    
    private var selectedArrivalAirport: Airport? {
        didSet {
            guard let airport = self.selectedArrivalAirport else {
                self.arrivalAirportButton.setTitle("Select Departure Airport", for: .normal)
                return
            }
            
            self.arrivalAirportButton.setTitle(airport.displayName, for: .normal)
        }
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Edit Flight"
        self.configure(for: self.flight)
        
        self.departureDateTextField.inputView = self.datePicker
        self.departureTimeTextField.inputView = self.timePicker
        
        self.arrivalDateTextField.inputView = self.datePicker
        self.arrivalTimeTextField.inputView = self.timePicker
    }
    
    @objc private func pickerValueChanged(for datePicker: UIDatePicker) {
        if datePicker === self.datePicker {
            if self.departureDateTextField.isFirstResponder {
                self.departureDate = datePicker.date
            } else {
                self.arrivalDate = datePicker.date
            }
        } else if datePicker === self.timePicker {
            if self.departureTimeTextField.isFirstResponder {
                self.departureDate = datePicker.date
            } else {
                self.arrivalDate = datePicker.date
            }
        }
    }
    
    private func configure(for flight: Flight) {
        self.selectedAirline = flight.airline
        self.selectedArrivalAirport = flight.arrivalAirport
        self.selectedDepartureAirport = flight.departureAirport
        self.flightNumberTextField.text = flight.flightNumber ?? ""
        
        if let departure = flight.startDate {
            self.departureDate = departure
        }
        
        if let arrival = flight.endDate {
            self.arrivalDate = arrival
        }
    }
    
    @IBAction func selectAirline() {
        flightCoordinator?.showAirlineSelector(completion: { [weak self] airline in
            self?.selectedAirline = airline
        })
    }
    
    @IBAction func selectArrivalAirport() {
        flightCoordinator?.showArrivalAirportSelector(completion: { [weak self] airport in
            self?.selectedArrivalAirport = airport
        })
    }
    
    @IBAction func selectDepartureAirport() {
        flightCoordinator?.showDepartureAirportSelector(completion: { [weak self] airport in
            self?.selectedDepartureAirport = airport
        })
    }

    func validate() -> Bool {
        guard
            self.selectedAirline != nil,
            self.selectedArrivalAirport != nil,
            self.selectedDepartureAirport != nil,
            self.flightNumberTextField.dns_hasText,
            self.flightNumberTextField.dns_containsOnlyNumbers else {
                return false
        }

        return true
    }

}

extension FlightEditViewController: StoryboardHosted {
    
    public static var storyboard: Storyboard {
        return SharedStoryboard.flight
    }
}

extension FlightEditViewController: UITextFieldDelegate {
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField === self.departureTimeTextField {
            self.timePicker.date = self.departureDate
        } else if textField === self.departureDateTextField {
            self.datePicker.date = self.departureDate
        } else if textField === self.arrivalTimeTextField {
            self.timePicker.date = self.arrivalDate
        } else if textField === self.arrivalDateTextField {
            self.datePicker.date = self.arrivalDate
        }
        
        return true
    }
}


extension FlightEditViewController: PlanEditing {
    
    func savePressed() {
        guard self.validate() else { return }
        
        self.flight.airline = self.selectedAirline
        self.flight.flightNumber = self.flightNumberTextField.text
        self.flight.startDate = self.departureDate
        self.flight.departureAirport = self.selectedDepartureAirport
        
        self.flight.endDate = self.arrivalDate
        self.flight.arrivalAirport = self.selectedArrivalAirport
        
        do {
            try self.flight.managedObjectContext?.dns_saveIfHasChanges()
            if let parent = self.parent {
                parent.dismiss(animated: true, completion: nil)
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        } catch let error {
            print("Error saving: \(error)")
        }
    }
    
    var plan: Plan {
        get {
            return self.flight
        }
        set {
            guard let flight = newValue as? Flight else {
                fatalError("THIS IS NOT A FLIGHT")
            }
            
            self.flight = flight
        }
    }
}
