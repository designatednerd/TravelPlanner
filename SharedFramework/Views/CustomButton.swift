//
//  DisableableButton.swift
//  SharedFramework
//
//  Created by Ellen Shapiro on 11/7/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import UIKit

@IBDesignable
class CustomButton: UIButton {
    
    fileprivate func commonInit() {
        // Things which should always happen
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.commonInit()
    }
}

class SectionTitleButton: CustomButton {
    
    @IBInspectable var disabledTitle: String = "" {
        didSet {
            self.setTitle(self.disabledTitle, for: .disabled)
        }
    }
    
    @IBInspectable var enabledTitle: String = "" {
        didSet {
            self.setTitle(self.enabledTitle, for: .normal)
        }
    }
    
    override func commonInit() {
        self.contentHorizontalAlignment = .leading
        self.setTitleColor(.black, for: .disabled)
        self.adjustsImageWhenDisabled = false
        self.setTitle(self.disabledTitle, for: .disabled)
        self.setTitle(self.enabledTitle, for: .normal)
    }
    
    override var isEnabled: Bool {
        didSet {
            guard let titleLabel = self.titleLabel else {
                return
            }
            
            if self.isEnabled {
                titleLabel.font = UIFont.systemFont(ofSize: titleLabel.font.pointSize)
            } else {
                titleLabel.font = UIFont.boldSystemFont(ofSize: titleLabel.font.pointSize)
            }
        }
    }
}
