//
//  CaseIterable+TableViewHelping.swift
//  TravelPlanner
//
//  Created by Ellen Shapiro (Work) on 9/10/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import Foundation

extension CaseIterable {

    static var allCasesArray: [Self] {
        // Since the `allCases` collection is not an array, we need to change it into one in order to subscript it.
        // Note: Documentation for `allCases` guarantees the collection will be in the order of declaration, otherwise this assumption of ordering won't work.
        return self.allCases.map { $0 }
    }

    static func forIndex(_ index: Int) -> Self {
        guard self.allCasesArray.indices.contains(index) else {
            fatalError("There is no case at index \(index) in \(Self.self)")
        }

        return self.allCasesArray[index]
    }

    static func forSection(in indexPath: IndexPath) -> Self {
        return self.forIndex(indexPath.section)
    }

    static func forRow(in indexPath: IndexPath) -> Self {
        return self.forIndex(indexPath.row)
    }
}
