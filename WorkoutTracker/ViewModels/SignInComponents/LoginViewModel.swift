//
//  LoginViewModel.swift
//  WorkoutTracker
//
//  Created by Edward Denton on 4/2/24.
//

import FirebaseAuth
import Foundation

class LoginViewModel: ObservableObject{
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    
    init(){
        
    }
    
    func login(){
        errorMessage = ""
        guard validate() else {
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil{
                DispatchQueue.main.async{
                    self.errorMessage = "The email address or password entered is incorrect."
                }
                return
            }
        }
    }
    
    // Requires the email and password to have some requirements to make it a valid log in
    private func validate() -> Bool{
        
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else{
            errorMessage = "Please fill in any empty forms."
            return false
        }
        
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Please enter a valid email."
            return false
        }
        
        guard password.count >= 8 else {
            errorMessage = "Your password must contain at least 8 characters."
            return false
        }
        	
        return true
    }
}
