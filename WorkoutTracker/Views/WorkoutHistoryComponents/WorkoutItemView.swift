//
//  WorkoutItemView.swift
//  WorkoutTracker
//
//  Created by Edward Denton on 5/26/24.
//

import SwiftUI

struct WorkoutItemView: View {
    @State var isExpanded: Bool = false
    let workout: Workout
    var exerciseString: String = "\n"
    
    init(workout: Workout) {
        self.workout = workout
        for exercise in workout.exercises {
            exerciseString = exerciseString + exercise.name + " -"
        }
    }
    
    var body: some View {
        VStack{
            DisclosureGroup("\(Date(timeIntervalSince1970: workout.dateWorkedOutOn).formatted(date: .abbreviated, time: .omitted))", isExpanded: $isExpanded){
                ForEach(workout.exercises) { exercise in
                    Text(exercise.name)
                        .bold()
                        .font(.system(size: 18))
                        .frame(width: UIScreen.main.bounds.width - 35, alignment: .leading)
                        .padding(.top, 5)
                        .padding(.bottom, -1)
                     
                    HStack{
                        Text("Set Number")
                            .font(.system(size: 16))
                            .padding(.trailing, 5)
                        
                        Text("Weight")
                            .font(.system(size: 16))
                            .padding(.trailing, 5)
                        
                        Text("Repetitions")
                            .font(.system(size: 16))
                            .padding(.trailing, 5)
                    }
                    .frame(width: UIScreen.main.bounds.width - 60, alignment: .leading)

                    SetView(exercise: exercise)
                }
            }
            .frame(alignment: .leading)
            .foregroundStyle(Color.primary)
            .font(.system(size: 22))
            .padding(.vertical, 10)
            .padding(.horizontal, 8)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(8)
            .onTapGesture {
                withAnimation {
                    isExpanded.toggle()
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width - 10)
    }
    
    struct SetView: View{
        let exercise: Exercise
        
        var body: some View{
            
            VStack{
                ForEach(exercise.sets){ exerciseSet in
                    HStack{
                        Text(exerciseSet.name)
                            .font(.system(size: 16))
                            .frame(width: 50, height: 20)
                            .multilineTextAlignment(.center)
                        
                        Text(String(exerciseSet.weight))
                            .font(.system(size: 16))
                            .frame(width: 50, height: 20)
                            .multilineTextAlignment(.center)
                            .padding(.leading, 24)
                        
                        Text(String(exerciseSet.reps))
                            .font(.system(size: 16))
                            .frame(width: 50, height: 20)
                            .multilineTextAlignment(.center)
                            .padding(.leading, 20)
                    }
                    .frame(width: UIScreen.main.bounds.width - 100, alignment: .leading)
                    
                }
            }
            
        }
    }
}

#Preview {
    WorkoutItemView(workout: Workout(id: UUID().uuidString,
                                     exercises: [Exercise(id: UUID().uuidString,
                                                          name: "Exercise Example",
                                                          sets: [ExerciseSet(id: UUID().uuidString, name: "1", reps: 10, weight: 100),
                                                                 ExerciseSet(id: UUID().uuidString, name: "2", reps: 8, weight: 100),
                                                                 ExerciseSet(id: UUID().uuidString, name: "3", reps: 6, weight: 100)])],
                                     dateWorkedOutOn: Date().timeIntervalSince1970))
}
