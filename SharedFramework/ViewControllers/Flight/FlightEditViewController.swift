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
    
    public var mode: PlanViewMode = .edit {
        didSet {
            self.configureMode(self.mode)
        }
    }

    @IBOutlet private var airlineButton: UIButton!
    @IBOutlet private var airlineLabel: UILabel!
    @IBOutlet private var flightNumberTextField: UITextField!
    @IBOutlet private var departureTimePicker: DateTimePickerContainer!
    @IBOutlet private var departureAirportButton: UIButton!
    @IBOutlet private var departureAirportLabel: UILabel!
    @IBOutlet private var arrivalTimePicker: DateTimePickerContainer!
    @IBOutlet private var arrivalAirportButton: UIButton!
    @IBOutlet private var arrivalAirportLabel: UILabel!
    
    private var buttons: [UIButton] {
        return [
            self.airlineButton,
            self.departureAirportButton,
            self.arrivalAirportButton,
        ]
    }
    
    private var textFields: [UITextField] {
        return [
            self.flightNumberTextField,
            self.departureTimePicker.view.dateTextField,
            self.departureTimePicker.view.timeTextField,
            self.arrivalTimePicker.view.dateTextField,
            self.arrivalTimePicker.view.timeTextField,
        ]
    }
    
    
    private var labels: [UILabel] {
        return [
            self.airlineLabel,
            self.departureAirportLabel,
            self.arrivalAirportLabel,
        ]
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupDatePlaceholders()
        self.configure(for: self.flight)
        self.configureMode(self.mode)
    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setupDatePlaceholders()
    }
    
    private func setupDatePlaceholders() {
        self.arrivalTimePicker.view.datePlaceholder = "Arrival Date"
        self.arrivalTimePicker.view.timePlaceholder = "Arrival Time"
        self.departureTimePicker.view.datePlaceholder = "Departure Date"
        self.departureTimePicker.view.timePlaceholder = "Departure Time"
    }
    
    func configureMode(_ mode: PlanViewMode) {
        guard self.airlineButton != nil else {
            // Not loaded yet
            return
        }
        
        switch mode {
        case .edit:
            self.title = "Edit Flight"
            self.buttons.forEach { $0.isEnabled = true }
            self.textFields.forEach { textField in
                textField.isUserInteractionEnabled = true
                textField.borderStyle = .roundedRect
            }
            self.labels.forEach { $0.isHidden = true }
        case .view:
            self.title = "Your Flight"
            self.buttons.forEach { $0.isEnabled = false }
            self.textFields.forEach { textField in
                textField.isUserInteractionEnabled = false
                textField.borderStyle = .none
            }
            self.labels.forEach { $0.isHidden = false }
        }
    }
    
    private func configure(for flight: Flight) {
        configureAirlineButton()
        configureDepartureAirportButton()
        configureArrivalAirportButton()
        self.flightNumberTextField.text = flight.flightNumber ?? ""
        
        if let departure = flight.startDate {
            self.departureTimePicker.view.date = departure
        }
        
        if let arrival = flight.endDate {
            self.arrivalTimePicker.view.date =  arrival
        }
    }
    
    @IBAction func selectAirline() {
        flightCoordinator?.showAirlineSelector(completion: { [weak self] airline in
            self?.flight.airline = airline
            self?.configureAirlineButton()
        })
    }
    
    private func configureAirlineButton() {
        guard let airline = self.flight.airline else {
            self.airlineButton.setTitle("Select Airline", for: .normal)
            self.airlineLabel.text = ""
            return
        }
        
        self.airlineButton.setTitle(airline.name!, for: .normal)
        self.airlineLabel.text = airline.name!
    }
    
    @IBAction func selectArrivalAirport() {
        flightCoordinator?.showArrivalAirportSelector(completion: { [weak self] airport in
            self?.flight.arrivalAirport = airport
            self?.configureArrivalAirportButton()
        })
    }
    
    private func configureArrivalAirportButton() {
        guard let airport = self.flight.arrivalAirport else {
            self.arrivalAirportButton.setTitle("Select Arrival Airport", for: .normal)
            self.arrivalAirportLabel.text = ""
            return
        }
        
        self.arrivalAirportButton.setTitle(airport.displayName, for: .normal)
        self.arrivalAirportLabel.text = airport.displayName
    }
    
    @IBAction func selectDepartureAirport() {
        flightCoordinator?.showDepartureAirportSelector(completion: { [weak self] airport in
            self?.flight.departureAirport = airport
            self?.configureDepartureAirportButton()
        })
    }
    
    private func configureDepartureAirportButton() {
        guard let airport = self.flight.departureAirport else {
            self.departureAirportButton.setTitle("Select Departure Airport", for: .normal)
            self.departureAirportLabel.text = ""
            return
        }
        
        self.departureAirportButton.setTitle(airport.displayName, for: .normal)
        self.departureAirportLabel.text = airport.displayName
    }

    func validate() -> Bool {
        guard
            self.flight.airline != nil,
            self.flight.departureAirport != nil,
            self.flight.departureAirport != nil,
            self.flightNumberTextField.dns_hasText,
            self.flightNumberTextField.dns_containsOnlyNumbers,
            self.departureTimePicker.view.date.dns_isBefore(self.arrivalTimePicker.view.date) else {
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

extension FlightEditViewController: PlanEditing {
    
    func savePressed() {
        guard self.validate() else { return }
        
        self.flight.flightNumber = self.flightNumberTextField.text
        self.flight.startDate = self.departureTimePicker.view.date
        self.flight.endDate = self.arrivalTimePicker.view.date
        
        do {
            try self.flight.managedObjectContext?.dns_saveIfHasChanges()
            self.mode = .view
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
