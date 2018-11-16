//
//  Species.swift
//  Star Trek Adventures
//
//  Created by Mars Geldard on 10/11/18.
//  Copyright © 2018 Mars Geldard. All rights reserved.
//

enum Gender {
    case female, male
    
    var pronouns: (personal: String, possessive: String) {
        switch self {
            case .female: return ("she", "her")
            case .male: return ("he", "his")
        }
    }
}

enum JoinedStatus: Equatable  {
    case joined, unjoined
}

enum Species: Equatable {
    
    case andorian, bajoran, betazoid, denobulan, human, tellarite, trill(JoinedStatus), vulcan
    
    var name: String {
        switch self {
            case .trill(_): return "Trill"
            default: return String(describing: self).capitalized
        }
    }
    
    var descriptor: String {
        switch self {
            case .trill(let joinedStatus): return joinedStatus == .joined ? "joined Trill" : "unjoined Trill"
            default: return String(describing: self).capitalized
        }
    }
    
    var genders: [Gender] {
        return [.female, .male]
    }
    
    var homeworld: String {
        switch self {
            case .andorian: return "Andoria"
            case .bajoran: return "Bajor"
            case .betazoid: return "Betazed"
            case .denobulan: return "Denobula"
            case .human: return "Earth"
            case .tellarite: return "Tellar Prime"
            case .trill, .vulcan: return self.name
        }
    }
    
    var trait: Trait {
        return self.name
    }
    
    var attributes: [Attribute] {
        switch self {
            case .andorian: return [.daring, .control, .presence]
            case .bajoran: return [.control, .daring, .insight]
            case .betazoid: return [.insight, .presence, .reason]
            case .denobulan: return [.fitness, .insight, .reason]
            case .human: return Attribute.selectRandom(count: 3)
            case .tellarite: return [.control, .fitness, .insight]
            case .trill: return [.control, .presence, .reason]
            case .vulcan: return [.control, .fitness, .reason]
        }
    }
    
    func name(for gender: Gender) -> String {
        return NameGenerator.randomName(for: self, of: gender)
    }
    
    func age(for careerLevel: CareerLevel) -> Int {
        return 35
    }
}

extension Species {
    
    static func rollRandom(era: Era, expansions: [Expansion] = []) -> Species {
        let result = DiceBag.rollD20()
        let species: Species
        
        switch result {
            case 1, 2: species = .andorian
            case 3, 4: species = .bajoran
            case 5, 6: species = .betazoid
            case 7, 8: species = .denobulan
            case 9...14: species = .human
            case 15, 16: species = .tellarite
            case 17, 18: let joinedStatus: JoinedStatus = [.joined, .unjoined].randomElement()!
                species = .trill(joinedStatus)
            case 19, 20: species = .vulcan
            default: fatalError("Invalid roll in Species selector")
        }
        
        print("Rolled \(result) for species: \(species.descriptor)")
        return species
    }
}
