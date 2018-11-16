//
//  RandomSelection.swift
//  Star Trek Adventures
//
//  Created by Mars Geldard on 13/11/18.
//  Copyright © 2018 Mars Geldard. All rights reserved.
//

final class DiceBag {
    
    static func rollDice(sides: Int) -> Int {
        return Int.random(in: 1...sides)
    }
    
    static func rollD6() -> Int {
        return rollDice(sides: 6)
    }
    
    static func rollD20() -> Int {
        return rollDice(sides: 20)
    }
}

///=======================================

import Foundation

protocol RandomSelectable {
    static var options: [(value: Self, probability: Double)] { get }
    static func selectRandom() -> Self
}

extension RandomSelectable {
    static func selectRandom() -> Self {
        let totalProbability = options.reduce(0, { $0 +  $1.probability })
        let randomSelector = drand48() * totalProbability
        var cumulativeProbability = 0.0
        
        for item in options {
            cumulativeProbability += item.probability
            
            if randomSelector < cumulativeProbability {
                return item.value
            }
        }
        
        let highestProbability = options.max(by: { $0.probability < $1.probability })
        return highestProbability!.value
    }
}

extension RandomSelectable where Self: CaseIterable {
    static var options: [(value: Self, probability: Double)] {
        return Self.allCases.map { (value: $0, probability: 0.1) }
    }
}

extension Array where Element: Equatable {
    
    func hasOverlap(with otherArray: [Element]) -> Bool {
        for element in self {
            if otherArray.contains(element) {
                return true
            }
        }
        
        return false
    }
    
    func selectRandom() -> Element {
        guard let selected = self.randomElement() else {
            fatalError("selectRandom() called on array with no elements.")
        }
        
        return selected
    }
    
    func selectRandom(count: Int) -> [Element] {
        guard self.count >= count else {
            fatalError("selectRandom(count: \(count) called on array with less than \(count) elements.")
        }
        
        var selected: [Element] = []
        
        repeat {
            if let randomElement = self.randomElement(){
                if !selected.contains(randomElement) {
                    selected.append(randomElement)
                }
            }
        } while selected.count < count
        
        return selected
    }
}
