//
//  NewMessageViewModel.swift
//  MessangerApp
//
//  Created by Apple on 3/13/25.
//

import Foundation
import Firebase
@MainActor
class NewMessageViewModel:ObservableObject{
    @Published var users = [User]()
    
    init(){
        Task{
            try await fetchAllUsers()
        }
    }
    
    func fetchAllUsers() async throws{
        guard let currentUserUid = Auth.auth().currentUser?.uid else {return}
        
        self.users = try await UserService.fetchAllusers()
        
        self.users =  users.filter({
            $0.id != currentUserUid
        })
       
    }
}
