//
//  Disciplines.swift
//  Star Trek Adventures
//
//  Created by Mars Geldard on 13/11/18.
//  Copyright © 2018 Mars Geldard. All rights reserved.
//

enum Discipline: CaseIterable {
    case command, conn, engineering, security, science, medicine
    
    static func selectRandom() -> Discipline {
        return self.allCases.randomElement()!
    }
    
    static func selectRandom(count: Int) -> [Discipline] {
        var selected: [Discipline] = []
        
        while selected.count < count {
            let attribute = Discipline.selectRandom()
            
            if !selected.contains(attribute) {
                selected.append(attribute)
            }
        }
        
        return selected
    }
}

struct DisciplineSet {
    var command: Int
    var conn: Int
    var engineering: Int
    var security: Int
    var science: Int
    var medicine: Int
    
    var lowestValue: Int {
        return min(command, conn, engineering, security, science, medicine)
    }
    
    var total: Int {
        return command + conn + engineering + security + science + medicine
    }
    
    var qualifyingTalents: [Talent] {
        return ["<Test Talent>"]
    }
    
    init() {
        self.command = 1
        self.conn = 1
        self.engineering = 1
        self.security = 1
        self.science = 1
        self.medicine = 1
    }
    
    subscript(discipline: Discipline) -> Int {
        get {
            switch discipline {
                case .command: return self.command
                case .conn: return self.conn
                case .engineering: return self.engineering
                case .security: return self.security
                case .science: return self.science
                case .medicine: return self.medicine
            }
        }
        
        set {
            switch discipline {
                case .command: self.command = newValue
                case .conn: self.conn = newValue
                case .engineering: self.engineering = newValue
                case .security: self.security = newValue
                case .science: self.science = newValue
                case .medicine: self.medicine = newValue
            }
        }
    }
    
    func highestIn(track: Track) -> Discipline {
        let trackDisciplines = track.disciplines
        var recentMaximum: (value: Discipline, level: Int) = (.command, -1)
        
        for track in trackDisciplines {
            if self[track] > recentMaximum.level {
                recentMaximum = (track, self[track])
            }
        }
        
        return recentMaximum.value
    }
    
    mutating func increase(_ discipline: Discipline, by increase: Int = 1) {
        self[discipline] += increase
    }
    
    mutating func increase(_ disciplines: [Discipline], by increase: Int = 1) {
        for discipline in disciplines {
            self.increase(discipline, by: increase)
        }
    }
    
    mutating func adjust(to limit: Int) -> Int {
        var regainedPoints = 0
        
        for discipline in Discipline.allCases {
            if self[discipline] > limit {
                regainedPoints += (self[discipline] - limit)
                self[discipline] = limit
            }
        }
        
        return regainedPoints
    }
}
