//
//  AirlineSelectionViewController.swift
//  TravelPlanner
//
//  Created by Ellen Shapiro on 9/11/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import SharedFramework
import UIKit

class AirlineSelectionViewController: UITableViewController {
    
    private lazy var airlines: [Airline] = {
        return CoreDataManager.shared.mainContext.dns_allOf(Airline.self, sortDescriptors: [NSSortDescriptor.init(key: "name", ascending: true)])
    }()
    
    private var filteredAirlines: [Airline]?
    
    
    let searchController = UISearchController(searchResultsController: nil)

    
    var currentlySelectedAirline: Airline?
    
    let completion: (Airline) -> Void
    
    private let reuseIdentifier = "AirlineCell"
    
    init(title: String, currentSelectedAirline: Airline?, completion: @escaping (Airline) -> Void) {
        self.completion = completion
        self.currentlySelectedAirline = currentSelectedAirline
        super.init(style: .plain)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.reuseIdentifier)
        self.title = title
        
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "Search Airlines"
        navigationItem.searchController = self.searchController
        self.definesPresentationContext = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func airline(at indexPath: IndexPath) -> Airline {
        if let filtered = self.filteredAirlines {
            return filtered[indexPath.row]
        } else {
            return self.airlines[indexPath.row]
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredAirlines?.count ?? self.airlines.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.reuseIdentifier, for: indexPath)
        let airline = self.airline(at: indexPath)
        
        cell.textLabel?.text = airline.displayName
        
        if airline.id == self.currentlySelectedAirline?.id {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let airline = self.airline(at: indexPath)
        self.currentlySelectedAirline = airline
        tableView.reloadData()
        completion(airline)
    }
}

extension AirlineSelectionViewController: UISearchResultsUpdating {
    
    var searchBarIsEmpty: Bool {
        return self.searchController.searchBar.text?.isEmpty == true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        defer {
            self.tableView.reloadData()
        }
        
        guard !self.searchBarIsEmpty else {
            self.filteredAirlines = nil
            return
        }
        
        let searchText = self.searchController.searchBar.text?.lowercased() ?? ""
        self.filteredAirlines = self.airlines.filter { airline in
            return (airline.name?.localizedCaseInsensitiveContains(searchText) == true)
                ||
            (airline.iataCode?.localizedCaseInsensitiveContains(searchText) == true)
            || (airline.icaoCode?.localizedCaseInsensitiveContains(searchText) == true)
        }        
    }
}
