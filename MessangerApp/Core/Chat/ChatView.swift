//
//  ChatView.swift
//  MessangerApp
//
//  Created by Apple on 3/11/25.
//

import SwiftUI

struct ChatView: View {
    
    
    @StateObject var viewModel : ChatViewModel
    
    init(user:User){
        self.user = user
        self._viewModel = StateObject(wrappedValue: ChatViewModel(user: user))
    }
    
    let user : User
    var body: some View {
        VStack {
            VStack{
                Image(User.MockUser.profileImgUrl ?? "")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100,height: 100)
                    .clipShape(Circle())
                
                VStack(spacing: 4){
                    Text(user.fullname)
                        .font(.title)
                        .fontWeight(.semibold)
                    Text("Messanger")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
             
            }
            ScrollView{
             
                
                ForEach(viewModel.messages){ message in
                    ChatMessageCell(message: message)
                }
            }
            Spacer()
            ZStack(alignment: .trailing){
                TextField("Message...", text: $viewModel.messageText,axis: .vertical)
                    .padding(12)
                    .padding(.trailing,48)
                    .background(Color(.systemGroupedBackground))
                    .clipShape(Capsule())
                    .font(.subheadline)
                
                
                Button{
                    viewModel.sendMessage()
                    viewModel.messageText = ""
                }label: {
                    Text("Send")
                        .fontWeight(.semibold)
                        .padding(.horizontal)
                }
            }.padding()
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(user:User.MockUser)
    }
}
