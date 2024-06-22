//
//  WorkoutView.swift
//  WorkoutTracker
//
//  Created by Edward Denton on 4/10/24.
//

import SwiftUI
import FirebaseFirestoreSwift

struct WorkoutView: View {
    @StateObject var viewModel = WorkoutViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray)
                    
                    if viewModel.workout.exercises.count == 0 {
                        Text("No exercises added")
                            .padding(.vertical, 20)
                        
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray)
                        
                    } else {
                        Text("")
                        ExerciseDisplayView()
                            .environmentObject(viewModel)
                    }
                    
                    AddExerciseButton()
                        .environmentObject(viewModel)
                    
                    DeleteWorkoutButton(presentationMode: presentationMode)
                        .environmentObject(viewModel)
                }
            }
            .toolbar(content: {
                SaveButton(presentationMode: presentationMode)
                    .environmentObject(viewModel)
            })
            .padding(.top, 15)
        }
        .navigationBarBackButtonHidden()
        .environmentObject(viewModel)
    }
    
    struct SaveButton: View{
        @EnvironmentObject var viewModel: WorkoutViewModel
        @State private var showSaveView: Bool = false
        let presentationMode: Binding<PresentationMode>
        
        var body: some View{
            HStack{
                Button {
                    showSaveView = true
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: 75, height: 30)
                            .foregroundStyle(Color.teal)
                        
                        
                        Text("Save")
                            .foregroundStyle(Color.white)
                            .font(.body)
                    }
                }.alert(isPresented: $showSaveView){
                    Alert(title: Text("Save Workout?"),
                          message: Text("This action cannot be undone."),
                          primaryButton: .default(Text("Save"), action: {
                        viewModel.save()
                        presentationMode.wrappedValue.dismiss()
                    }),
                          secondaryButton: .cancel())
                }
            }.padding(.bottom, -5)
        }
    }
    
    struct AddExerciseButton: View{
        @EnvironmentObject var viewModel: WorkoutViewModel
        
        var body: some View{
            // New Exercise Button
            //OnClick: Will show a list of all the exercises and you click one and it adds it to the workout
            
            Button {
                viewModel.showAddExerciseView = true
            } label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: UIScreen.main.bounds.width - 40, height: 35)
                        .foregroundStyle(Color.gray)
                    
                    
                    Text(Image(systemName: "plus"))
                        .foregroundStyle(Color.white)
                        .font(.body)
                    +
                    Text(" New Exercise")
                        .foregroundStyle(Color.white)
                        .font(.body)
                }
            }.sheet(isPresented: $viewModel.showAddExerciseView, content: {
                AddExerciseView()
                    .environmentObject(viewModel)
            })
        }
    }
    
    struct DeleteWorkoutButton: View{
        @State private var showWorkoutDeletionAlert = false
        @EnvironmentObject var viewModel: WorkoutViewModel
        let presentationMode: Binding<PresentationMode>
        
        var body: some View{
            // Delete Workout Button
            //OnClick: Shows a pop-up warning whether or not you want to delete the workout
            
            Button {
                showWorkoutDeletionAlert = true
            } label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: UIScreen.main.bounds.width - 40, height: 35)
                        .foregroundStyle(Color.red)
                    
                    Text(Image(systemName: "trash.fill"))
                        .foregroundStyle(Color.white)
                        .font(.body)
                    +
                    Text(" Delete Workout")
                        .foregroundStyle(Color.white)
                        .font(.body)
                }.padding(.bottom, 10)
                
            }.alert(isPresented: $showWorkoutDeletionAlert){
                Alert(title: Text("Delete Workout?"),
                      primaryButton: .destructive(Text("Delete"), action: {
                    viewModel.deleteWorkout()
                    presentationMode.wrappedValue.dismiss()
                }),
                      secondaryButton: .cancel())
            }
        }
    }
}

#Preview {
    WorkoutView()
}
