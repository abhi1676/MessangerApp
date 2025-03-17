//
//  UserService.swift
//  MessangerApp
//
//  Created by Apple on 3/12/25.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class UserService:ObservableObject{
    @Published var currentUser : User?
    
    static let shared = UserService()
    
    @MainActor
    func fetchCurrentUser() async throws{
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
        let user = try snapshot.data(as:User.self)
        self.currentUser = user
    }
    
    
    @MainActor
    static func fetchAllusers() async throws -> [User]{
        let snapshot = try await Firestore.firestore().collection("users").getDocuments()
        
        let users = snapshot.documents.compactMap({
            try? $0.data(as: User.self)
        })
        return users
    }
    
    static func fetchUser(withUid uid:String,completion: @escaping(User)-> Void){
        FireStoreConstant.UserCollection.document(uid).getDocument { snapshot, _ in
            guard let user = try? snapshot?.data(as: User.self) else {return}
            completion(user)
        }
    }
}
