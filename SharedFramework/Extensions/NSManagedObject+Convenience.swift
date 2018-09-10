//
//  NSManagedObject+Convenience.swift
//  SharedFramework
//
//  Created by Ellen Shapiro (Work) on 9/10/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObject {

    public static var dns_entityName: String {
        return String(describing: self)
    }

    public static func dns_create(in context: NSManagedObjectContext =  CoreDataManager.shared.mainContext) -> Self {
        return self.init(entity: self.entity(), insertInto: context)
    }
}
