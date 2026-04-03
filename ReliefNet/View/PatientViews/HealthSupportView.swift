//
//  HealthSupportView.swift
//  ReliefNet
//
//  Created by Ayush Singh on 30/09/25.
//

import SwiftUI

struct HealthSupportView: View {
    @EnvironmentObject var session: UserSession
    
    @Environment(\.dismiss) var dismiss
//    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack(spacing: 20){
            Button {
                session.selectedTab = .discover
                
            } label: {
                selectionCardView(title: "INDIVIDUAL",bgColor:"lavandor")
            }.tint(.black)
            
            Button {
                session.selectedTab = .discover
            } label: {
                selectionCardView(title: "CHILD",bgColor:"lightYellow")
            }.tint(.black)
            Button {
                session.selectedTab = .discover
            } label: {
                selectionCardView(title: "TEEN",bgColor:"mintGreen")
            }.tint(.black)
            Button {
                session.selectedTab = .discover
            } label: {
                selectionCardView(title: "COUPLE",bgColor:"peach")
            }.tint(.black)
        }.padding(20).toolbar {
  
            
            ToolbarItem(placement: .navigationBarLeading) {
                Text("Mental Health Support")
                    .font(.system(size: 23, weight: .bold, design: .serif))
                    .foregroundColor(.primary)
                    .frame(width:280)
            }
            
        }.padding(.bottom,0).navigationBarTitleDisplayMode(.inline).background(Color(.systemGroupedBackground))
    }
}

struct selectionCardView: View{
    
    var title:String
    var bgColor:String
    
    var body: some View{
        let imageName=title.localizedLowercase
        HStack(){
            Text(title).font(.system(size:35,weight: .thin, design: .serif)).frame(maxWidth: .infinity,alignment: .leading).padding(.leading,10)
            
            Image(imageName)
                .resizable().scaledToFit().frame(width:100)
        }.background(RoundedRectangle(cornerRadius: 20).foregroundColor(Color(bgColor)).shadow(color: Color.gray.opacity(0.4), radius: 10, x: 0, y: 5))
    }
}

//#Preview {
//    HealthSupportView()
//
//}
