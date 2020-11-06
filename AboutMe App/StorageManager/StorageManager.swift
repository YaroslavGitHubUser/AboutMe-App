//
//  StorageManager.swift
//  AboutMe App
//
//  Created by Yaroslav on 05.11.2020.
//  Copyright © 2020 Yaroslav. All rights reserved.
//

import CoreData

class StorageManager {
    
    static let shared = StorageManager()
    
    // MARK: - Core Data stack
    private var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "UserInfo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private init() {}
    
    // MARK: - Public Methods
    func fetchData() -> [LogInDetails] {
        let fetchRequest: NSFetchRequest<LogInDetails> = LogInDetails.fetchRequest()
        
        do {
            return try viewContext.fetch(fetchRequest)
        } catch let error {
            print("Failed to fetch data", error)
            return []
        }
    }
    
    // Save data
    func save(login: String, password: String) {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "LogInDetails", in: persistentContainer.viewContext) else { return }
        let logInDetails = NSManagedObject(entity: entityDescription, insertInto: viewContext) as! LogInDetails
        logInDetails.login = login
        logInDetails.password = password
        
        saveContext()
    }
    
    // Delete all data
    
    func delete() {
        let users = fetchData()
        for user in users {
            viewContext.delete(user)
        }
        saveContext()
    }

    // MARK: - Core Data Saving support
    func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
