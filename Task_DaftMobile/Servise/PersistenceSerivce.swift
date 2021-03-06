//
//  PersistenceSerivce.swift
//  Task_DaftMobile
//
//  Created by Nikita Gura on 5/7/19.
//  Copyright © 2019 Nikita Gura. All rights reserved.
//

import Foundation
import CoreData

final class PersistenceSerivce{
    
    static let shared = PersistenceSerivce()
    
    // MARK: - Core Data stack
    private init(){}
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
