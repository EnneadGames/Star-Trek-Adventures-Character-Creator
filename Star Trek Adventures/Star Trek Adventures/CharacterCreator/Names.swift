//
//  Names.swift
//  Star Trek Adventures
//
//  Created by Mars Geldard on 15/11/18.
//  Copyright © 2018 Mars Geldard. All rights reserved.
//

final class NameGenerator {
    
    static func randomName(for species: Species, of gender: Gender) -> String {
        var name: String = ""
        switch species {
        case .andorian:
            if gender == .female {
                name += ["Athytti", "Vryvih", "Zyle", "Vyssia", "Thriras", "Shreri", "Vrossaan", "Itamaan", "Ishrelia", "Vreraat", "Talas", "Tarah", "Jhamel", "Talla"].selectRandom()
                name += [" ", " zh'", " sh'"].selectRandom()
            }
            
            if gender == .male {
                name += ["Ishrath", "Thoss", "Shon", "Oshrev", "Atheth", "Tyvaass", "Thasiv", "Tyssab", "Tylihr", "Thy’lek", "Shras", "Thelev", "Keval", "Gareb"].selectRandom()
                name += [" ", " ch'", " th'"].selectRandom()
            }
            
            name += ["Tharhat", "Qiaqir", "Chiaqis", "Thenehr", "Zynes", "Shraviq", "Thilrerh", "Azonan", "Azollarh", "Shran"].selectRandom()
        case .bajoran:
            name += ["Anbara", "Anjohl", "Faren", "Jaro", "Kalem", "Krim", "Kubus", "Latara", "Latha", "Lenaris", "Li", "Tahna", "Reil"].selectRandom()
            name += " "
            
            if gender == .female {
                name += ["Adami", "Chami", "Fala", "Jaxa", "Laren", "Lipras", "Leeta", "Lupaza", "Meru", "Neela", "Nerys", "Seriah", "Sul", "Yesa"].selectRandom()
            }
            
            if gender == .male {
                name += ["Anaphis", "Edon", "Essa", "Furel", "Gel", "Holem", "Hovath", "Kag", "Los", "Mabrin", "Nalas", "Reon", "Taban", "Tennan"].selectRandom()
            }
        default: break
        }
        
        return name
    }
}
