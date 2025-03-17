//
//  ContentViewModel.swift
//  MessangerApp
//
//  Created by Apple on 3/11/25.
//

import Foundation
import Firebase
import Combine

class ContentViewModel:ObservableObject{
    
    @Published var userSession : Firebase.User?
    private var cancellables = Set<AnyCancellable>()
    init() {
        setupSubscribers()
    }
    
    private func setupSubscribers(){
        AuthService.shared.$usersession.sink{ [weak self] userSessionFromAuthService in
            self?.userSession = userSessionFromAuthService
        }.store(in: &cancellables)
    }
}
