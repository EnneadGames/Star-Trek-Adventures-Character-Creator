//
//  CharacterDetailViewController.swift
//  Star Trek Adventures
//
//  Created by Mars Geldard on 10/11/18.
//  Copyright © 2018 Mars Geldard. All rights reserved.
//

import UIKit

class CharacterDetailViewController: UIViewController {

    // MARK: Outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    
    @IBOutlet weak var controlLabel: UILabel!
    @IBOutlet weak var daringLabel: UILabel!
    @IBOutlet weak var fitnessLabel: UILabel!
    @IBOutlet weak var insightLabel: UILabel!
    @IBOutlet weak var presenceLabel: UILabel!
    @IBOutlet weak var reasonLabel: UILabel!
    
    @IBOutlet weak var commandLabel: UILabel!
    @IBOutlet weak var connLabel: UILabel!
    @IBOutlet weak var engineeringLabel: UILabel!
    @IBOutlet weak var securityLabel: UILabel!
    @IBOutlet weak var scienceLabel: UILabel!
    @IBOutlet weak var medicineLabel: UILabel!
    
    @IBOutlet weak var fociLabel: UILabel!
    @IBOutlet weak var talentsLabel: UILabel!
    @IBOutlet weak var traitsLabel: UILabel!
    @IBOutlet weak var valuesLabel: UILabel!
    
    @IBOutlet weak var stressLabel: UILabel!
    @IBOutlet weak var damageLabel: UILabel!
    
    @IBOutlet weak var equipmentLabel: UILabel!
    
    // MARK: Attributes
    
    private var attributeLabels: [UILabel] {
        return [controlLabel, daringLabel, fitnessLabel, insightLabel, presenceLabel, reasonLabel]
    }
    
    private var disciplineLabels: [UILabel] {
        return [commandLabel, connLabel, engineeringLabel, securityLabel, scienceLabel, medicineLabel]
    }
    
    private var coloredLabels: [UILabel] {
        return attributeLabels + disciplineLabels + [stressLabel, damageLabel]
    }
    
    func display(_ character: StarTrekCharacter, for era: Era) {
        self.nameLabel.text = character.name
        self.bioLabel.text = character.bio
        
        self.controlLabel.text = "\(character.attributes.control)"
        self.daringLabel.text = "\(character.attributes.daring)"
        self.fitnessLabel.text = "\(character.attributes.fitness)"
        self.insightLabel.text = "\(character.attributes.insight)"
        self.presenceLabel.text = "\(character.attributes.presence)"
        self.reasonLabel.text = "\(character.attributes.reason)"
        
        self.commandLabel.text = "\(character.disciplines.command)"
        self.connLabel.text = "\(character.disciplines.conn)"
        self.engineeringLabel.text = "\(character.disciplines.engineering)"
        self.securityLabel.text = "\(character.disciplines.security)"
        self.scienceLabel.text = "\(character.disciplines.science)"
        self.medicineLabel.text = "\(character.disciplines.medicine)"
        
        self.fociLabel.text = character.foci.listString
        self.talentsLabel.text = character.talents.listString
        self.traitsLabel.text = character.traits.listString
        self.valuesLabel.text = character.values.listString
        
        self.stressLabel.text = "\(character.stress)"
        self.damageLabel.text = "\(character.damageBonus)"
        self.equipmentLabel.text = character.equipment.listString
        
        let accentColor = UIColor.uniformColor(for: character.track, from: era)
        
        for label in coloredLabels {
            label.textColor = accentColor
        }
    }
}
