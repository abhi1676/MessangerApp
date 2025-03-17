//
//  RegisterViewModel.swift
//  MessangerApp
//
//  Created by Apple on 3/11/25.
//

import Foundation
class RegisterViewModel:ObservableObject{
    @Published var email = ""
    @Published var password = ""
    @Published var fullname = ""
    
    func register() async throws {
        try await AuthService.shared.createUser(withEmail: email, password: password, fullName: fullname)
    }
}
