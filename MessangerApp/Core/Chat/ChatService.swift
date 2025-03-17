//
//  ChatService.swift
//  MessangerApp
//
//  Created by Apple on 3/13/25.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct ChatService{
    
    
    
    let chatPartner : User
    func sendMessage(_ messageText:String){
        guard let currentUid = Auth.auth().currentUser?.uid else {return}
        let chatPartnerId = chatPartner.id
        
        let currentUserRef = FireStoreConstant.MessagesCollection.document(currentUid).collection(chatPartnerId).document()
        
        let chatPartnerRef = FireStoreConstant.MessagesCollection.document(chatPartnerId).collection(currentUid)
        
        let recentCurrentUserRef = FireStoreConstant.MessagesCollection.document(currentUid).collection("recent-messages").document(chatPartnerId)
        
        let recentPartnerRef = FireStoreConstant.MessagesCollection.document(chatPartnerId).collection("recent-messages").document(currentUid)
        
        let messageId = currentUserRef.documentID
        
        let message = Message(
            messageId: messageId,
            fromId: currentUid,
            toId: chatPartnerId,
            messageText: messageText,
            timestamp: Timestamp()
            )
            
        
        guard let messageData = try? Firestore.Encoder().encode(message) else {return}
        
        currentUserRef.setData(messageData)
        chatPartnerRef.document(messageId).setData(messageData)
        
        recentCurrentUserRef.setData(messageData)
        recentPartnerRef.setData(messageData)
        
        
    }
    
    func observerMessage(completion:@escaping ([Message])-> Void){
       let chartPartnerId = chatPartner.id
        guard let currentUid = Auth.auth().currentUser?.uid else {return}
        
        let query = FireStoreConstant.MessagesCollection.document(currentUid).collection(chartPartnerId).order(by: "timestamp",descending: false)
       
       query.addSnapshotListener { snapshot, _ in
           guard let changes = snapshot?.documentChanges.filter({$0.type == .added}) else {return}
           var messages = changes.compactMap({ try? $0.document.data(as: Message.self)})
           
           for (index,message) in messages.enumerated() where message.fromId != currentUid{
               messages[index].user = chatPartner
               
           }
           completion(messages)
       }
    }
}
