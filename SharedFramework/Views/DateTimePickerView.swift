//
//  DateTimePickerView.swift
//  SharedFramework
//
//  Created by Ellen Shapiro on 11/7/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import UIKit

public class DateTimePickerView: UIView {
    
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
    
    public var datePlaceholder: String = "Date" {
        didSet {
            self.dateTextField.placeholder = self.datePlaceholder
            self.setNeedsDisplay()
        }
    }
    
    public var timePlaceholder: String = "Time" {
        didSet {
            self.timeTextField.placeholder = self.timePlaceholder
            self.setNeedsDisplay()
        }
    }
    
    public var date: Date = Date() {
        didSet {
            self.dateTextField.text = Formatters.shared.planDateFormatter.string(from: self.date)
            self.timeTextField.text = Formatters.shared.planTimeFormatter.string(from: self.date)
            self.datePicker.date = self.date
            self.timePicker.date = self.date
        }
    }
    
    @IBOutlet public private(set) var dateTextField: UITextField!
    @IBOutlet public private(set) var timeTextField: UITextField!
    
    func commonInit() {
        self.dateTextField.inputView = self.datePicker
        self.timeTextField.inputView = self.timePicker
        self.dateTextField.placeholder = self.datePlaceholder
        self.timeTextField.placeholder = self.timePlaceholder
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        self.commonInit()
    }
    
    public override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: self.timeTextField.intrinsicContentSize.height)
    }
    
    @objc private func pickerValueChanged(for picker: UIDatePicker) {
        guard self.dateTextField.isFirstResponder || self.timeTextField.isFirstResponder else { return }
        self.date = picker.date
    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.commonInit()
    }
}

extension DateTimePickerView: NibLoadable {}
