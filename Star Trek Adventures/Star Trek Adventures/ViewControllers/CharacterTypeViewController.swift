//
//  CharacterTypeViewController.swift
//  Star Trek Adventures
//
//  Created by Mars Geldard on 12/11/18.
//  Copyright © 2018 Mars Geldard. All rights reserved.
//

import UIKit

class CharacterTypeViewController: UIViewController {

    var characterEra: Era? = nil
    
    private var era: Era {
        guard let era = characterEra else {
            fatalError("CharacterViewController characterEra was: \(String(describing: characterEra))")
        }
        return era
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == UIStoryboardSegue.characterViewSegueIdentifier {
            guard let viewController = segue.destination as? CharacterViewController else { return }
            viewController.characterEra = self.era
        }
    }
}
