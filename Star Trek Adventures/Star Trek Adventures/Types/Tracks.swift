//
//  Tracks.swift
//  Star Trek Adventures
//
//  Created by Mars Geldard on 4/11/18.
//  Copyright © 2018 Mars Geldard. All rights reserved.
//

import Foundation

enum Track: CaseIterable {
    case command, operations, science
    
    static func selectRandom() -> Track {
        guard let randomTrack = self.allCases.randomElement() else {
            fatalError("Track enum had no cases!")
        }
        
        return randomTrack
    }
}
