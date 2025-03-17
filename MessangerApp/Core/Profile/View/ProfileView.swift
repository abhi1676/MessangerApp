//
//  ProfileView.swift
//  MessangerApp
//
//  Created by Apple on 3/10/25.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    @StateObject var viewmodel = ProfileViewModel()
    let user : User
    var body: some View {
        VStack{
            VStack{
                PhotosPicker(selection: $viewmodel.selectedItem) {
                    if let profileImage = viewmodel.profileImage{
                        profileImage
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80,height: 80)
                            .clipShape(Circle())
                    }else{
                        Image(user.profileImgUrl ?? "profile")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80,height: 80)
                            .clipShape(Circle())
                    }
                }
                Text(user.fullname)
                    .font(.title)
                    .fontWeight(.semibold)
                
            }
            List
            {
                Section{
                    ForEach(SettingsOptionsViewModel.allCases,id: \.self){
                        option in
                        HStack{
                            Image(systemName: option.imageName)
                                .resizable()
                                .frame(width: 24,height: 24)
                                .foregroundColor(option.imageBackgroundColor)
                            Text(option.title)
                                .font(.subheadline)
                        }
                        
                    }
                }
                
                Section{
                    Button("Log Out"){
                        AuthService.shared.signOut()
                    }
                    Button("Delete Account"){
                       
                    }
                }
                .foregroundColor(.red)
            }
            
        }
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user:User.MockUser)
    }
}
