//
//  AddExerciseView.swift
//  WorkoutTracker
//
//  Created by Edward Denton on 4/23/24.
//

import SwiftUI

struct AddExerciseView: View {
    @EnvironmentObject var viewModel: WorkoutViewModel
    
    var body: some View {
        VStack{
            Text("Add New Exercise")
                .font(.system(size: 28))
                .bold()
                .offset(y: 10)
                .padding(.vertical, 10)
            
            ScrollView{
                VStack{
                    ForEach(viewModel.exerciseList, id: \.self){ item in
                        if viewModel.muscleGroups.contains(item){
                            HStack{
                                Text(item)
                                    .bold()
                                    .font(.system(size: 24))
                                    
                            }
                            .frame(width: UIScreen.main.bounds.width - 40, alignment: .leading)
                            .padding(.top, 15)
                        } else{
                            HStack{
                                Button(action: {
                                    if viewModel.selectedExercise == item {
                                        viewModel.selectedExercise = ""
                                    } else{
                                        viewModel.selectedExercise = item
                                    }
                                }){
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 5)
                                            .frame(width: UIScreen.main.bounds.width - 40, height: 35)
                                            .foregroundStyle(viewModel.selectedExercise == item ? .teal : .gray)
                                        
                                        
                                        Text(item)
                                            .font(.system(size: 20))
                                            .foregroundStyle(Color.white)
                                    }
                                }
                            }
                            .frame(width: UIScreen.main.bounds.width)
                        }
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 200)
            .scrollIndicators(.hidden)
            .offset(y: -10)
            .safeAreaInset(edge: .bottom) {
                Button {
                    viewModel.addExerciseToWorkout()
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: UIScreen.main.bounds.width - 40, height: 40)
                            .foregroundStyle(viewModel.selectedExercise == "" ? Color.teal.opacity(0.4) : Color.teal.opacity(1.0))
                            
                        Text("Add")
                            .foregroundStyle(Color.white.opacity(1.0))
                            .font(.system(size: 20))
                            .bold()
                    }
                }
                .disabled(viewModel.selectedExercise == "")
            }
        }
    }
}

#Preview {
    AddExerciseView()
}
