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
    
    private var filteredAirports: [Airport]?

    let searchController = UISearchController(searchResultsController: nil)

    var currentlySelectedAirport: Airport?
    
    let completion: (Airport) -> Void
    
    private let reuseIdentifier = "AirportCell"
    
    init(title: String, currentSelectedAirport: Airport?, completion: @escaping (Airport) -> Void) {
        self.completion = completion
        self.currentlySelectedAirport = currentSelectedAirport
        super.init(style: .plain)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.reuseIdentifier)
        self.title = title
        
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "Search Airports"
        navigationItem.searchController = self.searchController
        self.definesPresentationContext = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func airport(at indexPath: IndexPath) -> Airport {
        if let filtered = self.filteredAirports {
            return filtered[indexPath.row]
        } else {
            return self.airports[indexPath.row]
        }
    }
    
    override public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredAirports?.count ?? self.airports.count
    }
    
    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.reuseIdentifier, for: indexPath)
        let airport = self.airport(at: indexPath)
        cell.textLabel?.text = airport.displayName
        
        if airport.id == self.currentlySelectedAirport?.id {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    override public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let airport = self.airport(at: indexPath)
        self.currentlySelectedAirport = airport
        tableView.reloadData()
        completion(airport)
    }
}

extension AirportSelectionViewController: UISearchResultsUpdating {
    
    var searchBarIsEmpty: Bool {
        return self.searchController.searchBar.text?.isEmpty == true
    }
    
    public func updateSearchResults(for searchController: UISearchController) {
        defer {
            self.tableView.reloadData()
        }
        
        guard !self.searchBarIsEmpty else {
            self.filteredAirports = nil
            return
        }
        
        let searchText = self.searchController.searchBar.text?.lowercased() ?? ""
        self.filteredAirports = self.airports.filter { airport in
            return (airport.name?.localizedCaseInsensitiveContains(searchText) == true)
                ||
                (airport.iataCode?.localizedCaseInsensitiveContains(searchText) == true)
                || (airport.icaoCode?.localizedCaseInsensitiveContains(searchText) == true)
        }
    }
}

