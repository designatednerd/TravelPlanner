//
//  AirportSelectionDataSource.swift
//  SharedFramework
//
//  Created by Ellen Shapiro on 10/30/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import UIKit

final public class AirportSelectionDataSource: SearchableTableViewDataSource<Airport, AirportCell> {
    
    public var currentlySelectedAirport: Airport?
    
    public override func filterFunction(item: Airport, searchText: String) -> Bool {
        return (item.name?.localizedCaseInsensitiveContains(searchText) == true)
            || (item.iataCode?.localizedCaseInsensitiveContains(searchText) == true)
            || (item.icaoCode?.localizedCaseInsensitiveContains(searchText) == true)
    }
    
    public override func configure(cell: AirportCell, for airport: Airport) {
        cell.textLabel?.text = airport.displayName
        
        if airport.id == self.currentlySelectedAirport?.id {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
    }
}
