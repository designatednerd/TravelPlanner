//
//  DataSource.swift
//  SharedFramework
//
//  Created by Ellen Shapiro on 10/29/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import Foundation

protocol DataSource {
    associatedtype DataType
    associatedtype SectionType
    
    func data(for section: Int) -> [DataType]
    
    func numberOfItems(for section: Int) -> Int
        
    func data(for indexPath: IndexPath) -> DataType
    
    func isSectionEmpty(_ section: Int) -> Bool
    
    func numberOfSections() -> Int
}

extension DataSource {
    
    func sectionExists(at sectionIndex: Int) -> Bool {
        return self.numberOfSections() > sectionIndex
    }
    
    func rowExists(at rowIndex: Int, for items: [DataType]) -> Bool {
        return items.indices.contains(rowIndex)
    }
    
    func indexExists(at indexPath: IndexPath) -> Bool {
        guard sectionExists(at: indexPath.section) else {
            return false
        }
        
        return rowExists(at: indexPath.row, for: self.data(for: indexPath.section))
    }
    
    func isSectionEmpty(_ section: Int) -> Bool {
        return self.data(for: section).isEmpty
    }
    
    func numberOfItems(for section: Int) -> Int {
        return self.data(for: section).count
    }
    
    func data(for indexPath: IndexPath) -> DataType {
        return self.data(for: indexPath.section)[indexPath.row]
    }
}

extension DataSource where SectionType: CaseIterable {
    
    func numberOfSections() -> Int {
        return SectionType.allCases.count
    }
    
    func sectionData(for indexPath: IndexPath) -> SectionType  {
        guard sectionExists(at: indexPath.section) else {
            fatalError("Section does not exist!")
        }
        
        return SectionType.dns_forSection(in: indexPath)
    }
}
