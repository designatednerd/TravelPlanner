//
//  TripCell.swift
//  SharedFramework
//
//  Created by Ellen Shapiro on 10/31/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import UIKit

public class TripCell: UITableViewCell {
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        // Force subtitle style
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
