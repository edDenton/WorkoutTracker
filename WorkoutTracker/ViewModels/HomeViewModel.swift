//
//  HomeViewModel.swift
//  WorkoutTracker
//
//  Created by Edward Denton on 4/7/24.
//

import Foundation

class HomeViewModel: ObservableObject{
    private var currentDate = Date()
    private var calendar = Calendar.current
    
    init() {
        
    }
    
    func getTimeMessage() -> String{
        let hour = calendar.component(.hour, from: currentDate)
        
        if hour < 12 {
            return "Good morning!"
        } else if hour < 18 {
            return "Good afternoon!"
        } else {
            return "Good evening!"
        }
    }
}
