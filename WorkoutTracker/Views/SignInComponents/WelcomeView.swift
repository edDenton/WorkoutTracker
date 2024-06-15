//
//  WelcomeView.swift
//  WorkoutTracker
//
//  Created by Edward Denton on 4/3/24.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationView{
            VStack{
                ZStack {
                    Image("welcome_image")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .edgesIgnoringSafeArea(.all)
                        .padding(.trailing, 150)
                    
                    LoginRegisterButtons()
                    
                }
            }
        }
    }
    
    
    struct LoginRegisterButtons: View{
        var body: some View{
            VStack {
                Spacer()
                
                Button(action: {}) {
                    NavigationLink(destination: LoginView()) {
                        Text("Login")
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: UIScreen.main.bounds.width - 20)
                            .background(Color.teal)
                            .bold()
                            .font(.system(size: 24))
                            .cornerRadius(50)
                    }
                }
            
                
                Text("OR")
                    .font(.title)
                    .bold()
                    .padding(.vertical, 5)
                    .foregroundColor(Color.white)
                
                    
                
                Button(action: {}) {
                    NavigationLink(destination: RegisterView()) {
                        Text("Register")
                            .foregroundColor(.teal)
                            .padding()
                            .frame(width: UIScreen.main.bounds.width - 20)
                            .background(Color.white)
                            .bold()
                            .font(.system(size: 24))
                            .cornerRadius(50)
                            
                    }
                }
            }
            .padding(.horizontal, 15)
            .padding(.bottom, 5)
        }
    }
}

#Preview {
    WelcomeView()
}
