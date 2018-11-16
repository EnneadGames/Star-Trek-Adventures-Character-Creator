//
//  CareerLevels.swift
//  Star Trek Adventures
//
//  Created by Mars Geldard on 14/11/18.
//  Copyright © 2018 Mars Geldard. All rights reserved.
//

enum Rank: Comparable {
    case ensign, juniorLieutenant, lieutenant, lieutenantCommander, commander, captain
    
    var descriptor: String {
        switch self {
            case .ensign: return "an ensign"
            case .juniorLieutenant: return "a junior lieutenant"
            case .lieutenant: return "a lieutenant"
            case .lieutenantCommander: return "a lieutenant commander"
            case .commander: return "a commander"
            case .captain: return "a captain"
        }
    }
    
    static func < (lhs: Rank, rhs: Rank) -> Bool {
        let rankOrder: [Rank] = [.ensign, .juniorLieutenant, .lieutenant, .lieutenantCommander, .commander, .captain]
        let lhsOrderIndex = rankOrder.firstIndex(of: lhs) ?? 0
        let rhsOrderIndex = rankOrder.firstIndex(of: rhs) ?? 0
        
        return  lhsOrderIndex < rhsOrderIndex
    }
}

enum CareerLevel {
    case young, experienced, veteran
    
    var descriptor: String {
        switch self {
            case .young, .veteran: return "a \(self) officer"
            case .experienced: return "an \(self) officer"
        }
    }
    
    var talent: Talent? {
        switch self {
            case .young: return "Untapped Potential"
            case .experienced: return nil
            case .veteran: return "Veteran"
        }
    }
    
    var ranks: [Rank] {
        switch self {
            case .young: return [.ensign, .juniorLieutenant]
            case .experienced: return [.lieutenant, .lieutenantCommander]
            case .veteran: return [.commander, .captain]
        }
    }
}

extension CareerLevel {
    
    static func rollRandom() -> CareerLevel {
        let result = DiceBag.rollD6()
        let level: CareerLevel
        
        switch result {
            case 1: level = .young
            case 2...5: level = .experienced
            case 6: level = .veteran
            default: fatalError("Invalid roll in CareerLevel selector")
        }
        
        print("Rolled \(result) for career level: \(level)")
        return level
    }
}
