//
//  PlanInfoCell.swift
//  TravelPlanner
//
//  Created by Ellen Shapiro (Work) on 9/10/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import UIKit

public protocol PlanInfoCell: Identifiable {
    associatedtype PlanType: Plan

    func configure(for item: PlanType)
}

extension PlanInfoCell where Self: UITableViewCell {

    static func dequeueAndConfigure(in tableView: UITableView, at indexPath: IndexPath, for item: PlanType) -> Self {
        let cell = tableView.dequeue(Self.self, at: indexPath)
        cell.configure(for: item)

        return cell
    }
}
