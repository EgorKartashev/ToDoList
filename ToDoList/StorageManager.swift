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
   
    private var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "ToDoList")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
   
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private let context : NSManagedObjectContext
    
    private init(){
        context = persistentContainer.viewContext
    }
    
        
    func fetchData(completion: (Result<[Task], Error>) -> Void) {
        let fetchRequest = Task.fetchRequest()
        do{
            let tasks = try context.fetch(fetchRequest)
            completion(.success(tasks))
        }
        catch {
            print(error.localizedDescription)
            completion(.failure(error))
        }
    }

    func save( _ taskName: String, completion: (Task) -> Void){
        let task = Task(context: context)
        task.title = taskName
        completion(task)
        saveContext()

    }
    
    func saveContext(){
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
