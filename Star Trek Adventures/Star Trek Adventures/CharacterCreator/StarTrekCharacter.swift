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

class StarTrekCharacter {
    
    // Creation attributes
    let species: Species
    let environment: Environment
    let upbringing: Upbringing
    let track: Track
    let careerLevel: CareerLevel
    let careerEvents: (first: CareerEvent, second: CareerEvent)
    
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
    var stress: Int { return attributes.fitness + disciplines.security }
    var damageBonus: Int { return disciplines.security }
    var pronouns: (personal: String, possessive: String) { return gender.pronouns }
    var bio: String {
        return "A \(gender) \(species.descriptor). \(pronouns.personal.capitalized) grew up \(environment.descriptor), where \(pronouns.personal) \(upbringing.acceptance) \(pronouns.possessive) upbringing that centred around \(upbringing.descriptor). \n\nLater \(pronouns.personal) went into the academy, pursuing the \(track) track. \(pronouns.personal.capitalized) majored in \(major) studies and minored in \(minors.first) and \(minors.second). Along the way \(pronouns.personal) learned valuable things about \(foci[0]), \(foci[1]) and \(foci[2]).\n\n\(pronouns.possessive.capitalized) life and career has been eventful, including events such as when \(pronouns.personal) \(careerEvents.first.descriptor), and when \(pronouns.personal) \(careerEvents.second.descriptor).\n\nNowadays, \(pronouns.personal) is \(careerLevel.descriptor), \(rank.descriptor) of \(age) years of age, and works in \(department) on a Federation starship."
    }
    
    init?(species: Species, environment: Environment, upbringing: Upbringing, track: Track, careerLevel: CareerLevel, careerEvents: (first: CareerEvent, second: CareerEvent)) {
        self.species = species
        self.environment = environment
        self.upbringing = upbringing
        self.track = track
        self.careerLevel = careerLevel
        self.careerEvents = careerEvents
        
        creationPhaseOne(species: self.species)
        creationPhaseTwo(environment: self.environment)
        creationPhaseThree(upbringing: self.upbringing)
        creationPhaseFour(track: self.track)
        creationPhaseFive(careerLevel: self.careerLevel)
        creationPhaseSix(careerEvents: self.careerEvents)
        creationPhaseSeven()
        
        if !isValidCharacter {
            return nil
        }
    }
    
    static func rollRandom(era: Era, expansions: [Expansion]) -> StarTrekCharacter? {
        
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

        return StarTrekCharacter(species: species, environment: environment, upbringing: upbringing, track: track, careerLevel: careerLevel, careerEvents: (firstCareerEvent, secondCareerEvent))
    }
    
    /// Gain species attributes, species trait, random talent.
    func creationPhaseOne(species: Species) {
        attributes.increase(species.attributes)
        traits.append(species.trait)
        /// 1 talent
    }
    
    /// Gain environment attribute, environment discipline, related value.
    func creationPhaseTwo(environment: Environment) {
        attributes.increase(environment.attributes.selectRandom())
        disciplines.increase(environment.disciplines.selectRandom())
        /// 1 value
        values.append("<Environment Value>")
    }
    
    /// Gain upbringing attributes, upbringing discipline, related focus and talent.
    func creationPhaseThree(upbringing: Upbringing) {
        attributes.increase(upbringing.attributes)
        disciplines.increase(upbringing.disciplines.selectRandom())
        foci.append(upbringing.foci.selectRandom())
        /// 1 talent
    }
    
    /// Gain track attributes, track discipline, random disciplines, track foci, related value and talent.
    func creationPhaseFour(track: Track) {
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

        /// 1 value
        values.append("<Track Value>")
        /// 1 talent
    }
    
    ///
    func creationPhaseFive(careerLevel: CareerLevel) {
        /// 1 value
        values.append("<Career Level Value>")
        if let careerLevelTalent = careerLevel.talent {
            talents.append(careerLevelTalent)
        } else {
            /// 1 talent
        }
    }
    
    /// Gain event attributes, event disciplines, event foci, optional event traits.
    func creationPhaseSix(careerEvents: (first: CareerEvent, second: CareerEvent)) {
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
        /// 1 value
        /// check attributes
        /// +1 to two attributes
        /// check disciplines
        /// +1 to two disciplines
        
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
