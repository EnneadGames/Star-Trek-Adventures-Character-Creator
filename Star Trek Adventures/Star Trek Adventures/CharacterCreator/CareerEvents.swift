//
//  CareerEvents.swift
//  Star Trek Adventures
//
//  Created by Mars Geldard on 14/11/18.
//  Copyright © 2018 Mars Geldard. All rights reserved.
//

enum CareerEvent {
    case shipDestroyed, friendDied, cultureLauded, treatyNegotiated, tookCommand, alienEncounter, seriousInjury, hostileConflict, mentored, transporterAccident, plague, betrayedIdeals, calledOutSuperior, newBattleStrategy, learnedUniqueLanguage,  discoveredArtefact, specialCommendation, solvedEngineeringCrisis, breakthroughInvention, firstContact
    
    var descriptor: String {
        switch self {
            case.shipDestroyed: return "was on a ship that was destroyed during a mission"
            case .friendDied: return "had a friend who has killed in action"
            case .cultureLauded: return "was lauded by another culture"
            case .treatyNegotiated: return "negotiated a treaty with a culture outside the federation"
            case .tookCommand: return "was required to take command during a mission crisis"
            case .alienEncounter: return "encountered a non-humanoid life form that was truly alien"
            case .seriousInjury: return "was seriously injured"
            case .hostileConflict: return "was involved in a major battle with a hostile force"
            case .mentored: return "was mentored by a highly-respected officer"
            case .transporterAccident: return "suffered a strange transported accident"
            case .plague: return "was assigned to provide aide to a world suffering an epidemic"
            case .betrayedIdeals: return "had to betray personal ideals to follow a superior's orders"
            case .calledOutSuperior: return "called out a superior officer for betraying personal ideals"
            case .newBattleStrategy: return "was forced to devise a new battle strategy while in combat"
            case .learnedUniqueLanguage: return "learned to communicate with a species with an unusual form of communication"
            case .discoveredArtefact: return "discovered a piece of technology from a now-extinct civilization"
            case .specialCommendation: return "earned a special commendation for saving the lives of several colleagues"
            case .solvedEngineeringCrisis: return "saved many lives by ending a crisis caused by malfunctioning technology"
            case .breakthroughInvention: return "made an important technological discovery that was regarded invaluable"
            case .firstContact: return "made first contact with another culture"
        }
    }
    
    var attribute: Attribute {
        switch self {
            case .shipDestroyed, .tookCommand, .newBattleStrategy: return .daring
            case .friendDied, .plague, .learnedUniqueLanguage: return .insight
            case .cultureLauded, .betrayedIdeals, .firstContact: return .presence
            case .treatyNegotiated, .transporterAccident, .solvedEngineeringCrisis: return .control
            case .alienEncounter, .calledOutSuperior, .discoveredArtefact: return .reason
            case .seriousInjury, .hostileConflict, .specialCommendation: return .fitness
            case .mentored, .breakthroughInvention: return Attribute.selectRandom()
        }
    }
    
    var discipline: Discipline {
        switch self {
            case .shipDestroyed, .hostileConflict, .newBattleStrategy: return .security
            case .friendDied, .seriousInjury, .plague: return .medicine
            case .cultureLauded, .alienEncounter, .learnedUniqueLanguage: return .science
            case .treatyNegotiated, .tookCommand, .betrayedIdeals: return .command
            case .mentored, .transporterAccident, .calledOutSuperior: return .conn
            case .discoveredArtefact, .solvedEngineeringCrisis, .breakthroughInvention: return .engineering
            case .specialCommendation, .firstContact: return Discipline.selectRandom()
        }
    }
    
    var foci: [Focus] {
        switch self {
            case.shipDestroyed: return ["extra vehicular operations", "small craft", "survival"]
            case .friendDied: return ["counselling", "crisis response"]
            case .cultureLauded: return ["non-Federation culture"]
            case .treatyNegotiated: return ["diplomacy", "negotiation", "galactic politics"]
            case .tookCommand: return ["lead by example", "inspiration", "composure"]
            case .alienEncounter: return ["empathy", "philosophy", "xenobiology"]
            case .seriousInjury: return ["athletics", "art", "philosophy"]
            case .hostileConflict: return ["hand phasers", "hand-to-hand combat", "shipboard tactical systems"]
            case .mentored: return ["composure", "etiquette"]
            case .transporterAccident: return ["transporters & replicators", "small craft", "quantum mechanics"]
            case .plague: return ["infectious diseases", "emergency medicine", "triage"]
            case .betrayedIdeals: return ["persuasion", "inspiration", "investigation"]
            case .calledOutSuperior: return ["uniform code of justice", "history", "Starfleet protocol"]
            case .newBattleStrategy: return ["combat tactics, hazard awareness", "lead by example"]
            case .learnedUniqueLanguage: return ["linguistics, cultural studies", "negotiations"]
            case .discoveredArtefact: return ["ancient technology", "computers", "reverse engineering"]
            case .specialCommendation: return ["athletics", "survival", "emergency medicine."]
            case .solvedEngineeringCrisis: return ["electro-plasma power systems", "fusion reactors", "warp engines"]
            case .breakthroughInvention: return ["experimental technology", "invention", "improvisation"]
            case .firstContact: return ["cultural studies", "diplomacy", "infiltration"]
        }
    }
    
    var trait: Trait? {
        switch self {
            case .cultureLauded: return "friend to the <non-Federation culture>"
            case .seriousInjury: return ["prosthetic implant", "physical disability", nil].selectRandom()
            default: return nil
        }
    }
}

extension CareerEvent {
    
    static func rollRandom() -> CareerEvent {
        let result = DiceBag.rollD20()
        let event: CareerEvent
        
        switch result {
            case 1: event = .shipDestroyed
            case 2: event = .friendDied
            case 3: event = .cultureLauded
            case 4: event = .treatyNegotiated
            case 5: event = .tookCommand
            case 6: event = .alienEncounter
            case 7: event = .seriousInjury
            case 8: event = .hostileConflict
            case 9: event = .mentored
            case 10: event = .transporterAccident
            case 11: event = .plague
            case 12: event = .betrayedIdeals
            case 13: event = .calledOutSuperior
            case 14: event = .newBattleStrategy
            case 15: event = .learnedUniqueLanguage
            case 16: event = .discoveredArtefact
            case 17: event = .specialCommendation
            case 18: event = .solvedEngineeringCrisis
            case 19: event = .breakthroughInvention
            case 20: event = .firstContact
            default: fatalError("Invalid roll in CareerEvent selector")
        }
        
        print("Rolled \(result) for career event: \(event)")
        return event
    }
}
