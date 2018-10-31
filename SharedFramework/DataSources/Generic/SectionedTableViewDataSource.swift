//
//  SectionedTableViewDataSource.swift
//  SharedFramework
//
//  Created by Ellen Shapiro on 10/31/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import UIKit

public class SectionedTableViewDataSource: NSObject, SectionedDataSource, UITableViewDataSource {
    
    public typealias DataSourceType = UITableViewDataSource
    
    public var dataSources: [UITableViewDataSource]
    
    private weak var tableView: UITableView?
    
    init(dataSources: [UITableViewDataSource], tableView: UITableView) {
        self.dataSources = dataSources
        self.tableView = tableView
    }
    
    // MARK: Data Source
    
    public func numberOfItems(for section: Int) -> Int {
        guard let tableView = self.tableView else { return 0 }

        let sectionSource = self.sectionDataSource(for: section)
        return sectionSource.tableView(tableView, numberOfRowsInSection: section)
    }
    
    // MARK: UITableViewDataSource
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return self.numberOfSections()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.numberOfItems(for: section)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionSource = self.sectionDataSource(for: indexPath)
        let updatedIndexPath = self.indexPathWithinDataSource(for: indexPath)
        
        return sectionSource.tableView(tableView, cellForRowAt: updatedIndexPath)
    }
    
    public func item<T>(ofType type: T.Type, at indexPath: IndexPath) -> T? {
        assertionFailure("Subclasses must implement this since they know how to access individual data sources")
        return nil
    }
}
