//
//  Tracks.swift
//  Star Trek Adventures
//
//  Created by Mars Geldard on 4/11/18.
//  Copyright © 2018 Mars Geldard. All rights reserved.
//

import Foundation

struct StudySet {
    let major: Discipline
    let minors: (first: Discipline, second: Discipline)
    
    var disciplines: [Discipline] {
        return [major, major, minors.first, minors.second]
    }
    
    static func selectRandom(track: Track) -> StudySet {
        let major = track.disciplines.selectRandom()
        
        var minors: [Discipline]
        repeat {
            minors = Discipline.selectRandom(count: 2)
        } while  minors[0] == major || minors[1] == major
        
        return StudySet(major: major, minors: (first: minors[0], second: minors[1]))
    }
}

enum Track {
    case command, operations, science
    
    var disciplines: [Discipline] {
        switch self {
            case .command: return [.command, .conn]
            case .operations: return [.engineering, .security]
            case .science: return [.medicine, .science]
        }
    }
    
    var foci: [Focus] {
        switch self {
            case .command: return ["astronavigation", "composure", "diplomacy", "extra-vehicular activity", "evasive action", "helm operations", "inspiration", "persuasion", "small craft", "starship recognition", "Starfleet protocol", "team dynamics"]
            case .operations: return ["computers", "cybernetics", "electro-plasma power systems", "espionage", "hand phasers", "hand-to-hand combat", "infiltration", "interrogation", "shipboard tactical systems", "survival", "transporters & replicators", "warp field dynamics"]
            case .science: return ["anthropology", "astrophysics", "botany", "computers", "cybernetics", "emergency medicine", "exo-tectonics", "genetics", "geology", "infectious diseases", "linguistics", "physics", "psychiatry", "quantum mechanics", "trauma surgery", "virology", "warp field dynamics", "xenobiology"]
        }
    }
}

extension Track {
    
    static func rollRandom() -> Track {
        let result = DiceBag.rollD6()
        let track: Track
    
        switch result {
            case 1, 2: track = .command
            case 3, 4: track = .operations
            case 5, 6: track = .science
            default: fatalError("Invalid roll in Track selector")
        }
        
        print("Rolled \(result) for track: \(track)")
        return track
    }
}
