//
//  CoreDataManager.swift
//  PrimeNumberGenerator
//
//  Created by Aliaksei Verameichyk on 11/6/18.
//  Copyright © 2018 Aliaksei Verameichyk. All rights reserved.
//

import CoreData

class CoreDataManager {
    // MARK: - Properties
    
    static let shared = CoreDataManager()
    
    private let coreDataStack = CoreDataStack(modelName: "PrimeNumberGenerator")
    
    // MARK: - Initialization
    
    private init() {}
    
    // MARK: - Public methods
    
    func fetchHistories() -> [HistoryModel]? {
        let request: NSFetchRequest<HistoryModel> = HistoryModel.fetchRequest()
        
        guard let histories = try? coreDataStack.managedContext.fetch(request) else {
            return nil
        }
        
        return histories
    }
    
    func save(with executionTime: Float,
              upperBound: UInt64) {
        let history = HistoryModel(context: coreDataStack.managedContext)
        history.upperBound = NSNumber(value: upperBound)
        history.executionTime = executionTime
        
        coreDataStack.saveContext()
    }
}
