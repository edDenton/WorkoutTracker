//
//  MainViewModel.swift
//  WorkoutTracker
//
//  Created by Edward Denton on 4/2/24.
//

import FirebaseAuth
import Foundation

class MainViewModel: ObservableObject{
    @Published var currentUserID: String = ""
    private var handler: AuthStateDidChangeListenerHandle?
    
    init(){
        self.handler = Auth.auth().addStateDidChangeListener{ [weak self] _, user in
            DispatchQueue.main.async{
                self?.currentUserID = user?.uid ?? ""
            }
        }
    }
    
    public var isSignedIn: Bool{
        return Auth.auth().currentUser != nil
    }
}
