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
            
            case .betazoid:
                if gender == .female {
                    name += ["Deanna", "Ania", "Kestra", "Lwaxanna", "Dalera", "Gloranna", "Abeana", "Pekera", "Nissila", "Lomestra", "Ioza", "Pegira", "Nemenna", "Nerira", "Lojee"].selectRandom()
                }
            
                if gender == .male {
                    name += ["Konal", "Reban", "Xani", "Enon", "Dael", "Etas", "Andal", "Kolel", "Atani", "Devoni", "Algar", "Jensar", "Nikael", "Kalos", "Rennan"].selectRandom()
                }
                
                name += " "
                name += ["Grax", "Hagen", "Morganth", "Stadi", "Dutrax", "Odutan", "Nelan", "Onovren", "Kader", "Nostrun", "Dulas", "Konin", "Ebesin"].selectRandom()
            case .denobulan:
                if gender == .male {
                    name += ["Biras", "Bogga", "Delix", "Grolik", "Groznik", "Nettus", "Moga", "Morox", "Phlox", "Rinix", "Takis", "Tropp", "Tuglian", "Vinku", "Yolen", "Zepht", "Zinet"].selectRandom()
                }
                
                if gender == .female {
                    name += ["Anari", "Andora", "Asha", "Daphina", "Feezal", "Forliza", "Kessil", "Liera", "Lusis", "Miral", "Natala", "Ninsen", "Henna", "Sabra", "Secka", "Symmé", "Trevis", "Vesena"].selectRandom()
                }
            case .human:
                if gender == .female {
                    name += ["Mary", "Katherine", "Susan", "Helena", "Olivia", "Emma", "Sophia", "Olivia", "Eden", "Charlotte", "Victoria", "Scarlet", "Grace"].selectRandom()
                }
                
                if gender == .male {
                    name += ["John", "Jack", "Richard", "Harry", "Thomas", "Timothy", "Mohammed", "Sam", "William", "Donald", "Malcolm", "Adam", "Daniel"].selectRandom()
                }
            
                name += " "
                name += ["Smith", "Doe", "Frederickson", "Christiansen", "Stevensen", "Windsor", "Kirk", "Paris", "Janeway", "Ryker", "Jones", "Williams", "Taylor", "Davies", "Brown", "Wilson", "Evans", "Cameron", "Reynolds", "Johnson", "Roberts", "Walker", "Wright", "Thompson", "Lee", "Miller"].selectRandom()
            
            case .tellarite:
                if gender == .female {
                    name += ["Pola", "Cherthish", "Zhuggaa", "Torthem", "Neshlel", "Verg", "Kholo", "Fratho", "Skig", "Vaolli", "Glavom", "Nihraogh", "Ghand", "Rensh"].selectRandom()
                }
            
                if gender == .male {
                    name += ["Prugm", "Brag", "Dash", "Gisich", "Gullerg", "Zankir", "Hellek", "Trar", "Jorsh", "Geshniv", "Tuk", "Rinkog", "Veth", "Cek", "Gullak"].selectRandom()
                }
            
                name += [" ", " bav", " glov", " blasch", " lorin", " jav", " bim", " glasch"].selectRandom()
            
                name += ["Gronnahk", "Nonkursh", "Slaal", "Ker", "Zhiv", "Blav", "Zhuffand", "Khebloss", "Pend", "Brin", "Wenkurn", "Gerkow", "Khutohk", "Jagh", "Krer"].selectRandom()
            case .trill(let joinedStatus):
                if gender == .female {
                    name += ["Audrid", "Azala", "Emony", "Kareel", "Lenara", "Nilani", "Reeza", "Zharaina", "Koria", "Lidra", "Diranne", "Kimoni", "Larista", "Vidria", "Kehdza"].selectRandom()
                }
                
                if gender == .male {
                    name += ["Arjin", "Bejal", "Curzon", "Hanor", "Joran", "Malko", "Selin", "Timor", "Tobin", "Torias", "Verad", "Yedrin", "Keman", "Sabin", "Joal", "Dorin"].selectRandom()
                }
                
                name += " "
                
                if joinedStatus == .joined {
                    name += ["Jexen", "Del", "Ogar", "Kyl", "Eku", "Nala", "Cela", "Pohr", "Ral", "Okir", "Etahn", "Lahl"].selectRandom()
                }
            
                if joinedStatus == .unjoined {
                    name += ["Nedan", "Sozenn", "Rulon", "Les", "Tral", "Inazin", "Hama", "Kelen", "Imonim", "Razix", "Idiron", "Paron", "Tanan", "Sulil", "Kerev"].selectRandom()
                }
            case .vulcan:
                if gender == .male {
                    name += ["Aravik", "Delvok", "Kovar", "Muroc", "Rekan", "Salok", "Savel", "Sevek", "Skon", "Soral", "Sutok", "Syrran", "Tekav", "Tolek", "Velik"].selectRandom()
                }
            
                if gender == .female {
                    name += ["Falor", "Metana", "Perren", "T’Karra", "T’Laan", "T’Lar", "T’Les", "T’Mal", "T’Paal", "T’Pan", "T’Rel", "T’Vran", "Seleya", "Simora", "V’Lar"].selectRandom()
                }
        }
        
        return name
    }
}
