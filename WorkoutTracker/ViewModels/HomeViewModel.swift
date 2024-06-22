//
//  HomeViewModel.swift
//  WorkoutTracker
//
//  Created by Edward Denton on 4/7/24.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class HomeViewModel: ObservableObject{
    @Published var previousWorkout: Workout = Workout(id: "INITIALIZER", exercises: [], dateWorkedOutOn: 0.0)
    private var db = Firestore.firestore()
    private var currentDate = Date()
    private var calendar = Calendar.current
    
    
    init() {
        
    }
    
    @MainActor
    func fetchWorkouts() {
        
        guard let user = Auth.auth().currentUser else {
            print("No authenticated user")
            return
        }
        let userID = user.uid
        
        Task{
            do {
                let querySnapshot = try await db.collection("users").document(userID).collection("workouts").getDocuments()
                
                for document in querySnapshot.documents {
                    let dataDict: Dictionary<String, [String]> = try document.data(as: Dictionary<String, [String]>.self)
                    
                    var dateWorkedOutOn: Double = 0.0
                    var exerciseList: [Exercise] = []
                    var setList: [ExerciseSet] = []
                    
                    for key in dataDict.keys{
                        if key == "dateWorkedOutOn" {
                            if let dateString = dataDict[key], let dateDouble = Double(dateString[0]){
                                dateWorkedOutOn = dateDouble
                            }
                        } else {
                            setList = []
                            let limitOnLoop = (dataDict[key]!.count / 3) - 1
                            for index in 0...limitOnLoop {
                                setList.append(ExerciseSet(id: UUID().uuidString,
                                                           name: dataDict[key]![3 * index],
                                                           reps: Int(dataDict[key]![3 * index + 1])!,
                                                           weight: Int(dataDict[key]![3 * index + 2])!))
                            }
                            exerciseList.append(Exercise(id: UUID().uuidString,
                                                         name: key,
                                                         sets: setList))
                        }
                    }
                    previousWorkout = Workout(id: UUID().uuidString, exercises: exerciseList, dateWorkedOutOn: dateWorkedOutOn)
                    break;
                }
            } catch {
                print("Error getting documents: \(error)")
            }
        }
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
