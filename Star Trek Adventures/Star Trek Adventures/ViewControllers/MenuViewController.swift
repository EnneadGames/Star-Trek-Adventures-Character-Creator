//
//  MenuViewController.swift
//  Star Trek Adventures
//
//  Created by Mars Geldard on 12/10/18.
//  Copyright © 2018 Mars Geldard. All rights reserved.
//

import UIKit
import os.log

class MenuViewController: UIViewController {

    // MARK: Outlets
    
    @IBOutlet weak var enterpriseEraButton: RoundedButton!
    @IBOutlet weak var originalEraButton: RoundedButton!
    @IBOutlet weak var modernEraButton: RoundedButton!
    
    // MARK: Actions
    
    @IBAction func unwindToMenuViewController(segue: UIStoryboardSegue) {}
    
    @IBAction func settingsButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: UIStoryboardSegue.settingsViewSegueIdentifier, sender: nil)
    }
    
    @IBAction func enterpriseEraButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: UIStoryboardSegue.characterTypeSegueIdentifier, sender: Era.enterprise)
    }
    
    @IBAction func originalEraButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: UIStoryboardSegue.characterTypeSegueIdentifier, sender: Era.original)
    }
    
    @IBAction func modernEraButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: UIStoryboardSegue.characterTypeSegueIdentifier, sender: Era.modern)
    }
    
    // MARK: Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        enterpriseEraButton.backgroundColor = .starTrekGold
        originalEraButton.backgroundColor = .starTrekBlue
        modernEraButton.backgroundColor = .starTrekRed
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == UIStoryboardSegue.characterTypeSegueIdentifier {
            guard let viewController = segue.destination as? CharacterTypeViewController else { return }
            guard let era = sender as? Era else { return }
            
            viewController.characterEra = era
        }
    }
}

