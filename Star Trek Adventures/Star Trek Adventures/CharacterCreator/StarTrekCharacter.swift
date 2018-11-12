//
//  StarTrekCharacter.swift
//  Star Trek Adventures
//
//  Created by Mars Geldard on 4/11/18.
//  Copyright © 2018 Mars Geldard. All rights reserved.
//

import UIKit

typealias Focus = String
typealias Talent = String
typealias Trait = String
typealias Value = String
typealias Equipment = String

struct AttributeSet {
    var control: Int
    var daring: Int
    var fitness: Int
    var insight: Int
    var presence: Int
    var reason: Int
    
    init() {
        self.control = Array(7...12).randomElement() ?? 7
        self.daring = Array(7...12).randomElement() ?? 1
        self.fitness = Array(7...12).randomElement() ?? 7
        self.insight = Array(7...12).randomElement() ?? 7
        self.presence = Array(7...12).randomElement() ?? 7
        self.reason = Array(7...12).randomElement() ?? 7
    }
}

struct DisciplineSet {
    var command: Int
    var conn: Int
    var engineering: Int
    var security: Int
    var science: Int
    var medicine: Int
    
    init() {
        self.command = Array(1...5).randomElement() ?? 1
        self.conn = Array(1...5).randomElement() ?? 1
        self.engineering = Array(1...5).randomElement() ?? 1
        self.security = Array(1...5).randomElement() ?? 1
        self.science = Array(1...5).randomElement() ?? 1
        self.medicine = 1
    }
}

class StarTrekCharacter {
    
    let name: String
    let track: Track
    let species: Species
    let environment: Environment
    let upbringing: Upbringing
    
    private(set) var attributes = AttributeSet()
    private(set) var disciplines = DisciplineSet()
    private(set) var foci: [Focus] = []
    private(set) var talents: [Talent] = []
    private(set) var traits: [Trait] = []
    private(set) var values: [Value] = []
    private(set) var equipment: [Equipment] = []
    
    let gender: Gender
    let age: Int
    var stress: Int { return attributes.fitness + disciplines.security }
    var damageBonus: Int { return disciplines.security }
    
    let bio: String
    
    init(era: Era, expansions: [Expansion]) {
        self.name = "John Doe"
        self.track = Track.selectRandom()
        self.species = .human
        self.age = 47
        self.gender = .male
        self.environment = .homeworld
        self.upbringing = .trade
        
        self.foci = ["Test Focus 1"]
        self.talents = ["Test Talent 1", "A Second Testing Talent for Testing Purposes that is Very Long"]
        self.traits =  [String(describing: self.species)]
        self.values = ["Test Value 1"]
        self.equipment = ["Uniforms", "Communicator", "Tricorder"]
        
        self.bio = "A \(self.age)-year-old \(self.gender) \(self.species). Raised..."
    }
}
