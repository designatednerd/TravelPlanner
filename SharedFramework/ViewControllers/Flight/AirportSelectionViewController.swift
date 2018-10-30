//
//  AirportSelectionViewController.swift
//  TravelPlanner
//
//  Created by Ellen Shapiro on 9/11/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import UIKit

public class AirportSelectionViewController: UITableViewController {
    
    private lazy var airports: [Airport] = {
        return CoreDataManager.shared.mainContext.dns_allOf(Airport.self, sortDescriptors: [NSSortDescriptor.init(key: "name", ascending: true)])
    }()
    
    private lazy var dataSource: AirportSelectionDataSource = {
        return AirportSelectionDataSource(items: self.airports,
                                          tableView: self.tableView,
                                          searchController: self.searchController)
    }()
    
    let searchController = UISearchController(searchResultsController: nil)
    let completion: (Airport) -> Void
    
    init(title: String, currentSelectedAirport: Airport?, completion: @escaping (Airport) -> Void) {
        self.completion = completion
        super.init(style: .plain)
        self.title = title
        
        self.dataSource.currentlySelectedAirport = currentSelectedAirport
        self.searchController.searchResultsUpdater = self.dataSource
        self.tableView.dataSource = self.dataSource
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "Search Airports"
        navigationItem.searchController = self.searchController
        self.definesPresentationContext = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let airport = self.dataSource.data(for: indexPath)
        self.dataSource.currentlySelectedAirport = airport
        tableView.reloadData()
        completion(airport)
    }
}

