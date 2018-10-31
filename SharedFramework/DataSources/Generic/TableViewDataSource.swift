//
//  TableViewDataSource.swift
//  SharedFramework
//
//  Created by Ellen Shapiro on 10/29/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import UIKit

public typealias IdentifiableCell = UITableViewCell & Identifiable
public typealias NibLoadableCell = UITableViewCell & NibLoadable

open class TableViewDataSource<Item, Cell: UITableViewCell>: NSObject, UITableViewDataSource, DataSource, Reloadable {

    public typealias DataType = Item
    
    private(set) weak var tableView: UITableView?
    private(set) var items: [Item]
    
    init(items: [Item], tableView: UITableView) {
        if (Cell.self is NibLoadable.Type) {
            (Cell.self as! NibLoadableCell.Type).register(in: tableView)
        } else {
            tableView.register(Cell.self, forCellReuseIdentifier: Cell.identifier)
        }
        
        self.tableView = tableView
        self.items = items
    }
    
    // MARK: - Data Source Protocol
    
    open func data(for section: Int) -> [Item] {
        return self.items
    }
    
    open func numberOfSections() -> Int {
        return 1
    }
    
    // MARK: - UITableViewDataSource
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return self.numberOfSections()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.numberOfItems(for: section)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cell.identifier, for: indexPath) as? Cell else {
            assertionFailure("Could not get table view cell of appropriate type!")
            return UITableViewCell()
        }
        
        let item = self.data(for: indexPath)
        self.configure(cell: cell, for: item)
        
        return cell
    }
    
    open func configure(cell: Cell, for item: Item) {
        assertionFailure("Subclasses must override!")
    }
    
    open func replaceItems(with items: [Item]) {
        self.items = items
    }
    
    open func reloadData() {
        self.tableView?.reloadData()
    }
    
}

