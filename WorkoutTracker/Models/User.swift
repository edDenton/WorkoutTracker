//
//  User.swift
//  WorkoutTracker
//
//  Created by Edward Denton on 4/2/24.
//

import Foundation

struct User: Codable{
    
    let id: String
    let name: String
    let email: String
    let joined: TimeInterval
    
}
