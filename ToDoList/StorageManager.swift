//
//  StorageManager.swift
//  ToDoList
//
//  Created by Егор on 10.03.2023.
//

import Foundation
import CoreData

class StorageManager {
    
    static var shared = StorageManager()
    init(){}
    
    var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "ToDoList")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
   
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

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
