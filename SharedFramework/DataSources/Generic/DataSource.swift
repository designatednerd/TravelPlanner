//
//  DataSource.swift
//  SharedFramework
//
//  Created by Ellen Shapiro on 10/29/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import Foundation

public protocol DataSource {
    associatedtype DataType
    
    func data(for section: Int) -> [DataType]
    
    func numberOfItems(for section: Int) -> Int
        
    func data(for indexPath: IndexPath) -> DataType
    
    func isSectionEmpty(_ section: Int) -> Bool
    
    func numberOfSections() -> Int
}

extension DataSource {
    
    public func sectionExists(at sectionIndex: Int) -> Bool {
        return self.numberOfSections() > sectionIndex
    }
    
    public func rowExists(at rowIndex: Int, for items: [DataType]) -> Bool {
        return items.indices.contains(rowIndex)
    }
    
    public func indexExists(at indexPath: IndexPath) -> Bool {
        guard sectionExists(at: indexPath.section) else {
            return false
        }
        
        return rowExists(at: indexPath.row, for: self.data(for: indexPath.section))
    }
    
    public func isSectionEmpty(_ section: Int) -> Bool {
        return self.data(for: section).isEmpty
    }
    
    public func numberOfItems(for section: Int) -> Int {
        return self.data(for: section).count
    }
    
    public func data(for indexPath: IndexPath) -> DataType {
        return self.data(for: indexPath.section)[indexPath.row]
    }
}


