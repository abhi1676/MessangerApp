//
//  ChatViewModel.swift
//  MessangerApp
//
//  Created by Apple on 3/13/25.
//

import Foundation

class ChatViewModel:ObservableObject{
    @Published var messageText = ""
    @Published var messages = [Message]()
    
    
    let service : ChatService
    
    init(user:User){
        self.service = ChatService(chatPartner: user)
        observeMessages()
    }
    
    func observeMessages(){
        service.observerMessage() {
            messages in
            self.messages.append(contentsOf: messages)
        }
    }
    
    func sendMessage(){
        service.sendMessage(messageText)
    }
    
}
