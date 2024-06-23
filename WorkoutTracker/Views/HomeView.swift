//
//  HomeView.swift
//  WorkoutTracker
//
//  Created by Edward Denton on 4/7/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    @State var isExpanded = false
    
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    Section{
                        Text(viewModel.getTimeMessage())
                            .font(.largeTitle)
                            .bold()
                        Text("Have a fantastic workout!")
                            .font(.title2)
                    }
                    
                    Section{
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray)
                        
                        Button(action: {}) {
                            NavigationLink(destination: WorkoutView()) {
                                Text("Click to track a new workout!")
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(width: UIScreen.main.bounds.width - 50,
                                           height: 40)
                                    .background(Color.teal)
                                    .bold()
                                    .font(.system(size: 18))
                                    .cornerRadius(50)
                            }
                        }.padding(.vertical, 10)
                        
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray)
                    }
                    
                    
                    //Dropdown item which shows the previous workout
                    VStack{
                        Text("Your Previous Workout: ")
                            .bold()
                            .font(.system(size: 20))
                            .padding(.vertical, 5)
                            .frame(width: UIScreen.main.bounds.width - 30, alignment: .leading)
                        if viewModel.previousWorkout.id != "INITIALIZER" {
                            WorkoutItemView(workout: viewModel.previousWorkout)
                        } else {
                            Text("No saved workout yet")
                                .padding(.vertical, 5)
                                .font(.system(size: 20))
                            
                        }
                        
                        Rectangle()
                            .frame(height: 1)
                            .padding(.vertical, 10)
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal, 20)
                    
                    //Calendar which shows days that workouts were logged for that month

                    //Premade workouts and the option to make workouts
                    
                }
            }
            .onAppear(){
                viewModel.fetchWorkouts()
            }
        }
    }
}

#Preview {
    HomeView()
}
