//
//  Expansions.swift
//  Star Trek Adventures
//
//  Created by Mars Geldard on 10/11/18.
//  Copyright © 2018 Mars Geldard. All rights reserved.
//

import Foundation

enum Expansion {
    case betaQuadrant, commandDivision
    
    var id: String {
        return "\(String(describing: self).hashValue)"
    }
    
    var isEnabled: Bool {
        return UserDefaults.standard.bool(forKey: self.id) == true
    }
    
    func set(enabled isEnabled: Bool) {
        UserDefaults.standard.set(isEnabled, forKey: self.id)
    }
}
