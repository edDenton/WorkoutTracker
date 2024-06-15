//
//  WorkoutTrackerApp.swift
//  WorkoutTracker
//
//  Created by Edward Denton on 4/1/24.
//

import Firebase
import FirebaseCore
import SwiftUI

@main
struct WorkoutTrackerApp: App {
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
