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
                        DisclosureGroup("Your Previous Workout", isExpanded: $isExpanded) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Workout 1")
                                Text("Workout 2")
                            }
                            .padding(.vertical, 8)
                        }
                        .padding(.vertical, 4)
                        .padding(.horizontal, 8)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .onTapGesture {
                            withAnimation {
                                isExpanded.toggle()
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    //Calendar which shows days that workouts were logged for that month

                    //Premade workouts and the option to make workouts
                    
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
