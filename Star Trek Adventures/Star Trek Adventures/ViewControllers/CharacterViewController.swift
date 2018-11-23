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
    
    @IBOutlet var accentView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
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
    var characterType: CharacterType = .player
    private var characterCreator: CharacterCreator? = nil
    private var character: StarTrekCharacter = StarTrekCharacter()
    private var characterDetailViewController: CharacterDetailViewController? = nil
    
    private var era: Era {
        guard let era = characterEra else {
            fatalError("CharacterViewController characterEra was: \(String(describing: characterEra))")
        }
        return era
    }
    
    // MARK: Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        characterCreator = CharacterCreator(era: era, expansions: Expansion.enabledExpansions, characterType: characterType)
        
        scrollView.delegate = self
        scrollView.indicatorStyle = .white
        scrollView.scrollIndicatorInsets = UIEdgeInsets(
            top: view.safeAreaInsets.top + 32, // height of accentView - safeArea margin
            left: view.safeAreaInsets.left,
            bottom: view.safeAreaInsets.bottom + 16, // height of blur overlay
            right: view.safeAreaInsets.right
        )
        
        getNewCharacter()
        updateIcon()
        updateView()
    }
    
    private func getNewCharacter() {
        guard let characterCreator = characterCreator else {
            fatalError("CharacterViewController did not have a valid CharacterCreator object.")
        }
        
        character = characterCreator.rollNewRandomCharacter()
    }
    
    private func updateIcon() {
        iconImageView.image = UIImage.iconImage(for: character.track, from: era)
    }
    
    private func updateView() {
        let accentColor = UIColor.uniformColor(for: character.track, from: era)
        self.view.backgroundColor = accentColor
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
        accentView.isHidden = true
        let characterImage = scrollView.capture()
        accentView.isHidden = false
        
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
    
    func scrollViewDidChangeAdjustedContentInset(_ scrollView: UIScrollView) {
        scrollView.scrollToTop()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.scrollView {
            accentView.frame.origin.y = scrollView.contentOffset.y
        }
    }
}
