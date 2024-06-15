//
//  ExerciseDisplayViewV2.swift
//  WorkoutTracker
//
//  Created by Edward Denton on 5/11/24.
//

import SwiftUI

struct ExerciseDisplayView: View {
    @EnvironmentObject var viewModel: WorkoutViewModel
    
    var body: some View {
        VStack{
            ForEach(viewModel.workout.exercises.indices, id: \.self) { index in
                
                ExerciseOutlineView(currentExerciseIndex: index)
                    .environmentObject(viewModel)
                
                SetView(currIndex: index)
                    .environmentObject(viewModel)
                
                NewSetButton(currentExerciseIndex: index)
                    .environmentObject(viewModel)
                    
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray)
                    .padding(.vertical, 10)
            }
        }
    }

    
    struct ExerciseOutlineView: View {
        @EnvironmentObject var viewModel: WorkoutViewModel
        @State private var showExerciseDeletionAlert = false
        var currentExerciseIndex: Int
        
        var body: some View {
            if currentExerciseIndex < viewModel.workout.exercises.count {
                let currentExercise = viewModel.workout.exercises[currentExerciseIndex]
                
                HStack {
                    Text(currentExercise.name)
                        .bold()
                        .font(.system(size: 25))
                        .frame(width: UIScreen.main.bounds.width - 60, alignment: .leading)
                    
                    Button {
                        showExerciseDeletionAlert = true
                    } label: {
                        ZStack {
                            Circle()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.red)
                            
                            Image(systemName: "trash.fill")
                                .foregroundColor(.white)
                                .font(.body)
                        }
                    }
                    .alert(isPresented: $showExerciseDeletionAlert) {
                        Alert(
                            title: Text("Delete Exercise?"),
                            primaryButton: .destructive(Text("Delete"), action: {
                                viewModel.deleteExercise(currentExerciseIndex: currentExerciseIndex)
                            }),
                            secondaryButton: .cancel()
                        )
                    }
                }
                
                HStack {
                    Text("Set Number")
                    Text("Weight")
                        .offset(x: 10)
                    Text("Repetitions")
                        .offset(x: 25)
                }
                .frame(width: UIScreen.main.bounds.width - 30, alignment: .leading)
                .padding(.bottom, 10)
                .padding(.top, 5)
            }
        }
    }
    
    struct SetView: View {
        @EnvironmentObject var viewModel: WorkoutViewModel
        var currIndex: Int
        
        var body: some View {
            if currIndex < viewModel.workout.exercises.count {
                let currentExercise = viewModel.workout.exercises[currIndex]
                
                VStack {
                    ForEach(currentExercise.sets.indices, id: \.self) { index in
                        HStack {
                            UpdateSet(currentExerciseIndex: currIndex, currentSetIndex: index)
                                .environmentObject(viewModel)
                            EditSetButton(currentExerciseIndex: currIndex, currentSetIndex: index)
                                .environmentObject(viewModel)
                            DeleteSetButton(currentExerciseIndex: currIndex, currentSetIndex: index)
                                .environmentObject(viewModel)
                        }
                        .padding(.vertical, -25)
                    }
                }
                .padding(.vertical, -10)
            }
        }
    }
    
    struct UpdateSet: View {
        @EnvironmentObject var viewModel: WorkoutViewModel
        var currentExerciseIndex: Int
        var currentSetIndex: Int

        var body: some View {
            if currentExerciseIndex < viewModel.workout.exercises.count &&
                currentSetIndex < viewModel.workout.exercises[currentExerciseIndex].sets.count {
                
                let currentSet = viewModel.workout.exercises[currentExerciseIndex].sets[currentSetIndex]
                
                HStack {
                    Text(currentSet.name)
                        .bold()
                        .font(.title3)
                        .frame(width: 60, height: 35)
                        .offset(x: 30)
                    
                    TextField(String(currentSet.reps), text: Binding(
                        get: { String(currentSet.reps) },
                        set: {
                            if !viewModel.workout.exercises.isEmpty{
                                if let repsValue = Int($0) {
                                    viewModel.workout.exercises[currentExerciseIndex].sets[currentSetIndex].reps = repsValue
                                }
                            }
                        }
                    ))
                    .frame(width: 60, height: 35)
                    .offset(x: 57)
                    .multilineTextAlignment(.center)
                    .background(RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.teal, lineWidth: 2)
                        .background(Color.gray.opacity(0.3))
                        .frame(width: 60, height: 35)
                        .offset(x: 57))
                    .keyboardType(.numberPad)
                    
                    TextField(String(currentSet.weight), text: Binding(
                        get: { String(currentSet.weight) },
                        set: {
                            if !viewModel.workout.exercises.isEmpty{
                                if let weightValue = Int($0) {
                                    viewModel.workout.exercises[currentExerciseIndex].sets[currentSetIndex].weight = weightValue
                                }
                            }
                        }
                    ))
                    .padding(.leading, 15)
                    .frame(width: 60, height: 35)
                    .offset(x: 75)
                    .multilineTextAlignment(.center)
                    .background(RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.teal, lineWidth: 2)
                        .background(Color.gray.opacity(0.3))
                        .frame(width: 60, height: 35)
                        .offset(x: 75)
                        .padding(.leading, 15))
                    .keyboardType(.numberPad)
                }
                .frame(width: UIScreen.main.bounds.width - 70, alignment: .leading)
            }
                
        }
    }
    
    struct EditSetButton: View {
        @EnvironmentObject var viewModel: WorkoutViewModel
        @State private var showEditView = false
        var currentExerciseIndex: Int
        var currentSetIndex: Int
        
        var body: some View {
            if currentExerciseIndex < viewModel.workout.exercises.count {
                let currentExercise = viewModel.workout.exercises[currentExerciseIndex]
                
                Button {
                    showEditView = true
                } label: {
                    ZStack {
                        Circle()
                            .frame(width: 25, height: 25)
                            .foregroundColor(Color.gray)
                        
                        Image(systemName: "pencil")
                            .foregroundColor(Color.white)
                            .font(.body)
                    }
                }
                .popover(isPresented: $showEditView) {
                    VStack {
                        Button {
                            viewModel.turnSetToWarmup(currentExerciseIndex: currentExerciseIndex, currentSetIndex: currentSetIndex)
                            showEditView = false
                        } label: {
                            ZStack {
                                Rectangle()
                                    .frame(width: 150, height: 75)
                                    .foregroundColor(currentExercise.sets[currentSetIndex].name == "W" ? Color.teal : Color.gray)
                                
                                Text("Warm Up Set")
                                    .bold()
                                    .font(.system(size: 20))
                                    .foregroundColor(Color.white)
                            }
                        }
                    }
                    .frame(width: 150, height: 50)
                    .background(Color.black)
                    .presentationCompactAdaptation(.popover)
                }
                .frame(height: 100)
            }
        }
    }
    
    struct DeleteSetButton: View {
        @EnvironmentObject var viewModel: WorkoutViewModel
        @State private var showDeleteSetWarning = false
        var currentExerciseIndex: Int
        var currentSetIndex: Int
        
        var body: some View {
            if currentExerciseIndex < viewModel.workout.exercises.count {
                Button {
                    showDeleteSetWarning = true
                } label: {
                    ZStack {
                        Circle()
                            .frame(width: 25, height: 25)
                            .foregroundColor(Color.red)
                        
                        Image(systemName: "minus")
                            .foregroundColor(Color.white)
                            .font(.body)
                    }
                }
                .alert(isPresented: $showDeleteSetWarning) {
                    Alert(
                        title: Text("Delete Set?"),
                        primaryButton: .destructive(Text("Delete"), action: {
                            viewModel.deleteSet(currentExerciseIndex: currentExerciseIndex, currentSetIndex: currentSetIndex)
                        }),
                        secondaryButton: .cancel()
                    )
                }
                .padding(.trailing, 10)
                .frame(height: 100)
            }
        }
    }

    struct NewSetButton: View {
        @EnvironmentObject var viewModel: WorkoutViewModel
        var currentExerciseIndex: Int
        
        var body: some View {
            if currentExerciseIndex < viewModel.workout.exercises.count {
                Button {
                    viewModel.addSet(currentExerciseIndex: currentExerciseIndex)
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: UIScreen.main.bounds.width - 60, height: 35)
                            .foregroundColor(Color.teal)
                        
                        Text(Image(systemName: "plus"))
                            .foregroundColor(Color.white)
                            .font(.body)
                        +
                        Text(" New Set")
                            .foregroundColor(Color.white)
                            .font(.body)
                    }
                }
                .padding(.top, 15)
            }
        }
    }
}


#Preview {
    ExerciseDisplayView()
}
