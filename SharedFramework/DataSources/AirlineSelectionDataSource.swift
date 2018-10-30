//
//  AirlineSelectionDataSource.swift
//  SharedFramework
//
//  Created by Ellen Shapiro on 10/29/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import UIKit

final public class AirlineSelectionDataSource: SearchableTableViewDataSource<Airline, AirlineCell> {
    
    public var currentlySelectedAirline: Airline?
    
    override public func filterFunction(item: Airline, searchText: String) -> Bool {
        return (item.name?.localizedCaseInsensitiveContains(searchText) == true)
            || (item.iataCode?.localizedCaseInsensitiveContains(searchText) == true)
            || (item.icaoCode?.localizedCaseInsensitiveContains(searchText) == true)
    }
    
    override public func configure(cell: AirlineCell, for airline: Airline) {
        cell.textLabel?.text = airline.displayName
        
        if airline.id == self.currentlySelectedAirline?.id {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
    }
}
