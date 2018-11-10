//
//  ViewExtensions.swift
//  Star Trek Adventures
//
//  Created by Mars Geldard on 4/11/18.
//  Copyright © 2018 Mars Geldard. All rights reserved.
//

import UIKit

extension UIButton.State {
    static var selectedHighlighted: UIButton.State { return UIControl.State.selected.union(.highlighted) }
}

extension UIStoryboardSegue {
    static var characterViewSegueIdentifier: String { return "CharacterViewSegue" }
    static var settingsViewSegueIdentifier: String { return "SettingsViewSegue" }
    static var  characterDetailViewSegueIdentifier: String { return "CharacterDetailViewSegue" }
}

extension UIScrollView {
    func scrollToTop() {
        let initialOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(initialOffset, animated: true)
    }
}

extension UIView {
    func capture() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        let snapshot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return snapshot ?? UIImage()
    }
}

extension Array where Element: Equatable {
    var listString: String {
        var string = ""
        
        for element in self {
            string.append("- " + String(describing: element))
            
            if element != self.last {
                string.append("\n")
            }
        }
        return string
    }
}
