//
//  CoreDataManager.swift
//  SharedFramework
//
//  Created by Ellen Shapiro (Work) on 9/10/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import CoreData
import Foundation

public class CoreDataManager {

    // MARK: - Singleton
    public static let shared = CoreDataManager()
    private init() {
        // Poke the container
        self.persistentContainer.loadPersistentStores(completionHandler: { description, error in
            if let error = error {
                fatalError("Could not load persistent stores! \(error)")
            }
        })
    }

    private lazy var persistentContainer: NSPersistentContainer = {
        let bundle = Bundle(for: CoreDataManager.self)
        guard let url = bundle.url(forResource: "TravelPlanner", withExtension: "momd") else {
            fatalError("Could not get url of MOM")
        }

        guard let managedObjectModel = NSManagedObjectModel(contentsOf: url) else {
            fatalError("Could not load MOM")
        }

        let container = NSPersistentContainer(name: "TravelPlanner", managedObjectModel: managedObjectModel)

        container.persistentStoreDescriptions = [NSPersistentStoreDescription(url: FileManager
            .default
            .containerURL(forSecurityApplicationGroupIdentifier: "group.com.designatednerd.TravelPlanner")!
            .appendingPathComponent("CoreData.sqlite"))]
        
        return container
    }()

    public var mainContext: NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }

    public func workInBackground(_ task: @escaping (NSManagedObjectContext) -> Void) {
        self.persistentContainer.performBackgroundTask(task)
    }
}
