//
//  LoginView.swift
//  WorkoutTracker
//
//  Created by Edward Denton on 4/2/24.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    
    var body: some View {
        VStack{
            //Header Text
            VStack{
                Text("Welcome Back!")
                
                Text("Please log in to continue.")
            }.padding(.vertical, 100)
            
            if !viewModel.errorMessage.isEmpty {
                Text(viewModel.errorMessage)
                    .padding(.vertical, 15)
                    .foregroundStyle(Color.red)
                    .multilineTextAlignment(.center)
                    .frame(width: UIScreen.main.bounds.width - 20)
            } else {
                Text(" ")
                    .padding(.vertical, 15)
                    .foregroundStyle(Color.red)
            }
            
            //Email Address
            Section{
                ZStack{
                    TextField("Enter your email address", text: $viewModel.email)
                        .frame(width: UIScreen.main.bounds.width - 50, height: 20)
                        .autocorrectionDisabled()
                        .autocapitalization(.none)
                        .background(RoundedRectangle(cornerRadius: 0)
                                    .stroke(Color.teal, lineWidth: 2)
                                    .background(Color.gray.opacity(0.6))
                                    .frame(width: UIScreen.main.bounds.width - 40,
                                           height: 35))
                }
            }
            .padding(.bottom, 20)
            
            //Password
            Section{
                ZStack{
                    SecureField("Enter your password", text: $viewModel.password)
                        .frame(width: UIScreen.main.bounds.width - 50, height: 20)
                        .autocorrectionDisabled()
                        .autocapitalization(.none)
                        .background(RoundedRectangle(cornerRadius: 0)
                                    .stroke(Color.teal, lineWidth: 2)
                                    .background(Color.gray.opacity(0.6))
                                    .frame(width: UIScreen.main.bounds.width - 40,
                                           height: 35))
                }
            }.padding(.bottom, 20)
            
            
            //TODO: Forgot Password
//            NavigationLink("Forgot Password?", destination: WelcomeView())
//            Text("Forget Password (CHANGE LATER)")
                
            
            //Sign in Button
            Button {
                viewModel.login()
            } label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 50)
                        .foregroundStyle(Color.teal)
                        .frame(width: UIScreen.main.bounds.width - 50,
                               height: 40)
                        .bold()
                        .font(.system(size: 24))
                    Text("Log In")
                        .foregroundStyle(Color.white)
                }
            }
            .padding(.bottom, 20)
            
            Spacer()
            
            //Register Now
            HStack{
                Text("Don't have an account?")
                
                NavigationLink("Register Now", destination: RegisterView())
            }
        }
    }
}

#Preview {
    LoginView()
}
