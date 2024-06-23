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
            errorMessage = "Error: " + error.localizedDescription
        }
        
    }
    
    func deleteAccount(){
        errorMessage = ""
        let user = Auth.auth().currentUser
        user!.delete { error in
            if let error = error {
                self.errorMessage = "Error: " + error.localizedDescription
            } else {
               //TODO: Delete user data when account is deleted
            }
        }
        
    }
}
