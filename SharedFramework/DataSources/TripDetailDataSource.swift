//
//  TripDetailDataSource.swift
//  SharedFramework
//
//  Created by Ellen Shapiro on 10/31/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import UIKit

public class TripDetailDataSource: SectionedTableViewDataSource {
    
    private let trip: Trip
    
    public init(trip: Trip, tableView: UITableView) {
        self.trip = trip
        
        let dataSources: [UITableViewDataSource] = [
            TripInfoDataSource(trip: trip, tableView: tableView),
            PlanInfoDataSource(plans: trip.plansByDate, tableView: tableView)
        ]
        
        super.init(dataSources: dataSources, tableView: tableView)
    }
    
    override public func item<T>(ofType type: T.Type, at indexPath: IndexPath) -> T? {
        guard self.sectionExists(at: indexPath.section) else { return nil }
        
        let dataSource = self.sectionDataSource(for: indexPath)
        let updatedIndex = self.indexPathWithinDataSource(for: indexPath)

        if let source = dataSource as? TripInfoDataSource {
            return source.data(for: updatedIndex) as? T
        } else if let source = dataSource as? PlanInfoDataSource {
            return source.data(for: updatedIndex) as? T
        } else {
            return nil
        }
    }
}

class TripInfoDataSource: TableViewDataSource<Trip, TripInfoCell> {
    
    init(trip: Trip, tableView: UITableView) {
        super.init(items: [trip], tableView: tableView)
    }
    
    override func configure(cell: TripInfoCell, for trip: Trip) {
        cell.configure(for: trip)
    }
}

class PlanInfoDataSource: TableViewDataSource<Plan, UITableViewCell> {
    
    init(plans: [Plan], tableView: UITableView) {
        
        FlightInfoCell.register(in: tableView)
        BusInfoCell.register(in: tableView)
        HotelInfoCell.register(in: tableView)
        TrainInfoCell.register(in: tableView)
        
        super.init(items: plans, tableView: tableView)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let plan = self.data(for: indexPath)
        
        if let flight = plan as? Flight {
            return FlightInfoCell.dequeueAndConfigure(in: tableView, at: indexPath, for: flight)
        } else if let bus = plan as? Bus {
            return BusInfoCell.dequeueAndConfigure(in: tableView, at: indexPath, for: bus)
        } else if let hotel = plan as? Hotel {
            return HotelInfoCell.dequeueAndConfigure(in: tableView, at: indexPath, for: hotel)
        } else if let train = plan as? Train {
            return TrainInfoCell.dequeueAndConfigure(in: tableView, at: indexPath, for: train)
        } else {
            fatalError("Unhandled plan type: \(type(of: plan))")
        }
    }
    
}
