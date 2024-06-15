//
//  Workout.swift
//  WorkoutTracker
//
//  Created by Edward Denton on 4/10/24.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

class WorkoutViewModel: ObservableObject{
    @Published var exerciseList: [String] = []
    @Published var muscleGroups: Set<String> = ["Chest", "Back", "Legs", "Shoulders", "Biceps", "Triceps", "Forearms"]
    @Published var selectedExercise: String = ""
    @Published var showAddExerciseView: Bool = false
    @Published var workout: Workout = Workout(id: UUID().uuidString,
                                              exercises: [],
                                              dateWorkedOutOn: Date().timeIntervalSince1970)
    
    var listOfCurrentExercises: Set<String> = []
    
    //    @Published var workout: Workout = Workout(id: UUID().uuidString,
    //                                              exercises: [Exercise(id: UUID().uuidString,
    //                                                                   name: "Exercise Example",
    //                                                                   sets: [ExerciseSet(id: UUID().uuidString, name: "1", reps: 0, weight: 0),
    //                                                                          ExerciseSet(id: UUID().uuidString, name: "2", reps: 0, weight: 0),
    //                                                                          ExerciseSet(id: UUID().uuidString, name: "3", reps: 0, weight: 0)])],
    //                                              dateWorkedOutOn: Date().timeIntervalSince1970)
    
    init(){
        self.exerciseList = makeExerciseList()
        
    }
    
    func save(){
        guard let uId = Auth.auth().currentUser?.uid else{
            return
        }
        let db = Firestore.firestore()
        
        let idForWorkout = UUID().uuidString
        var dataDict: Dictionary<String, [Any]> = [:]
        
        for exercise in workout.exercises {
            var setList: [String] = []
            for index in 0...exercise.sets.count - 1{
                setList.append(exercise.sets[index].name)
                setList.append(String(exercise.sets[index].weight))
                setList.append(String(exercise.sets[index].reps))
            }
            dataDict.updateValue(setList, forKey: exercise.name)
        }
        
        dataDict.updateValue([String(workout.dateWorkedOutOn)], forKey: "dateWorkedOutOn")
        
        db.collection("users")
            .document(uId)
            .collection("workouts")
            .document(idForWorkout)
            .setData(dataDict)
        
        deleteWorkout()
    }
    
    func addExerciseToWorkout(){
        if !listOfCurrentExercises.contains(selectedExercise) {
            workout.exercises.append(Exercise(id: UUID().uuidString, name: selectedExercise, sets: [ExerciseSet(id: UUID().uuidString, name: "1", reps: 0, weight: 0)]))
            listOfCurrentExercises.insert(selectedExercise)
        }
        selectedExercise = ""
        showAddExerciseView = false
    }
    
    func addSet(currentExerciseIndex: Int){
        workout.exercises[currentExerciseIndex].sets.append(ExerciseSet(id: UUID().uuidString, name: String(workout.exercises[currentExerciseIndex].sets.count + 1), reps: 0, weight: 0))
        renumberSets(currentExerciseIndex: currentExerciseIndex)
    }
    
    func deleteWorkout(){
        workout = Workout(id: UUID().uuidString, exercises: [], dateWorkedOutOn: Date().timeIntervalSince1970)
    }
    
    func deleteExercise(currentExerciseIndex: Int){
        listOfCurrentExercises.remove(workout.exercises[currentExerciseIndex].name)
        workout.exercises.remove(at: currentExerciseIndex)
    }
    
    func deleteSet(currentExerciseIndex: Int, currentSetIndex: Int){
        workout.exercises[currentExerciseIndex].sets.remove(at: currentSetIndex)
        renumberSets(currentExerciseIndex: currentExerciseIndex)
    }
    
    func turnSetToWarmup(currentExerciseIndex: Int, currentSetIndex: Int){
        if workout.exercises[currentExerciseIndex].sets[currentSetIndex].name == "W" {
            workout.exercises[currentExerciseIndex].sets[currentSetIndex].name = "1"
        } else {
            workout.exercises[currentExerciseIndex].sets[currentSetIndex].name = "W"
        }
        renumberSets(currentExerciseIndex: currentExerciseIndex)
    }
    
    private func renumberSets(currentExerciseIndex: Int){
        var setNumber = 1
        if workout.exercises[currentExerciseIndex].sets.count != 0 {
            for index in 0...workout.exercises[currentExerciseIndex].sets.count - 1{
                if workout.exercises[currentExerciseIndex].sets[index].name.isInt{
                    workout.exercises[currentExerciseIndex].sets[index].name = String(setNumber)
                    setNumber += 1
                }
            }
        } else {
            deleteExercise(currentExerciseIndex: currentExerciseIndex)
        }
    }
    
    private func makeExerciseList() -> [String]{
        return ["Chest",
                "Dips",
                "Bench Press",
                "Bench Press (Dumbbells)",
                "Incline Press",
                "Incline Press (Dumbbells)",
                "Decline Press",
                "Decline Press (Dumbbells)",
                "Smith-Machine Bench Press",
                "Smith-Machine Incline Press",
                "Smith-Machine Decline Press",
                "Chest Fly (Machine)",
                "Chest Fly (Dumbbells)",
                "Chest Fly (Cables)",
                "Back",
                "Deadlift",
                "Chest-Supported Row",
                "Seated Row",
                "MTS Row",
                "Assisted Pull-ups",
                "Pull-ups",
                "Single-arm Pulldowns",
                "Lat Pulldowns (Cables)",
                "Lat Pulldowns (Machines)",
                "MTS Front Pulldown",
                "Good Morning",
                "Legs",
                "Leg Press",
                "Smith-Machine Squats",
                "Barbell Squats",
                "Hack Squats",
                "Split Squats",
                "Leg Extension",
                "Lunges",
                "Seated Leg Curl",
                "Lying Leg Curl",
                "Romanian Deadlift",
                "Hip Thrust",
                "Seated Calf Raises",
                "Standing Calf Raises",
                "Shoulders",
                "Lateral Raises (Cable)",
                "Lateral Raises (Dumbbell)",
                "Lateral Raises (Machine)",
                "Face Pull",
                "Shoulder Press (Cable)",
                "Shoulder Press (Dumbbell)",
                "Shoulder Press (Machine)",
                "Reverse Machine Fly",
                "Reverse Dumbbell Fly",
                "Biceps",
                "Barbell Curl",
                "Hammer Curl",
                "Spider Curl",
                "Preacher Curl",
                "Triceps",
                "Tricep Extension (Machine)",
                "Tricep Extension (Cable)",
                "Overhead Tricep Extension (Dumbbell)",
                "Overhead Tricep Extension (Cable)",
                "Skull Crushers",
                "Tricep Pushdown",
                "Forearms",
                "Barbell Wrist Curl",
                "Dumbbell Wrist Curl",
                "Barbell Wrist Extension",
                "Dumbbell Wrist Extension",
                "Grippers",
        ]
    }
}
