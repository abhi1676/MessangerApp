//
//  LoginView.swift
//  MessangerApp
//
//  Created by Apple on 3/10/25.
//

import SwiftUI

struct LoginView: View {
   @StateObject var viewModel = LoginViewModel()
    @State var tempemail = ""
    @State var tempPass = ""
    var body: some View {
        NavigationStack{
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
                    
                    SecureField("Enter Your Password", text: $viewModel.password)
                        .font(.subheadline)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                   
                }
                .padding(.horizontal,24)
                   
                Button{
                    print("Forgot Password")
                } label: {
                    Text("Forgot Password?")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .padding(.top)
                        .padding(.trailing,20)
                    
                }
                .frame(maxWidth:.infinity,alignment: .trailing)
                
                
                Button{
                    Task{
                        try await viewModel.login()
                    }
                } label: {
                    Text("Login")
                        .fontWeight(.semibold)
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .frame(width: 360,height: 40)
                        .background(Color(.systemBlue))
                        .cornerRadius(10)
                }
                .padding(.vertical)
                
                
                HStack{
                    Rectangle()
                        .frame(width: (UIScreen.main.bounds.width/2) - 40,height: 0.5)
                    Text("OR")
                        .font(.footnote)
                    Rectangle()
                        .frame(width: (UIScreen.main.bounds.width/2) - 40,height: 0.5)
                }
                .foregroundColor(.gray)
                
                HStack{
                    Image("facebook")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24,height: 24)
                    Text("Continue with facebook")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)
                }
                .padding(.top)
                
                Spacer()
                Divider()
                
                NavigationLink{
                   SignUpView()
                        .navigationBarBackButtonHidden()
                }label: {
                    HStack{
                        Text("Don't have account?")
                        Text("Sign up")
                        
                    }
                    .fontWeight(.semibold)
                        .foregroundColor(.blue)
                }
                .padding(.vertical)
                
              
                    
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
