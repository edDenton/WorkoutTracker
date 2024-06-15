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
    
    var repsString: String {
        get { String(reps) }
        set { reps = Int(newValue) ?? 0 }
    }
    
    var weightString: String {
        get { String(weight) }
        set { weight = Int(newValue) ?? 0 }
    }

    mutating func setWeight(newWeight: String){
        weight = Int(newWeight)!
    }
    
    mutating func setReps(newReps: String){
        reps = Int(newReps)!
    }
}
