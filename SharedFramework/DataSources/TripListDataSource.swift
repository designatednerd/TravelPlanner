//
//  TripListDataSource.swift
//  SharedFramework
//
//  Created by Ellen Shapiro on 10/31/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import UIKit

public class TripListDataSource: TableViewDataSource<Trip, TripCell> {
    
    public init(tableView: UITableView) {
        let trips = CoreDataManager.shared.mainContext.dns_allOf(Trip.self)
        super.init(items: trips, tableView: tableView)
    }
    
    override public func configure(cell: TripCell, for trip: Trip) {
        cell.textLabel?.text = trip.name ?? "(Unnamed)"
        cell.detailTextLabel?.text = trip.formattedTripInterval
    }
}
