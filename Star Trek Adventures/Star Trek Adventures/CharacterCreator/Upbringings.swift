//
//  Upbringings.swift
//  Star Trek Adventures
//
//  Created by Mars Geldard on 10/11/18.
//  Copyright © 2018 Mars Geldard. All rights reserved.
//

enum UpbringingAcceptance {
    case accepted, rejected
}

enum Upbringing {
    case starfleet(UpbringingAcceptance), businessTrade(UpbringingAcceptance), agricultureRural(UpbringingAcceptance), scienceTechnology(UpbringingAcceptance), artisticCreative(UpbringingAcceptance), diplomacyPolitics(UpbringingAcceptance)
    
    var descriptor: String {
        switch self {
            case .starfleet: return "Starfleet training"
            case .businessTrade: return "business and trade"
            case .agricultureRural: return "agriculture and rural studies"
            case .scienceTechnology: return "science and technology"
            case .artisticCreative: return "art and creativity"
            case .diplomacyPolitics: return "diplomacy and politics"
        }
    }
    
    var acceptance: UpbringingAcceptance {
        switch self {
            case .starfleet(let acceptance): return acceptance
            case .businessTrade(let acceptance): return acceptance
            case .agricultureRural(let acceptance): return acceptance
            case .scienceTechnology(let acceptance): return acceptance
            case .artisticCreative(let acceptance): return acceptance
            case .diplomacyPolitics(let acceptance): return acceptance
        }
    }
    
    var attributes: [Attribute] {
        switch self {
            case .starfleet(let acceptance):
                return acceptance == .accepted ? [.fitness, .control, .control] : [.insight, .daring, .daring]
            case .businessTrade(let acceptance):
                return acceptance == .accepted ? [.daring, .presence, .presence] : [.reason, .insight, .insight]
            case .agricultureRural(let acceptance):
                return acceptance == .accepted ? [.control, .fitness, .fitness] : [.presence, .reason, .reason]
            case .scienceTechnology(let acceptance):
                return acceptance == .accepted ? [.reason, .control, .control] : [.daring, .insight, .insight]
            case .artisticCreative(let acceptance):
                return acceptance == .accepted ? [.insight, .presence, .presence] : [.daring, .fitness, .fitness]
            case .diplomacyPolitics(let acceptance):
                return acceptance == .accepted ? [.control, .presence, .presence] : [.fitness, .reason, .reason]
        }
    }
    
    var disciplines: [Discipline] {
        switch self {
            case .starfleet: return Discipline.allCases
            case .businessTrade: return [.command, .engineering, .science]
            case .agricultureRural: return [.conn, .security, .medicine]
            case .scienceTechnology: return [.conn, .engineering, .science, .medicine]
            case .artisticCreative: return [.command, .engineering, .science]
            case .diplomacyPolitics: return [.command, .conn, .security]
        }
    }
    
    var foci: [Focus] {
        switch self {
            case .starfleet(_): return ["astronavigation", "composure", "extra-vehicular activity", "hand-to-hand combat", "martial arts", "hand phasers", "small craft", "Starfleet protocol", "starship recognition", "history"]
            case .businessTrade(_): return ["finances", "geology", "linguistics", "manufacturing", "metallurgy", "negotiation", "survey"]
            case .agricultureRural(_): return ["animal handling", "athletics", "emergency medicine", "endurance", "ground vehicles", "infectious diseases", "navigation", "toxicology"]
            case .scienceTechnology(_): return ["astrophysics", "astronavigation", "computers", "cybernetics", "power systems", "genetics", "physics", "subspace communications", "surgery", "quantum mechanics", "warp field dynamics", "xenobiology"]
            case .artisticCreative(_): return ["botany", "cultural studies", "holoprogramming", "linguistics", "music", "observation", "persuasion", "psychology"]
            case .diplomacyPolitics(_): return ["composure", "debate", "diplomacy", "espionage", "interrogation", "law", "philosophy", "Starfleet protocol"]
        }
    }
}

extension Upbringing {
    
    static func rollRandom() -> Upbringing {
        let firstResult = DiceBag.rollD6()
        let secondResult = DiceBag.rollD6()
        let upbringing: Upbringing
        let acceptance: UpbringingAcceptance
        
        switch firstResult {
            case 1...3: acceptance = .accepted
            case 4...6: acceptance = .rejected
            default: fatalError("Invalid roll in Upbringing selector")
        }
        
        
        switch secondResult {
            case 1: upbringing = .starfleet(acceptance)
            case 2: upbringing = .businessTrade(acceptance)
            case 3: upbringing = .agricultureRural(acceptance)
            case 4: upbringing = .scienceTechnology(acceptance)
            case 5: upbringing = .artisticCreative(acceptance)
            case 6: upbringing = .diplomacyPolitics(acceptance)
            default: fatalError("Invalid roll in Upbringing selector")
        }
        
        print("Rolled \(secondResult) for upbringing: \(upbringing.descriptor)")
        print("Rolled \(firstResult) for upbringing acceptance: \(upbringing.acceptance)")
        return upbringing
    }
}
