//
//  LoginViewModel.swift
//  MessangerApp
//
//  Created by Apple on 3/11/25.
//

import Foundation

class LoginViewModel:ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    func login () async throws {
        try await AuthService.shared.login(withEmail: email, password: password)
    }
}
