//
//  Environments.swift
//  Star Trek Adventures
//
//  Created by Mars Geldard on 10/11/18.
//  Copyright © 2018 Mars Geldard. All rights reserved.
//

enum Environment {
    case homeworld(Species), busyColony, isolatedColony, frontierColony, starship, starbase, anotherSpeciesHomeworld(Species)
    
    var descriptor: String {
        switch self {
            case .homeworld(let species): return "on \(species.homeworld)"
            case .busyColony: return "in a busy colony"
            case .isolatedColony: return "in an isolated colony"
            case .frontierColony: return "in a frontier colony"
            case .starship: return "on a starship"
            case .starbase: return "on a starbase"
            case .anotherSpeciesHomeworld(let species): return "on the \(species.name) homeworld, \(species.homeworld)"
        }
    }
    
    var attributes: [Attribute] {
        switch self {
            case .homeworld(let species): return species.attributes
            case .busyColony: return [.daring, .presence]
            case .isolatedColony: return [.reason, .insight]
            case .frontierColony: return [.control, .fitness]
            case .starship: return [.control, .insight]
            case .starbase: return [.control, .insight]
            case .anotherSpeciesHomeworld(let species): return species.attributes
        }
    }
    
    var disciplines: [Discipline] {
        switch self {
            case .homeworld: return [.command, .security, .science]
            case .busyColony: return [.command, .security, .science]
            case .isolatedColony: return [.engineering, .science, .medicine]
            case .frontierColony: return [.conn, .security, .medicine]
            case .starship: return [.command, .conn, .engineering]
            case .starbase: return [.command, .conn, .engineering]
            case .anotherSpeciesHomeworld: return Discipline.allCases
        }
    }
}

extension Environment {
    
    static func rollRandom(species: Species, era: Era, expansions: [Expansion]) -> Environment {
        let result = DiceBag.rollD6()
        let environment: Environment
        
        switch result {
            case 1: environment = .homeworld(species)
            case 2: environment = .busyColony
            case 3: environment = .isolatedColony
            case 4: environment = .frontierColony
        case 5: let spaceLocation: Environment = [.starship, .starbase].randomElement()!
                environment = spaceLocation
            case 6: var otherSpecies: Species
                repeat {
                    otherSpecies = Species.rollRandom(era: era, expansions: expansions)
                } while otherSpecies == species
                environment = .anotherSpeciesHomeworld(otherSpecies)
            default: fatalError("Invalid roll in Environment selector")
        }
        
        print("Rolled \(result) for environment: \(environment.descriptor)")
        return environment
    }
}
