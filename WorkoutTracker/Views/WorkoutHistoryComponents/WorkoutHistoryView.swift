//
//  WorkoutHistoryView.swift
//  WorkoutTracker
//
//  Created by Edward Denton on 4/8/24.
//

import FirebaseAuth
import FirebaseFirestore
import SwiftUI

struct WorkoutHistoryView: View {
    @StateObject var viewModel = WorkoutHistoryViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    if viewModel.workouts.isEmpty {
                        Text("No previous workouts saved")
                            .font(.title)
                            .padding(.top, UIScreen.main.bounds.height / 3.5)
                    } else {
                        ForEach(viewModel.workouts) { workout in
                            WorkoutItemView(workout: workout)
                        }
                    }
                }
            }
            .navigationTitle("Previous Workouts")
            .navigationBarBackButtonHidden()
            .onAppear(){
                viewModel.fetchWorkouts()
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 50)
        .scrollIndicators(.hidden)
        .offset(y: -10)
    }
}

#Preview {
    WorkoutHistoryView()
}
