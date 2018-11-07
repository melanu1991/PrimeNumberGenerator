//
//  Protocols.swift
//  PrimeNumberGenerator
//
//  Created by Aliaksei Verameichyk on 11/5/18.
//  Copyright © 2018 Aliaksei Verameichyk. All rights reserved.
//

import Foundation

protocol GeneratorPresenterProtocol: class {
    func generateAction(for upperBound: UInt64)
    func clearCacheAction()
}

protocol GeneratorViewControllerProtocol: class {
    func display(_ primes: [UInt64])
    func display(_ executionTime: String)
    
    func showHud()
    func hideHud()
}
