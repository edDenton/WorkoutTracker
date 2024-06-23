//
//  WorkoutHistoryViewModel.swift
//  WorkoutTracker
//
//  Created by Edward Denton on 4/8/24.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class WorkoutHistoryViewModel: ObservableObject {
    @Published var workouts: [Workout] = []
    private var db = Firestore.firestore()
    
    // Grabs all previously saved workouts to be shown in WorkoutHistoryView
    @MainActor
    func fetchWorkouts() {
        guard let user = Auth.auth().currentUser else {
            print("No authenticated user")
            return
        }
        let userID = user.uid
        
        Task{
            do {
                workouts = []
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
                    workouts.append(Workout(id: UUID().uuidString,
                                            exercises: exerciseList,
                                            dateWorkedOutOn: dateWorkedOutOn))
                }
            } catch {
                print("Error getting documents: \(error)")
            }
        }
    }
}

