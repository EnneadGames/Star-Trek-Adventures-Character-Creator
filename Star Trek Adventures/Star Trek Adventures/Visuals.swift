//
//  Visuals.swift
//  Star Trek Adventures
//
//  Created by Mars Geldard on 10/11/18.
//  Copyright © 2018 Mars Geldard. All rights reserved.
//

import UIKit

extension UIColor {
    static var starTrekRed: UIColor { return #colorLiteral(red: 0.8229936957, green: 0, blue: 0.1640901268, alpha: 1)}
    static var starTrekGold: UIColor { return #colorLiteral(red: 0.9607843137, green: 0.7607843137, blue: 0, alpha: 1)}
    static var starTrekBlue: UIColor { return #colorLiteral(red: 0, green: 0.4392156863, blue: 0.9607843137, alpha: 1) }
    static var starTrekTeal: UIColor { return #colorLiteral(red: 0, green: 0.6312587261, blue: 0.5469072461, alpha: 1) }
    
    static func uniformColor(for track: Track, from era: Era) -> UIColor {
        
        switch track {
        case .command:
            return era == .original ? .starTrekGold : .starTrekRed
            
        case .operations:
            return era == .original ? .starTrekRed : .starTrekGold
            
        case .science:
            return era == .enterprise ? .starTrekTeal : .starTrekBlue
        }
    }
}

extension UIImage {
    static var enterpriseIcon: UIImage { return #imageLiteral(resourceName: "enterprise") }
    static var originalCommandIcon: UIImage { return #imageLiteral(resourceName: "original-command") }
    static var originalOperationsIcon: UIImage { return #imageLiteral(resourceName: "original-operations") }
    static var originalScienceIcon: UIImage { return #imageLiteral(resourceName: "original-science") }
    static var modernIcon: UIImage { return #imageLiteral(resourceName: "modern") }
    static var defaultIcon: UIImage { return .originalCommandIcon }
    
    static func iconImage(for track: Track, from era: Era) -> UIImage {
        if era == .enterprise   {
            return .enterpriseIcon
        }
        
        if era == .modern {
            return .modernIcon
        }
        
        if era == .original {
            switch track {
            case .command: return .originalCommandIcon
            case .operations: return .originalOperationsIcon
            case .science: return .originalScienceIcon
            }
        }
        
        return .defaultIcon
    }
}
