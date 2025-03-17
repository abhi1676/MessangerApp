//
//  AuthService.swift
//  MessangerApp
//
//  Created by Apple on 3/11/25.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
class AuthService{
    
    @Published var usersession : Firebase.User?
    
    static let shared = AuthService()
    
    init() {
        self.usersession = Auth.auth().currentUser
       loadCurrentUserData()
        print("Current User UID : ",usersession?.uid ?? UUID())
    }
    
    @MainActor
    func login(withEmail:String,password:String) async throws{
        do{
            let result = try await Auth.auth().signIn(withEmail: withEmail, password: password)
            loadCurrentUserData()
            self.usersession = result.user
            
        }catch{
            print("Failed to login",error.localizedDescription)
        }

    }
    
    @MainActor

    func createUser(withEmail:String,password:String,fullName:String) async throws{
        do{
            let result = try await Auth.auth().createUser(withEmail: withEmail, password: password)
            self.usersession = result.user
            try await self.uploadUserData(email: withEmail, fullname: fullName, id: result.user.uid)
            loadCurrentUserData()
            print("DEBUG:",result.user.uid)
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func signOut(){
        do {
            try Auth.auth().signOut()
            self.usersession = nil
            UserService.shared.currentUser = nil
            
        }catch{
            print("SignOut Problem",error.localizedDescription)
        }
    }
    
    private func uploadUserData(email:String,fullname:String,id:String) async throws{
        let user = User(fullname: fullname, email: email, profileImgUrl: nil)
        guard let encodedUser = try? Firestore.Encoder().encode(user) else {return}
        try await Firestore.firestore().collection("users").document(id).setData(encodedUser)
    }
    
    
    private func loadCurrentUserData(){
        Task{
            try await UserService.shared.fetchCurrentUser()
        }
    }
}
