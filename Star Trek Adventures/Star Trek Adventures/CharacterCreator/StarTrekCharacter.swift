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

enum CharacterType {
    case player, npc
}

final class CharacterCreator {
    
    private let era: Era
    private let expansions: [Expansion]
    private let characterType: CharacterType
    private(set) var characterObject: StarTrekCharacter?
    var character: StarTrekCharacter {
        guard let character = characterObject else {
            fatalError("The CharacterCreator did not have a valid character object.")
        }
        
        return character
    }
    
    init(era: Era, expansions: [Expansion], characterType: CharacterType) {
        self.era = era
        self.expansions = expansions
        self.characterType = characterType
    }
    
    func rollNewRandomCharacter() -> StarTrekCharacter {
        let character = StarTrekCharacter()
        
        repeat {
            let species = Species.rollRandom(era: era, expansions: expansions)
            let environment = Environment.rollRandom(species: species, era: era, expansions: expansions)
            let upbringing = Upbringing.rollRandom()
            let track = Track.rollRandom()
            let careerLevel = CareerLevel.rollRandom()
            
            let firstCareerEvent = CareerEvent.rollRandom()
            var secondCareerEvent: CareerEvent
            repeat {
                secondCareerEvent = CareerEvent.rollRandom()
            } while secondCareerEvent == firstCareerEvent
            
            character.creationPhaseOne(species: species)
            character.creationPhaseTwo(environment: environment)
            character.creationPhaseThree(upbringing: upbringing)
            character.creationPhaseFour(track: track)
            character.creationPhaseFive(careerLevel: careerLevel)
            character.creationPhaseSix(careerEvents: (firstCareerEvent, secondCareerEvent))
            character.creationPhaseSeven()
        } while !character.isValidCharacter
        
        return character
    }
}

class StarTrekCharacter {
    
    // Creation attributes
    private(set) var species: Species = .human
    private(set) var environment: Environment = .homeworld(.human)
    private(set) var upbringing: Upbringing = .starfleet(.accepted)
    private(set) var track: Track = .command
    private(set) var careerLevel: CareerLevel = .experienced
    private(set) var careerEvents: (first: CareerEvent, second: CareerEvent) = (.mentored, .firstContact)
    
    // Accumulated attributes
    private(set) var attributes = AttributeSet()
    private(set) var disciplines = DisciplineSet()
    private(set) var foci: [Focus] = []
    private(set) var talents: [Talent] = []
    private(set) var traits: [Trait] = []
    private(set) var values: [Value] = []
    private(set) var equipment: [Equipment] = []
    
    // Flavour attributes
    private(set) var major: Discipline = .command
    private(set) var minors: (first: Discipline, second: Discipline) = (.command, .command)
    private(set) var name: String = "Character Name"
    private(set) var age: Int = 35
    private(set) var gender: Gender = .male
    private(set) var department: Discipline = .command
    private(set) var rank: Rank = .juniorLieutenant
    
    var isValidCharacter: Bool {
        //return attributes.total == 56 && disciplines.total == 16 && values.count == 4 && talents.count == 4 && foci.count == 6
        return true
    }
    
    // Derived attributes
    var hasUntappedPotential: Bool { return talents.contains("Untapped Potential") }
    var stress: Int { return attributes.fitness + disciplines.security }
    var damageBonus: Int { return disciplines.security }
    var pronouns: (personal: String, possessive: String) { return gender.pronouns }
    var bio: String {
        return "A \(gender) \(species.descriptor). \(pronouns.personal.capitalized) grew up \(environment.descriptor), where \(pronouns.personal) \(upbringing.acceptance) \(pronouns.possessive) upbringing that centred around \(upbringing.descriptor). \n\nLater \(pronouns.personal) went into the academy, pursuing the \(track) track. \(pronouns.personal.capitalized) majored in \(major) studies and minored in \(minors.first) and \(minors.second). Along the way \(pronouns.personal) learned valuable things about \(foci[0]), \(foci[1]) and \(foci[2]).\n\n\(pronouns.possessive.capitalized) life and career has been eventful, including events such as when \(pronouns.personal) \(careerEvents.first.descriptor), and when \(pronouns.personal) \(careerEvents.second.descriptor).\n\nNowadays, \(pronouns.personal) is \(careerLevel.descriptor), \(rank.descriptor) of \(age) years of age, and works in \(department) on a Federation starship."
    }
    
    /// Gain species attributes, species trait, random talent.
    func creationPhaseOne(species: Species) {
        self.species = species
        attributes.increase(species.attributes)
        traits.append(species.trait)
        talents.append(species.talents.selectRandom())
    }
    
    /// Gain environment attribute, environment discipline, related value.
    func creationPhaseTwo(environment: Environment) {
        self.environment = environment
        attributes.increase(environment.attributes.selectRandom())
        disciplines.increase(environment.disciplines.selectRandom())
        values.append("<Environment Value>")
    }
    
    /// Gain upbringing attributes, upbringing discipline, related focus and talent.
    func creationPhaseThree(upbringing: Upbringing) {
        self.upbringing = upbringing
        attributes.increase(upbringing.attributes)
        disciplines.increase(upbringing.disciplines.selectRandom())
        foci.append(upbringing.foci.selectRandom())
        talents.append(disciplines.qualifyingTalents.selectRandom())
    }
    
    /// Gain track attributes, track discipline, random disciplines, track foci, related value and talent.
    func creationPhaseFour(track: Track) {
        self.track = track
        attributes.increase(Attribute.selectRandom())
        attributes.increase(Attribute.selectRandom(count: 2))
        
        let studySet = StudySet.selectRandom(track: track)
        major = studySet.major
        minors = studySet.minors
        disciplines.increase(studySet.disciplines)
        
        var trackFoci: [Focus]
        repeat {
            trackFoci = track.foci.selectRandom(count: 3)
        } while trackFoci.hasOverlap(with: foci)
        foci += trackFoci
        values.append("<Track Value>")
        talents.append(disciplines.qualifyingTalents.selectRandom())
    }
    
    ///
    func creationPhaseFive(careerLevel: CareerLevel) {
        self.careerLevel = careerLevel
        values.append("<Career Level Value>")
        if let careerLevelTalent = careerLevel.talent {
            talents.append(careerLevelTalent)
        } else {
            talents.append(disciplines.qualifyingTalents.selectRandom())
        }
    }
    
    /// Gain event attributes, event disciplines, event foci, optional event traits.
    func creationPhaseSix(careerEvents: (first: CareerEvent, second: CareerEvent)) {
        self.careerEvents = careerEvents
        attributes.increase([careerEvents.first.attribute, careerEvents.second.attribute])
        disciplines.increase([careerEvents.first.discipline, careerEvents.second.discipline])
        
        var eventFoci: [Focus]
        repeat {
            eventFoci = [careerEvents.first.foci.selectRandom(), careerEvents.second.foci.selectRandom()]
        } while eventFoci.hasOverlap(with: foci)
        foci += eventFoci
        
        if let firstEventTrait = careerEvents.first.trait {
            traits.append(firstEventTrait)
        }
        
        if let secondEventTrait = careerEvents.second.trait {
            traits.append(secondEventTrait)
        }
    }
    
    func creationPhaseSeven() {
        values.append("<Overall Value>")
        let attributeLimit = self.hasUntappedPotential ? 11 : 12
        var attributesPool = attributes.adjust(to: attributeLimit) + 2
        while attributesPool > 0 {
            if attributes.lowestValue == attributeLimit { continue }
            
            let randomAttribute = Attribute.allCases.selectRandom()
            if attributes[randomAttribute] < attributeLimit {
                attributesPool -= 1
                attributes[randomAttribute] += 1
            }
        }
        
        let disciplineLimit = self.hasUntappedPotential ? 4 : 5
        var disciplinesPool = disciplines.adjust(to: disciplineLimit) + 2
        while disciplinesPool > 0 {
            if disciplines.lowestValue == disciplineLimit { continue }
            
            let randomDiscipline = Discipline.allCases.selectRandom()
            if disciplines[randomDiscipline] < disciplineLimit {
                disciplinesPool -= 1
                disciplines[randomDiscipline] += 1
            }
        }
        
        gender = species.genders.selectRandom()
        name = species.name(for: gender)
        age = species.age(for: careerLevel)
        department = disciplines.highestIn(track: track)
        rank = careerLevel.ranks.selectRandom()
        /// role
        equipment = ["Uniforms", "Communicator", "Tricorder"]
        
        if department == .security || rank > .lieutenantCommander {
            equipment.append("Type 2 Phaser")
        } else {
            equipment.append("Type 1 Phaser")
        }
    }
}
