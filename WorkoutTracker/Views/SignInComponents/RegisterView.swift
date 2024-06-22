//
//  RegisterView.swift
//  WorkoutTracker
//
//  Created by Edward Denton on 4/2/24.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var viewModel = RegisterViewModel()
    
    
    var body: some View {
        
        VStack{
            
            //Some sort of welcome text
            VStack{
                Text("Hello!")
                Text("Register to get started.")
            }.padding(.vertical, 75)
            
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
            
            //First and Last Name Box
            Section{
                ZStack{
                    TextField("Enter your first and last name", text: $viewModel.name)
                        .frame(width: UIScreen.main.bounds.width - 50, height: 20)
                        .autocorrectionDisabled()
                        .background(RoundedRectangle(cornerRadius: 0)
                                    .stroke(Color.teal, lineWidth: 2)
                                    .background(Color.gray.opacity(0.3))
                                    .frame(width: UIScreen.main.bounds.width - 40,
                                           height: 35))
                }
            }
            .padding(.bottom, 20)
            
            //Email Box
            Section{
                ZStack{
                    TextField("Enter your email address", text: $viewModel.email)
                        .frame(width: UIScreen.main.bounds.width - 50, height: 20)
                        .autocorrectionDisabled()
                        .autocapitalization(.none)
                        .background(RoundedRectangle(cornerRadius: 0)
                                    .stroke(Color.teal, lineWidth: 2)
                                    .background(Color.gray.opacity(0.3))
                                    .frame(width: UIScreen.main.bounds.width - 40,
                                           height: 35))
                }
            }
            .padding(.bottom, 20)
            
            //Password Box
            Section{
                ZStack{
                    SecureField("Enter your password", text: $viewModel.password)
                        .frame(width: UIScreen.main.bounds.width - 50, height: 20)
                        .autocorrectionDisabled()
                        .autocapitalization(.none)
                        .background(RoundedRectangle(cornerRadius: 0)
                                    .stroke(Color.teal, lineWidth: 2)
                                    .background(Color.gray.opacity(0.3))
                                    .frame(width: UIScreen.main.bounds.width - 40,
                                           height: 35))
                }
            }
            .padding(.bottom, 20)
            
            //Confirm Password Box
            Section{
                ZStack{
                    SecureField("Enter your password", text: $viewModel.confirmPassword)
                        .frame(width: UIScreen.main.bounds.width - 50, height: 20)
                        .autocorrectionDisabled()
                        .autocapitalization(.none)
                        .background(RoundedRectangle(cornerRadius: 0)
                                    .stroke(Color.teal, lineWidth: 2)
                                    .background(Color.gray.opacity(0.3))
                                    .frame(width: UIScreen.main.bounds.width - 40,
                                           height: 35))
                }
            }
            .padding(.bottom, 20)
            
            //Register Button
            Button {
                viewModel.register()
            } label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 50)
                        .foregroundStyle(Color.gray)
                        .frame(width: UIScreen.main.bounds.width - 50,
                               height: 40)
                        .bold()
                        .font(.system(size: 24))
                    Text("Register")
                        .foregroundStyle(Color.white)
                }
            }
            .padding(.bottom, 20)
            
            
            Spacer()
            
            
            HStack{
                Text("Already have an account?")
                
                NavigationLink("Log in", destination: LoginView())
            }
        }
    }
}

#Preview {
    RegisterView()
}
