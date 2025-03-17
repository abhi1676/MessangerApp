//
//  NewMessageView.swift
//  MessengerApp
//
//  Created by Apple on 3/10/25.
//

import SwiftUI

struct NewMessageView: View {
    @State private var searchText = ""
    @StateObject private var viewModel = NewMessageViewModel()
    @Binding var selectedUser: User?
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            VStack {
                // Search Bar
                TextField("To", text: $searchText)
                    .frame(height: 44)
                    .padding(.leading)
                    .background(Color(.systemGroupedBackground))
                    .cornerRadius(10)
                    .padding(.horizontal)

                // Contacts Header
                Text("Contacts")
                    .foregroundColor(.gray)
                    .font(.footnote)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top, 5)

                // User List
                List(viewModel.users) { contact in
                    HStack {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.gray)

                        Text(contact.fullname)
                            .font(.subheadline)
                            .fontWeight(.semibold)

                        Spacer()
                    }
                    .padding(.vertical, 5)
                    .onTapGesture {
                        print("Tapped on user: \(contact.fullname)")
                        selectedUser = contact
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            dismiss()
                        }
                    }
                }
                .listStyle(.plain)
            }
            .navigationTitle("New Message")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(.black)
                }
            }
        }
        .onAppear {
            print("Users count in ViewModel: \(viewModel.users.count)")
        }
    }
}

// MARK: - Preview
struct NewMessageView_Previews: PreviewProvider {
    static var previews: some View {
        NewMessageView(selectedUser: .constant(User.MockUser))
    }
}
