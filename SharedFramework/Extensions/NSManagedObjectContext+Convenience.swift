//
//  NSManagedObjectContext+Convenience.swift
//  SharedFramework
//
//  Created by Ellen Shapiro (Work) on 9/10/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import Foundation
import CoreData

public extension NSManagedObjectContext {

    public func dns_saveIfHasChanges() throws {
        guard self.hasChanges else {
            return
        }

        try self.save()
    }

    public func dns_allOf<T: NSManagedObject>(_ type: T.Type, sortDescriptors: [NSSortDescriptor]? = nil) -> [T] {
        let request = T.fetchRequest()
        request.sortDescriptors = sortDescriptors
        do {
            let result = try self.fetch(request)
            return result as! [T]
        } catch let error {
            print("Error fetching all \(T.dns_entityName) objects: \(error)")
            return []
        }
    }

    public func dns_fetch<T: NSManagedObject>(_ type: T.Type, with id: String) -> T? {
        let request = T.fetchRequest()
        request.predicate = NSPredicate(format: "id = \(id)")
        do {
            let result = try self.fetch(request)
            assert(result.count == 1, "This should only ever be one item!")
            return result.first as? T
        } catch let error {
            print("Error fetching \(T.dns_entityName) with ID \(id): \(error)")
            return nil
        }
    }

    public func dns_delete<T: NSManagedObject>(_ type: T.Type, withID id: String) {
        guard let toDelete = self.dns_fetch(type, with: id) else {
            // Nothing to delete
            return
        }

        self.delete(toDelete)
    }
}
