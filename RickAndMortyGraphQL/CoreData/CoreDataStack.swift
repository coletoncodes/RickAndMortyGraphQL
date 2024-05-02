//
//  CoreDataStack.swift
//  RickAndMortyGraphQL
//
//  Created by Coleton Gorecke on 5/2/24.
//

import CoreData
import Foundation

class CoreDataStack {
    static let shared = CoreDataStack(inMemory: false)
    static let inMemoryStore = CoreDataStack(inMemory: true)
    
    private let inMemory: Bool

    private init(inMemory: Bool) {
        self.inMemory = inMemory
    }

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "RickAndMorty")
        if inMemory {
                container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func newBackgroundContext() -> NSManagedObjectContext {
        return persistentContainer.newBackgroundContext()
    }

    func saveContext() {
        let context = viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                log("Failed to save context with error: \(error)", .error, .persistence)
            }
        }
    }
}
