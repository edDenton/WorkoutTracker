//
//  Extensions.swift
//  WorkoutTracker
//
//  Created by Edward Denton on 4/6/24.
//

import Foundation
import UIKit
import SwiftUI

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

extension String {
    
    // Used in WorkoutViewModel to check that a setName is an int for when renumbering the sets
    var isInt: Bool {
        return Int(self) != nil
    }
}
