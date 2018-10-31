//
//  SearchableSingleItemTypeDataSource.swift
//  SharedFramework
//
//  Created by Ellen Shapiro on 10/29/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import UIKit

open class SearchableTableViewDataSource<Item, Cell: UITableViewCell>: TableViewDataSource<Item, Cell>, UISearchResultsUpdating {
    
    private var filteredItems: [Item]?

    private weak var searchController: UISearchController? 
    
    init(items: [Item], tableView: UITableView, searchController: UISearchController) {
        self.searchController = searchController
        super.init(items: items, tableView: tableView)
        
        searchController.searchResultsUpdater = self
    }
    
    override open func data(for section: Int) -> [Item] {
        if let filtered = self.filteredItems {
            return filtered
        } else {
            return self.items
        }
    }
    
    public func updateSearchResults(for text: String) {
        defer {
            self.tableView?.reloadData()
        }
        
        guard !text.isEmpty else {
            self.filteredItems = nil
            return
        }
        
        let searchText = text.lowercased()
        self.filteredItems = self.items.filter { self.filterFunction(item: $0, searchText: searchText) }
    }
    
    open func filterFunction(item: Item, searchText: String) -> Bool {
        assertionFailure("This should be overridden by subclasses!")
        return false
    }
    
    // MARK: Search results updating
    
    public func updateSearchResults(for searchController: UISearchController) {
        let searchText = self.searchController?.searchBar.text?.lowercased() ?? ""
        self.updateSearchResults(for: searchText)
    }
}
