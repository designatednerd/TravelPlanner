//
//  NibLoadable.swift
//  TravelPlanner
//
//  Created by Ellen Shapiro (Work) on 9/10/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import UIKit

public protocol NibLoadable: class {

    static var bundle: Bundle { get }
    static var nibName: String { get }
}

extension NibLoadable {

    public static var nibName: String {
        return String(describing: self)
    }

    public static var nib: UINib {
        return UINib(nibName: self.nibName, bundle: self.bundle)
    }

    public static var fromNib: Self {
        guard let nibContents = self.bundle.loadNibNamed(self.nibName, owner: nil) else {
            fatalError("Could not load \(self.nibName) from bundle.")
        }

        guard let loaded = nibContents.first as? Self else {
            fatalError("First object in the nib is not a \(self)")
        }

        return loaded
    }
    
    public static var bundle: Bundle {
        return Bundle(for: Self.self)
    }
}

extension NibLoadable where Self: UITableViewCell {

    public static func register(in tableView: UITableView) {
        tableView.register(self.nib, forCellReuseIdentifier: self.identifier)
    }
}
