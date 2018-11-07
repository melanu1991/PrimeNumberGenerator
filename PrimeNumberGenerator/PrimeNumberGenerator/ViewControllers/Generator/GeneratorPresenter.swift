//
//  GeneratorPresenter.swift
//  PrimeNumberGenerator
//
//  Created by Aliaksei Verameichyk on 11/5/18.
//  Copyright © 2018 Aliaksei Verameichyk. All rights reserved.
//

import UIKit

class GeneratorPresenter: GeneratorPresenterProtocol {
    // MARK: - Properties
    
    private weak var view: (UIViewController & GeneratorViewControllerProtocol)?
    private let cacheService: CacheService
    
    // MARK: - Life cycle
    
    init(view: UIViewController & GeneratorViewControllerProtocol,
         cacheService: CacheService = CacheService()) {
        self.view = view
        self.cacheService = cacheService
    }
    
    // MARK: - Implementation GeneratorPresenterProtocol
    
    func clearCacheAction() {
        cacheService.reset()
    }
    
    func generateAction(for upperBound: UInt64) {
        view?.view.isUserInteractionEnabled = false
        view?.showHud()
        
        DispatchQueue.global(qos: .userInitiated).async {
            let initiallyDate = Date()
            
            let primes: [UInt64]
            
            if let cachedModel = self.cacheService.find(by: upperBound) {
                primes = PrimeNumberGeneratorService.shared.generate(for: upperBound,
                                                                     cachedModel: cachedModel)
            } else {
                primes = PrimeNumberGeneratorService.shared.generate(for: upperBound)
            }
            
            DispatchQueue.main.async {
                self.view?.display(primes)
                self.view?.hideHud()
                
                let seconds = Date().timeIntervalSince(initiallyDate)
                
                let historyModel = CacheModel(upperBound: upperBound,
                                              primes: primes)
                
                self.cacheService.save(historyModel)
                
                CoreDataManager.shared.save(with: Float(seconds),
                                            upperBound: upperBound)
                
                self.view?.display(String(format: "%.3f", seconds))
                self.view?.view.isUserInteractionEnabled = true
            }
        }
    }
}
