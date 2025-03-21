//
//  ChatMessageCell.swift
//  MessangerApp
//
//  Created by Apple on 3/11/25.
//

import SwiftUI

struct ChatMessageCell: View {
    let message :Message
    private var isFromCurrentUser:Bool{
        return message.isFromCurrentUser
    }
    var body: some View {
        HStack{
            if isFromCurrentUser {
                Spacer()
                Text(message.messageText)
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemBlue))
                    .foregroundColor(.white)
                    .clipShape(ChatBubble(isFromCurrentUser: isFromCurrentUser))
                    .frame(maxWidth: UIScreen.main.bounds.width/1.5,alignment: .trailing)
            }
            else{
                HStack(alignment:.bottom,spacing: 8){
                    Image(User.MockUser.profileImgUrl ?? "")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 32,height: 32)
                        .clipShape(Circle())
                    
                    Text(message.messageText)
                        .font(.subheadline)
                        .padding()
                        .background(Color(.systemGray5))
                        .foregroundColor(Color(.black))
                        .clipShape(ChatBubble(isFromCurrentUser: isFromCurrentUser))
                        .frame(maxWidth: UIScreen.main.bounds.width/1.75,alignment: .leading)

                }
                Spacer()
            }
        }.padding(.horizontal,8)
    }
}

//struct ChatMessageCell_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatMessageCell(message: false)
//    }
//}
