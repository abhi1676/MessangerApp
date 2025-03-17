//
//  Constants.swift
//  MessangerApp
//
//  Created by Apple on 3/13/25.
//

import Foundation
import Firebase
struct FireStoreConstant {
   static let UserCollection  = Firestore.firestore().collection("users")
    static let MessagesCollection = Firestore.firestore().collection("messages")
    
}
