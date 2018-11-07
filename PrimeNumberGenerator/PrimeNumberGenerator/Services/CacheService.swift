//
//  CacheService.swift
//  PrimeNumberGenerator
//
//  Created by Aliaksei Verameichyk on 11/6/18.
//  Copyright © 2018 Aliaksei Verameichyk. All rights reserved.
//

import Foundation

class CacheService {
    // MARK: - Properties
    
    private var caches = [CacheModel]()
    
    // MARK: - Public methods
    
    func save(_ model: CacheModel) {
        caches.append(model)
    }
    
    func find(by upperBound: UInt64) -> CacheModel? {
        return caches
            .filter({ $0.upperBound <= upperBound })
            .sorted(by: { first, second in
                    return first.upperBound < second.upperBound
                }).last
    }
    
    func reset() {
        caches.removeAll()
    }
}
