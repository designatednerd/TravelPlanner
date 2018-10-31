//
//  UITableView+Generics.swift
//  TravelPlanner
//
//  Created by Ellen Shapiro (Work) on 9/10/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import UIKit

public extension UITableView {

    public func dequeue<T: UITableViewCell>(_ type: T.Type, at indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("Couldn't get cell of proper type!")
        }

        return cell 
    }
}

extension UITableViewCell: Identifiable {}

