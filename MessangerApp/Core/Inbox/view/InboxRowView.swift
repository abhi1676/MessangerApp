//
//  InboxRowView.swift
//  MessangerApp
//
//  Created by Apple on 3/10/25.
//

import SwiftUI

struct InboxRowView: View {
    let message :Message
    var body: some View {
        HStack(alignment: .top
               ,spacing: 12){
            Image("profile1")
                .resizable()
                .frame(width: 64,height: 64)
                .foregroundColor(Color(.systemGray4))
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4){
                Text(message.user?.fullname ?? "")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                Text(message.messageText)
                    .font(.subheadline)
                    .lineLimit(2)
                    .foregroundColor(.gray)
                    .frame(maxWidth: (UIScreen.main.bounds.width - 100),alignment: .leading)
                
            }
            
            HStack{
                Text(message.timeStampString)
               Image(systemName: "chevron.right")
            }.font(.footnote)
                .foregroundColor(Color(.systemGray))
            
        }
         .frame(height: 72)
         
        
    }
}

//struct InboxRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        InboxRowView()
//    }
//}
