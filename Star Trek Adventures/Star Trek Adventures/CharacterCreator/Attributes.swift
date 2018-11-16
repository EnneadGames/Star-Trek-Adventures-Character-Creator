//
//  Attributes.swift
//  Star Trek Adventures
//
//  Created by Mars Geldard on 13/11/18.
//  Copyright © 2018 Mars Geldard. All rights reserved.
//

enum Attribute: CaseIterable {
    case control, daring, fitness, insight, presence, reason
    
    static func selectRandom() -> Attribute {
        return self.allCases.randomElement()!
    }
    
    static func selectRandom(count: Int) -> [Attribute] {
        var selected: [Attribute] = []
        
        while selected.count < count {
            let attribute = Attribute.selectRandom()
            
            if !selected.contains(attribute) {
                selected.append(attribute)
            }
        }
        
        return selected
    }
}

struct AttributeSet {
    var control: Int
    var daring: Int
    var fitness: Int
    var insight: Int
    var presence: Int
    var reason: Int
    
    init() {
        self.control =  7
        self.daring = 7
        self.fitness = 7
        self.insight = 7
        self.presence = 7
        self.reason = 7
    }
    
    var total: Int {
        return control + daring + fitness + insight + presence + reason
    }
    
    mutating func increase(_ attribute: Attribute, by increase: Int = 1) {
        switch attribute {
            case .control: self.control += increase
            case .daring: self.daring += increase
            case .fitness: self.fitness += increase
            case .insight: self.insight += increase
            case .presence: self.presence += increase
            case .reason: self.reason += increase
        }
    }
    
    mutating func increase(_ attributes: [Attribute], by increase: Int = 1) {
        for attribute in attributes {
            self.increase(attribute, by: increase)
        }
    }
}
