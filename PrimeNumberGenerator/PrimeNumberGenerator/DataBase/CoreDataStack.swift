//
//  CoreDataStack.swift
//  PrimeNumberGenerator
//
//  Created by Aliaksei Verameichyk on 11/6/18.
//  Copyright © 2018 Aliaksei Verameichyk. All rights reserved.
//

import CoreData

class CoreDataStack {
    // MARK: - Properties
    
    private let modelName: String
    
    lazy var managedContext: NSManagedObjectContext = {
        return storeContainer.viewContext
    }()
    
    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    // MARK: - Initialization
    
    init(modelName: String) {
        self.modelName = modelName
    }
    
    // MARK: - Public methods
    
    func saveContext () {
        guard managedContext.hasChanges else { return }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
}
