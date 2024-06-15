//
//  ContentView.swift
//  WorkoutTracker
//
//  Created by Edward Denton on 4/1/24.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewModel()
    @State private var selectedTab = 1
    
    var body: some View {
        if viewModel.isSignedIn, !viewModel.currentUserID.isEmpty{
            TabView(selection: $selectedTab){
                WorkoutHistoryView()
                    .tabItem {
                        Label("Workout History", systemImage: "clock")
                    }.tag(0)
                
                HomeView()
                    .tabItem{
                        Label("Home", systemImage: "house")
                    }.tag(1)
                
                ProfileView()
                    .tabItem {
                        Label("Profile", systemImage: "person.fill")
                    }.tag(2)
            }
            
        } else {
            WelcomeView()
        }
    }
}

#Preview {
    MainView()
}
