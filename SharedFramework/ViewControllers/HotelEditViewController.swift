//
//  HotelEditViewController.swift
//  TravelPlanner
//
//  Created by Ellen Shapiro (Work) on 9/10/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import UIKit

public class HotelEditViewController: UIViewController {

    public weak var coordinator: PlanEditCoordinator?
    public var hotel: Hotel! {
        didSet {
            self.configure(for: self.hotel)
        }
    }
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var addressTextField: UITextField!
    @IBOutlet var cityTextField: UITextField!
    @IBOutlet var stateProvinceTextField: UITextField!
    @IBOutlet var countryTextField: UITextField!
    @IBOutlet var arrivalDatePicker: DateTimePickerContainer!
    @IBOutlet var departureDatePicker: DateTimePickerContainer!
    
    var textFields: [UITextField] {
        return [
            self.nameTextField,
            self.addressTextField,
            self.cityTextField,
            self.stateProvinceTextField,
            self.countryTextField,
            self.arrivalDatePicker.view.dateTextField,
            self.arrivalDatePicker.view.timeTextField,
            self.departureDatePicker.view.dateTextField,
            self.departureDatePicker.view.timeTextField,
        ]
    }
    
    public var mode: PlanViewMode = .edit {
        didSet {
            self.configureForMode(self.mode)
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configure(for: self.hotel)
        self.configureForMode(self.mode)
    }
    
    private func configure(for hotel: Hotel) {
        guard self.nameTextField != nil else {
            // Hasn't been set up yet
            return
        }
        
        self.nameTextField.text = hotel.name
        self.addressTextField.text = hotel.streetAddress
        self.cityTextField.text = hotel.city
        self.stateProvinceTextField.text = hotel.stateOrProvince
        self.countryTextField.text = hotel.country
        
        self.arrivalDatePicker.view.date = hotel.startDate ?? Date()
        self.departureDatePicker.view.date = hotel.endDate ?? Date()
    }
    
    private func configureForMode(_ mode: PlanViewMode) {
        guard self.nameTextField != nil else {
            // Hasn't been set up yet
            return
        }
        
        switch mode {
        case .edit:
            self.textFields.forEach { textField in
                textField.isUserInteractionEnabled = true
                textField.borderStyle = .roundedRect
            }
        case .view:
            self.textFields.forEach { textField in
                textField.isUserInteractionEnabled = false
                textField.borderStyle = .none
            }
        }
    }
    
    func validate() -> Bool {
        guard
            self.nameTextField.dns_hasText,
            self.addressTextField.dns_hasText,
            self.cityTextField.dns_hasText,
            self.stateProvinceTextField.dns_hasText,
            self.countryTextField.dns_hasText,
            self.datesAreValid else {
                return false
        }
        
        return true
    }
    
    var datesAreValid: Bool {
        let arrival = self.arrivalDatePicker.view.date
        let departure = self.departureDatePicker.view.date
        
        return arrival.dns_isBefore(departure)
    }
}

extension HotelEditViewController: StoryboardHosted {
    
    public static var storyboard: Storyboard {
        return SharedStoryboard.hotel
    }
}

extension HotelEditViewController: PlanEditing {
    
    var contentHeight: CGFloat {
        return self.departureDatePicker.frame.maxY
    }
    
    func savePressed() {
        guard self.validate() else { return }

        self.hotel.name = self.nameTextField.text
        self.hotel.streetAddress = self.addressTextField.text
        self.hotel.city = self.cityTextField.text
        self.hotel.stateOrProvince = self.stateProvinceTextField.text
        self.hotel.country = self.countryTextField.text
        self.hotel.startDate = self.arrivalDatePicker.view.date
        self.hotel.endDate = self.departureDatePicker.view.date
        
        do {
            try self.hotel.managedObjectContext?.dns_saveIfHasChanges()
            self.mode = .view
        } catch {
            debugPrint("Error saving MOC: \(error)")
        }
    }
    
    var plan: Plan {
        get {
            return self.hotel
        }
        set {
            guard let hotel = newValue as? Hotel else {
                fatalError("THIS IS NOT A Hotel")
            }
            
            self.hotel = hotel
        }
    }
}
