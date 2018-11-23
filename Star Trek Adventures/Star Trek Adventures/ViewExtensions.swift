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
    static var characterTypeSegueIdentifier: String { return "CharacterTypeSegue" }
    static var npcViewSegueIdentifier: String { return "NPCViewSegue" }
    static var characterViewSegueIdentifier: String { return "CharacterViewSegue" }
    static var settingsViewSegueIdentifier: String { return "SettingsViewSegue" }
    static var  characterDetailViewSegueIdentifier: String { return "CharacterDetailViewSegue" }
}

extension UIScrollView {
    func scrollToTop() {
        let initialPosition = CGPoint(x: 0, y: -adjustedContentInset.top)
        setContentOffset(initialPosition, animated: true)
    }
}

extension UIScrollView {
    func capture() -> UIImage {
        let initialPosition = self.contentOffset
        UIGraphicsBeginImageContextWithOptions(CGSize(width: contentSize.width, height:  contentSize.height), false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()
        let previousFrame = frame
        
        frame = CGRect(x: frame.origin.x, y:  frame.origin.y, width: contentSize.width, height: contentSize.height)
        layer.render(in: context!)
        frame = previousFrame
        
        let screenshot: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        setContentOffset(initialPosition, animated: false)
        return screenshot
    }
}

extension Array where Element: Equatable {
    var listString: String {
        var string = ""
        
        for element in self {
            string.append("- " + String(describing: element).capitalized)
            
            if element != self.last {
                string.append("\n")
            }
        }
        return string
    }
}
