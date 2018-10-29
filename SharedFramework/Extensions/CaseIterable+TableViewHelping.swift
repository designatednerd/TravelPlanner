//
//  CaseIterable+TableViewHelping.swift
//  TravelPlanner
//
//  Created by Ellen Shapiro (Work) on 9/10/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import Foundation

public extension CaseIterable {

    public static var dns_allCasesArray: [Self] {
        // Since the `allCases` collection is not an array, we need to change it into one in order to subscript it.
        // Note: Documentation for `allCases` guarantees the collection will be in the order of declaration, otherwise this assumption of ordering won't work.
        return self.allCases.map { $0 }
    }

    public static func dns_forIndex(_ index: Int) -> Self {
        guard self.dns_allCasesArray.indices.contains(index) else {
            fatalError("There is no case at index \(index) in \(Self.self)")
        }

        return self.dns_allCasesArray[index]
    }

    public static func dns_forSection(in indexPath: IndexPath) -> Self {
        return self.dns_forIndex(indexPath.section)
    }

    public static func dns_forRow(in indexPath: IndexPath) -> Self {
        return self.dns_forIndex(indexPath.row)
    }
}
