//
//  Workout.swift
//  WorkoutTracker
//
//  Created by Edward Denton on 4/9/24.
//

import Foundation
import SwiftUI

struct Workout: Codable, Identifiable{
    
    let id: String
    var exercises: [Exercise]
    let dateWorkedOutOn: TimeInterval
    
}
