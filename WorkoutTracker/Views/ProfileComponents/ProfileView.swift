//
//  ProfileView.swift
//  WorkoutTracker
//
//  Created by Edward Denton on 4/8/24.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel: ProfileViewModel = ProfileViewModel()
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    ProfilePreview(viewModel: viewModel)
                    
                    ViewStats()
                    
                    ChangeEmail()
                    
                    ChangePassword()
                    
                    LogOutButton(viewModel: viewModel)
                    
                    DeleteAccountButton(viewModel: viewModel)
                }
            }
        }
        .onAppear{
            viewModel.fetchUser()
        }
    }
    
    struct ProfilePreview: View{
        @ObservedObject var viewModel: ProfileViewModel
        
        var body: some View{
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(Color.teal)
                    .frame(height: 300)
                
                // If the user has been found show this view
                if let user = viewModel.user{
                    HStack{
                        Image(systemName: "person.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                            .padding()
                        
                        VStack{
                            HStack{
                                Text(user.name)
                            }
                            HStack{
                                Text("(")
                                +
                                Text(user.email)
                                +
                                Text(")")
                            }
                            HStack{
                                Text("Date joined: ")
                                +
                                Text(Date(timeIntervalSince1970: user.joined).formatted(date: .abbreviated, time: .omitted))
                            }
                        }
                    }
                } else {
                    // Show this view until the user info has been found
                    Text("Loading Profile...")
                        .font(.system(size: 44))
                        .padding()
                        .bold()
                }
                
                Text(viewModel.errorMessage)
                    .padding(.top, 200)
                    .frame(width: UIScreen.main.bounds.width - 20)
                    .foregroundStyle(Color.black)
            }
            .offset(y: -60)
            .padding(.bottom, -50)
        }
    }
    
    struct LogOutButton: View{
        @ObservedObject var viewModel: ProfileViewModel
        @State private var showLogOutWarning: Bool = false
        
        var body: some View{
            Button {
                showLogOutWarning = true
            } label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(Color.gray.opacity(0.4))
                        .frame(width: UIScreen.main.bounds.width - 10,
                               height: 60)
                        .bold()
                    Text("Log Out")
                        .foregroundStyle(Color.red)
                        .bold()
                }
            }
            .padding(.vertical, 1)
            .alert(isPresented: $showLogOutWarning){
                Alert(title: Text("Log Out"),
                      message: Text("Are you sure you want to log out?"),
                      primaryButton: .destructive(Text("Yes"), action: {
                    viewModel.logOut()
                }),
                      secondaryButton: .cancel(Text("No")))
            }
        }
    }
    
    struct DeleteAccountButton: View{
        @ObservedObject var viewModel: ProfileViewModel
        @State private var showDeleteAccountWarning: Bool = false
        @State var emailAddress: String = ""
        @State var password: String = ""
        
        var body: some View{
            Button {
                showDeleteAccountWarning = true
            } label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(Color.gray.opacity(0.4))
                        .frame(width: UIScreen.main.bounds.width - 10,
                               height: 60)
                        .bold()
                    Text("Delete Account")
                        .foregroundStyle(Color.red)
                        .bold()
                }
            }
            .padding(.vertical, 1)
            .alert(isPresented: $showDeleteAccountWarning){
                Alert(title: Text("Delete Account?"),
                      message: Text("Are you sure you want to delete your account?\n(This action cannot be undone)"),
                      primaryButton: .destructive(Text("Yes"), action: {
                    viewModel.deleteAccount()
                }),
                      secondaryButton: .cancel(Text("No")))
            }
        }
    }
    
    struct ViewStats: View{
        
        var body: some View {
            Button(action: {}) {
                NavigationLink(destination: ProgressionAndStatisticsView()) {
                    Text("View Statistics")
                        .foregroundStyle(Color.teal)
                        .frame(width: UIScreen.main.bounds.width - 10,
                               height: 60)
                        .bold()
                        .background(Color.gray.opacity(0.4))
                        .cornerRadius(10)
                }
            }
        }
    }
    
    struct ChangeEmail: View{
        
        var body: some View{
            Button(action: {}) {
                NavigationLink(destination: ChangeEmailView()) {
                    Text("Change Email")
                        .foregroundStyle(Color.teal)
                        .frame(width: UIScreen.main.bounds.width - 10,
                               height: 60)
                        .bold()
                        .background(Color.gray.opacity(0.4))
                        .cornerRadius(10)
                }
            }
        }
    }
    
    struct ChangePassword: View{
        
        var body: some View {
            Button(action: {}) {
                NavigationLink(destination: ChangePasswordView()) {
                    Text("Change Password")
                        .foregroundStyle(Color.teal)
                        .frame(width: UIScreen.main.bounds.width - 10,
                               height: 60)
                        .bold()
                        .background(Color.gray.opacity(0.4))
                        .cornerRadius(10)
                }
            }
        }
    }
}

#Preview {
    ProfileView()
}
