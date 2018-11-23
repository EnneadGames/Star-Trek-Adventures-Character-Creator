//
//  CharacterTypeViewController.swift
//  Star Trek Adventures
//
//  Created by Mars Geldard on 12/11/18.
//  Copyright © 2018 Mars Geldard. All rights reserved.
//

import UIKit

class CharacterTypeViewController: UIViewController {

    @IBOutlet weak var playerCharacterButton: RoundedButton!
    @IBOutlet weak var nonPlayerCharacterButton: RoundedButton!
    
    @IBAction func playerCharacterButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: UIStoryboardSegue.characterViewSegueIdentifier, sender: nil)
    }
    @IBAction func nonplayerCharacterButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: UIStoryboardSegue.npcViewSegueIdentifier, sender: nil)
    }
    
    var characterEra: Era? = nil
    
    private var era: Era {
        guard let era = characterEra else {
            fatalError("CharacterViewController characterEra was: \(String(describing: characterEra))")
        }
        return era
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        playerCharacterButton.backgroundColor = .starTrekGold
        nonPlayerCharacterButton.backgroundColor = .starTrekRed
    }
}
