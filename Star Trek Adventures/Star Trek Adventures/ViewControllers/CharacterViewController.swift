//
//  CharacterViewController.swift
//  Star Trek Adventures
//
//  Created by Mars Geldard on 4/11/18.
//  Copyright © 2018 Mars Geldard. All rights reserved.
//

import UIKit

class CharacterViewController: UIViewController {

    // MARK: Outlets
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var accentView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var randomButton: RoundedButton!
    
    //  MARK: Actions
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        saveCharacter()
    }
    
    @IBAction func randomButtonPressed(_ sender: Any) {
        getNewCharacter()
        updateView()
    }
    
    // MARK: Attributes
    
    var characterEra: Era? = nil
    private var characterObject: StarTrekCharacter? = nil
    private var characterDetailViewController: CharacterDetailViewController? = nil
    
    private var era: Era {
        guard let era = characterEra else {
            fatalError("CharacterViewController characterEra was: \(String(describing: characterEra))")
        }
        return era
    }
    
    private var character: StarTrekCharacter {
        guard let character = characterObject else {
            fatalError("CharacterViewController characterObject was: \(String(describing: characterObject))")
        }
        return character
    }
    
    // MARK: Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        
        getNewCharacter()
        updateView()
        updateIcon()
    }
    
    private func getNewCharacter() {
        characterObject = StarTrekCharacter(era: era)
    }
    
    private func updateIcon() {
        iconImageView.image = UIImage.iconImage(for: character.track, from: era)
    }
    
    private func updateView() {
        let accentColor = UIColor.uniformColor(for: character.track, from: era)
        headerView.backgroundColor = accentColor
        accentView.backgroundColor = accentColor
        randomButton.backgroundColor = accentColor
        characterDetailViewController?.display(character, for: era)
        
        if era == .original {
            updateIcon()
        }
        
        scrollView.scrollToTop()
    }
    
    private func saveCharacter() {
        let characterImage = contentView.capture()
        PhotosAlbum.shared.saveImage(image: characterImage) { success, error in
            if let error = error {
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == UIStoryboardSegue.characterDetailViewSegueIdentifier {
            if let viewController = segue.destination as? CharacterDetailViewController {
                self.characterDetailViewController = viewController
                viewController.view.translatesAutoresizingMaskIntoConstraints = false
            }
        }
    }
}

extension CharacterViewController: UIScrollViewDelegate {
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if scrollView == self.scrollView {
//            accentView.frame.origin.y = scrollView.contentOffset.y
//        }
//    }
}
