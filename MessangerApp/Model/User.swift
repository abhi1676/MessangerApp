//
//  User.swift
//  MessangerApp
//
//  Created by Apple on 3/10/25.
//

import Foundation
import FirebaseFirestoreSwift
struct User:Codable,Identifiable,Hashable{
    @DocumentID var uid :String?
    let fullname : String
    let email:String
    let profileImgUrl:String?
    
    var id:String {
        return uid ?? UUID().uuidString
    }
    
    
}


extension User{
  static let MockUser = User(fullname: "Abhishek Kadam", email: "abhikadam1676@gmail.com", profileImgUrl: "logo")
}
