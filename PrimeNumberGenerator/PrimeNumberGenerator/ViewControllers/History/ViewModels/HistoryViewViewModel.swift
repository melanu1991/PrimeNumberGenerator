//
//  HistoryViewViewModel.swift
//  PrimeNumberGenerator
//
//  Created by Aliaksei Verameichyk on 11/5/18.
//  Copyright © 2018 Aliaksei Verameichyk. All rights reserved.
//

import Foundation

class HistoryViewViewModel {
    // MARK: - Properties
    
    private let models: [HistoryModel]
    
    var numberOfSections: Int {
        return 1
    }
    
    var numberOfRows: Int {
        return models.count
    }
    
    // MARK: - Initialization
    
    init(models: [HistoryModel]) {
        self.models = models
    }
    
    // MARK: - Public methods
    
    func upperBound(for index: Int) -> String {
        return "Граница: \(models[index].upperBound?.uint64Value ?? 0)"
    }
    
    func executionTime(for index: Int) -> String {
        return "Время: \(String(format: "%.3f", models[index].executionTime))"
    }
}
