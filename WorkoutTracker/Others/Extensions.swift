//
//  Extensions.swift
//  WorkoutTracker
//
//  Created by Edward Denton on 4/6/24.
//

import Foundation

extension Encodable {
    
    // Used to turn the user data into a dictionary to be saved into Firebase
    func asDictionary() -> [String: Any] {
        guard let data = try? JSONEncoder().encode(self) else {
            return [:]
        }
        
        do{
            let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
            return json ?? [:]
            
        } catch {
            return [:]
        }
    }
}
