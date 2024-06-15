//
//  Exercise.swift
//  WorkoutTracker
//
//  Created by Edward Denton on 4/9/24.
//

import Foundation

struct Exercise: Codable, Identifiable{
    
    let id: String
    let name: String
    var sets: [ExerciseSet]
    
}
