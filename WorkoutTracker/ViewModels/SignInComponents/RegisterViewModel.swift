//
//  RegisterViewModel.swift
//  WorkoutTracker
//
//  Created by Edward Denton on 4/2/24.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

class RegisterViewModel: ObservableObject{
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var errorMessage = ""
    
    init(){
        
    }
    
    func register(){
        errorMessage = ""
        guard validate() else {
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            
            if let error = error{
                DispatchQueue.main.async {
                    self?.errorMessage = error.localizedDescription
                }
                return
            }
            
            guard let userID = result?.user.uid else {
                return
            }
            
            self?.insertUserRecord(id: userID)
        }
    }
    
    // Adds the user data to Firebase
    private func insertUserRecord(id: String){
        let newUser = User(id: id,
                           name: name,
                           email: email,
                           joined: Date().timeIntervalSince1970)
        
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(id)
            .setData(newUser.asDictionary())
    }
    
    // Requires that the email, password, and name to pass some specifications to have it be a valid log in
    private func validate() -> Bool{
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty,
              !confirmPassword.trimmingCharacters(in: .whitespaces).isEmpty else{
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
        
        guard password == confirmPassword else {
            errorMessage = "The password and the confirmation password do not match."
            return false
        }
        
        return true
    }
}
