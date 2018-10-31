//
//  SectionedDataSource.swift
//  SharedFramework
//
//  Created by Ellen Shapiro on 10/31/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import Foundation

public protocol SectionedDataSource {
    associatedtype DataSourceType
    
    var dataSources: [DataSourceType] { get set }
    
    func numberOfSections() -> Int
    
    func numberOfItems(for section: Int) -> Int
    
    func sectionDataSource(for section: Int) -> DataSourceType
    
    func sectionDataSource(for indexPath: IndexPath) -> DataSourceType
    
    func item<T>(ofType type: T.Type, at indexPath: IndexPath) -> T? 
}

extension SectionedDataSource {
    
    public func numberOfSections() -> Int {
        return self.dataSources.count
    }
    
    public func sectionExists(at sectionIndex: Int) -> Bool {
        return self.numberOfSections() > sectionIndex
    }
    
    public func sectionDataSource(for section: Int) -> DataSourceType {
        guard sectionExists(at: section) else {
            fatalError("Section does not exist!")
        }
        
        return self.dataSources[section]
    }
    
    public func sectionDataSource(for indexPath: IndexPath) -> DataSourceType {
        return self.sectionDataSource(for: indexPath.section)
    }
    
    public func indexPathWithinDataSource(for indexPath: IndexPath) -> IndexPath {
        return IndexPath(item: indexPath.item, section: 0)
    }
}
