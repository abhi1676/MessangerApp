import SwiftUI

struct InboxView: View {
    @State private var showMessageView = false
    @StateObject var viewModel = InboxViewModel()
    @State private var selectedUser : User?
    @State private var showChat = false
    
    private var user:User? {
        return viewModel.currentUser
    }
    var body: some View {
        NavigationStack {
            VStack {
                ActiveNavView()
                
                List {
                    ForEach(viewModel.recentMessages) { message in
                        ZStack{
                            NavigationLink(value: message){
                                EmptyView()
                            }.opacity(0.0)
                            InboxRowView(message: message)
                        }
                    }
                }
                .listStyle(.plain)
            }
            .navigationDestination(for: Message.self, destination: {
                message in
                if let user = message.user{
                    ChatView(user: user)
                }
            })
            .navigationDestination(for: User.self, destination: {
                user in
                ProfileView(user:user)
            })
            .navigationDestination(isPresented: $showChat, destination: {
                if let user = selectedUser {
                    ChatView(user:user)
                }
                
            })
         
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        NavigationLink(value:user){
                            Image(user?.profileImgUrl ?? "logo")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 32,height: 32)
                                .clipShape(Circle())
                        }
                        Text("Chats")
                            .font(.title)
                            .fontWeight(.semibold)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showMessageView.toggle()
                        selectedUser = nil
                    } label: {
                        Image(systemName: "square.and.pencil.circle.fill")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .foregroundStyle(.black, Color(.systemGray5))
                    }
                }
            }
        }
        .onChange(of: selectedUser, perform: {
            newValue in
            showChat = newValue != nil
        })
        .fullScreenCover(isPresented: $showMessageView, content: {
            NewMessageView(selectedUser: $selectedUser)
        })
       
    }
}

struct InboxView_Previews: PreviewProvider {
    static var previews: some View {
        InboxView()
    }
}
