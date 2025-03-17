//
//  SignUpView.swift
//  MessangerApp
//
//  Created by Apple on 3/10/25.
//

import SwiftUI

struct SignUpView: View {
    @State var password = ""
    @State var email = ""
    @State var fullname = ""
    
    @StateObject private var viewModel = RegisterViewModel()
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack{
            Spacer()
            
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 150,height: 150)
                .padding()
            
            VStack(spacing:12){
                TextField("Enter Your Email", text: $viewModel.email)
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                TextField("Enter Your Fullname", text: $viewModel.fullname)
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                SecureField("Enter Your Password", text: $viewModel.password)
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
            }
            .padding(.horizontal,24)
            
            Button{
                Task{
                    try await viewModel.register()
                }
            } label: {
                Text("Sign up")
                    .fontWeight(.semibold)
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .frame(width: 360,height: 40)
                    .background(Color(.systemBlue))
                    .cornerRadius(10)
            }
            .padding(.vertical)
            
            Spacer()
            Divider()
            
            
            Button{
               dismiss()
            }label: {
                HStack{
                    Text("Already have an account?")
                    Text("Sign in")
                    
                }
                .fontWeight(.semibold)
                    .foregroundColor(.blue)
            }
            .padding(.vertical)
        }
    }
    
}

struct SignupViewProvider_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
