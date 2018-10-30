//
//  AirlineSelectionViewController.swift
//  TravelPlanner
//
//  Created by Ellen Shapiro on 9/11/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import UIKit

public class AirlineSelectionViewController: UITableViewController {
    
    private lazy var airlines: [Airline] = {
        return CoreDataManager.shared.mainContext.dns_allOf(Airline.self, sortDescriptors: [NSSortDescriptor.init(key: "name", ascending: true)])
    }()
    
    private lazy var dataSource: AirlineSelectionDataSource = {
        return AirlineSelectionDataSource(items: self.airlines,
                                          tableView: self.tableView,
                                          searchController: self.searchController)
    }()
    
    
    let searchController = UISearchController(searchResultsController: nil)
    let completion: (Airline) -> Void
    
    public init(title: String, currentSelectedAirline: Airline?, completion: @escaping (Airline) -> Void) {
        self.completion = completion
        super.init(style: .plain)
        self.title = title
        
        self.dataSource.currentlySelectedAirline = currentSelectedAirline

        self.searchController.searchResultsUpdater = self.dataSource
        self.tableView.dataSource = self.dataSource
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "Search Airlines"
        navigationItem.searchController = self.searchController
        self.definesPresentationContext = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let airline = self.dataSource.data(for: indexPath)
        self.dataSource.currentlySelectedAirline = airline
        tableView.reloadData()
        completion(airline)
    }
}
