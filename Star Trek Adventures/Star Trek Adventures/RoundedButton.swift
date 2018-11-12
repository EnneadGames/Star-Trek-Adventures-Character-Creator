//
//  RoundedButton.swift
//  Star Trek Adventures
//
//  Created by Mars Geldard on 10/11/18.
//  Copyright © 2018 Mars Geldard. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {
    
    private static var defaultCornerRadius: CGFloat = 12
    private static var defaultFontSize: CGFloat = 24
    
    override var backgroundColor: UIColor? {
        didSet {
            super.backgroundColor = backgroundColor
            
            if let newBackgroundColor = backgroundColor {
                setAppearance(backgroundColor: newBackgroundColor, forState: .selected)
            }
            
            if let darkerColor = backgroundColor?.darkened(by: 30) {
                setAppearance(backgroundColor: darkerColor, forState: .selectedHighlighted)
            }
            
            setAppearance(backgroundColor: .gray, forState: .normal)
            setAppearance(backgroundColor: .darkGray, forState: .highlighted)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setDefaultAppearance()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setDefaultAppearance()
    }
    
    private func setDefaultAppearance() {
        self.layer.cornerRadius = RoundedButton.defaultCornerRadius
        self.layer.masksToBounds = true
        self.titleLabel?.textColor = .white
        
        let currentTitleText = self.titleLabel?.text ?? "Button"
        let styledTitleText = NSAttributedString(string: currentTitleText, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: RoundedButton.defaultFontSize)])
        self.titleLabel?.attributedText = styledTitleText
        
        self.isSelected = true
    }
    
    private func setAppearance(backgroundColor: UIColor, textColor: UIColor = .white, forState state: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()!.setFillColor(backgroundColor.cgColor)
        UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.setBackgroundImage(colorImage, for: state)
        self.setTitleColor(textColor, for: state)
    }
}
