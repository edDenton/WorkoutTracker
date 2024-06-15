//
//  ExerciseSet.swift
//  WorkoutTracker
//
//  Created by Edward Denton on 5/5/24.
//

import Foundation

struct ExerciseSet: Codable, Identifiable{
    
    let id: String
    var name: String
    var reps: Int
    var weight: Int
    
}
