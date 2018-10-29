//
//  UITextField+Validation.swift
//  TravelPlanner
//
//  Created by Ellen Shapiro on 9/12/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import UIKit

extension UITextField {
    
    var dns_hasText: Bool {
        guard let text = self.text else {
            return false
        }
        
        return !text.isEmpty
    }
    
    var dns_containsOnlyNumbers: Bool {
        guard let text = self.text, !text.isEmpty else {
            // Doesn't contain anything
            return false
        }
        
        return text.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
}
