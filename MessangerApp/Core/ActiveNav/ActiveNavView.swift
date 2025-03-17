//
//  ActiveNavView.swift
//  MessangerApp
//
//  Created by Apple on 3/10/25.
//

import SwiftUI

struct ActiveNavView: View {
    
    var body: some View {
        ScrollView(.horizontal,showsIndicators: false){
            HStack(spacing: 32){
                
                ForEach(0 ... 10,id: \.self){
                    user in
                    VStack{
                        ZStack(alignment:.bottomTrailing){
                            Image("profile2")
                                .resizable()
                                .frame(width: 64,height: 64)
                                .foregroundColor(Color(.systemGray4))
                                .clipShape(Circle())
                            
                            ZStack{
                                Circle()
                                    .fill(.white)
                                    .frame(width: 18,height: 18)
                                Circle()
                                    .fill(Color(.systemGreen))
                                    .frame(width: 12,height: 12)
                                    
                            }
                            
                        }
                        
                        Text("Abhishek")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding()
        }
        .frame(height: 106)
    }
}

struct ActiveNavView_Previews: PreviewProvider {
    static var previews: some View {
        ActiveNavView()
    }
}
