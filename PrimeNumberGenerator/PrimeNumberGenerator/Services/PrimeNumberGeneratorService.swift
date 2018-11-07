//
//  PrimeNumberGeneratorService.swift
//  PrimeNumberGenerator
//
//  Created by Aliaksei Verameichyk on 11/5/18.
//  Copyright © 2018 Aliaksei Verameichyk. All rights reserved.
//

import Foundation

class PrimeNumberGeneratorService {
    // MARK: - Properties
    
    static let shared = PrimeNumberGeneratorService()
    
    private let group = DispatchGroup()
    private let queue = DispatchQueue(label: "com.primeNumberGenerator.primeNumberGeneratorService.queue",
                                      attributes: .concurrent)
    
    // MARK: - Public methods
    
    func generate(for upperBound: UInt64,
                  cachedModel: CacheModel) -> [UInt64] {
        guard upperBound != cachedModel.upperBound else {
            return cachedModel.primes
        }
        
        var numbers = [UInt64]()
        var primes = cachedModel.primes
        
        group.enter()
        queue.async {
            for i in cachedModel.upperBound...upperBound {
                numbers.append(i)
            }
            
            self.group.leave()
        }
        
        group.wait()
        
        var multiples = [UInt64]()
        var multiple = primes.removeFirst()

        multiples.append(multiple)

        while (multiple * multiple) <= upperBound {
            let numbersCount = numbers.count
            
            var firstPart = ArraySlice<UInt64>()
            var secondPart = ArraySlice<UInt64>()
            
            group.enter()
            queue.async {
                firstPart = numbers[0..<numbersCount/2]
                firstPart = firstPart.filter({ return ($0 % multiple) != 0 })

                self.group.leave()
            }
            
            group.enter()
            queue.async {
                secondPart = numbers[numbersCount/2...numbersCount-1]
                secondPart = secondPart.filter({ return ($0 % multiple) != 0 })

                self.group.leave()
            }
            
            group.wait()
            
            numbers = Array(firstPart + secondPart)
            multiple = !primes.isEmpty ? primes.removeFirst() : numbers.removeFirst()
            multiples.append(multiple)
        }

        return multiples + primes + numbers
    }
    
    func generate(for upperBound: UInt64) -> [UInt64] {
        if upperBound == 2 {
            return [2]
        } else if upperBound < 2 {
            return []
        }

        var numbers = [UInt64]()

        group.enter()
        queue.async {
            for i in 2...upperBound {
                numbers.append(i)
            }
            
            self.group.leave()
        }

        group.wait()
        
        var multiples = [UInt64]()
        var multiple = numbers.removeFirst()

        multiples.append(multiple)
        
        while (multiple * multiple) <= upperBound {
            let numbersCount = numbers.count

            var firstPart = ArraySlice<UInt64>()
            var secondPart = ArraySlice<UInt64>()

            group.enter()
            queue.async {
                firstPart = numbers[0..<numbersCount/2]
                firstPart = firstPart.filter({ return ($0 % multiple) != 0 })

                self.group.leave()
            }

            group.enter()
            queue.async {
                secondPart = numbers[numbersCount/2...numbersCount-1]
                secondPart = secondPart.filter({ return ($0 % multiple) != 0 })

                self.group.leave()
            }

            group.wait()

            numbers = Array(firstPart + secondPart)
            multiple = numbers.removeFirst()
            multiples.append(multiple)
        }
        
        return multiples + numbers
    }
}
