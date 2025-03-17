//
//  MessageService.swift
//  MessangerApp
//
//  Created by Apple on 3/13/25.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct MessageService{
    static let messaegCollection = Firestore.firestore().collection("message")
    
   static func sendMessage(_ messageText:String,toUser user:User){
        guard let currentUid = Auth.auth().currentUser?.uid else {return}
        let chatPartnerId = user.id
        
        let currentUserRef = messaegCollection.document(currentUid).collection(chatPartnerId).document()
        
        let chatPartnerRef = messaegCollection.document(chatPartnerId).collection(currentUid)
        
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
        
    }
    
   static func observerMessage(chartPartner :User,completion:@escaping ([Message])-> Void){
       let chartPartnerId = chartPartner.id
        guard let currentUid = Auth.auth().currentUser?.uid else {return}
        
        let query = messaegCollection.document(currentUid).collection(chartPartnerId).order(by: "timestamp",descending: false)
       
       query.addSnapshotListener { snapshot, _ in
           guard let changes = snapshot?.documentChanges.filter({$0.type == .added}) else {return}
           var messages = changes.compactMap({ try? $0.document.data(as: Message.self)})
           
           for (index,message) in messages.enumerated() where message.fromId != currentUid{
               messages[index].user = chartPartner
               
           }
           completion(messages)
       }
    }
}
