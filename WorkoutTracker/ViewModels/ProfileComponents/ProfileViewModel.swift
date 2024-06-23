//
//  ProgressionAndStatsViewModel.swift
//  WorkoutTracker
//
//  Created by Edward Denton on 4/8/24.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation
import SwiftUI

class ProfileViewModel: ObservableObject{
    @Published var user: User? = nil
    @Published var errorMessage = ""
    //TODO: Find a way to get this error message to pop up on the screen 
    
    init(){
        
    }
    
    func fetchUser(){
        guard let userID = Auth.auth().currentUser?.uid else {
            return
        }
        
        let db = Firestore.firestore()
        db.collection("users").document(userID).getDocument { [weak self] snapshot, error in
            guard let data = snapshot?.data(), error == nil else {
                return
            }
            
            DispatchQueue.main.async{
                self?.user = User(id: data["id"] as? String ?? "",
                                  name: data["name"] as? String ?? "",
                                  email: data["email"] as? String ?? "",
                                  joined: data["joined"] as? TimeInterval ?? 0)
            }
        }
    }
    
    
    func logOut(){
        errorMessage = ""
        do {
            try Auth.auth().signOut()
        } catch{
            print(error)
            errorMessage = error.localizedDescription
        }
        
    }
    
    func deleteAccount(){
        errorMessage = ""
        let user = Auth.auth().currentUser
        let userID = user?.uid
        let db = Firestore.firestore()
    
        user!.delete { error in
            if let error = error {
                print(error as Any)
                self.errorMessage = error.localizedDescription
            } else {
               //TODO: Delete user data when account is deleted
            }
        }
    }
}
