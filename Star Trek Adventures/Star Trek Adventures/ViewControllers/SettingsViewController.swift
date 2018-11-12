//
//  SettingsViewController.swift
//  Star Trek Adventures
//
//  Created by Mars Geldard on 4/11/18.
//  Copyright © 2018 Mars Geldard. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    // MARK: Outlets
    
    @IBOutlet private weak var betaQuadrantButton: RoundedButton!
    @IBOutlet private weak var commandDivisionButton: RoundedButton!
  
    // MARK: Actions
    
    @IBAction private func betaQuadrantButtonPressed(_ sender: Any) {
        betaQuadrantButton.isSelected = !betaQuadrantButton.isSelected
        Expansion.betaQuadrant.set(enabled: betaQuadrantButton.isSelected)
    }
    
    @IBAction private func commandDivisionButtonPressed(_ sender: Any) {
        commandDivisionButton.isSelected = !commandDivisionButton.isSelected
        Expansion.commandDivision.set(enabled: commandDivisionButton.isSelected)
    }
    
    // MARK: Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        betaQuadrantButton.backgroundColor = .starTrekTeal
        commandDivisionButton.backgroundColor = .starTrekTeal
        
        betaQuadrantButton.isSelected = Expansion.betaQuadrant.isEnabled
        commandDivisionButton.isSelected = Expansion.commandDivision.isEnabled
    }
}
