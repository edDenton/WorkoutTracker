//
//  strExtension.swift
//  WorkoutTracker
//
//  Created by Edward Denton on 5/13/24.
//

import Foundation

extension String {
    
    // Used in WorkoutViewModel to check that a setName is an int for when renumbering the sets
    var isInt: Bool {
        return Int(self) != nil
    }
}
