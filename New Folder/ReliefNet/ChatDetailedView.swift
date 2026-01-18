//
//  DoctorChatView.swift
//  ReliefNet
//
//  Created by Ayush Singh on 07/10/25.
//

import SwiftUI

struct ChatDetailedView: View {
    
    var chatTitle : String
    
    @State var searchText : String = ""
    @State private var chatData: [ChatData] = sampleChatData
    
    var body: some View {
        NavigationStack{
            
            VStack{
                
                
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(chatData) { chat in
                            chatCard(mssg: chat.message, isSent: chat.isSent)
                        }
                    }
                    
                }.background(Color (.systemGroupedBackground))
                
                SearchBar(searchText: $searchText, chatData: $chatData)
                    .padding(.horizontal,20)
                
                
            }
            .navigationBarBackButtonHidden(false).toolbar {
                
                ToolbarItem(placement: .principal) {
                    Text(chatTitle).font(.system(size:20))
                }
                if #available(iOS 26.0, *) {
                    ToolbarItem(placement: .subtitle) {
                        Text("Active").font(.callout)
                    }
                } else {
                    ToolbarItem(placement: .automatic) {
                        Text("Active").font(.callout)
                    }
                }
                ToolbarItem(placement: .primaryAction) {
                    Image(systemName: "camera").frame(width:40)
                }
                ToolbarItem(placement: .primaryAction) {
                    Image(systemName: "video").frame(width:40)
                }
  
            }
        }
    }
}

private struct SearchBar : View{
    
    @Binding var searchText : String
    @Binding var chatData: [ChatData]
    
    var body : some View{
        HStack{
            TextField("Message...", text: $searchText).onSubmit {
                let text = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
                guard !text.isEmpty else { return }
                chatData.append(ChatData(message: text, isSent: true))
                searchText = ""
            }
            Group{
                Image(systemName: "mic")
                Image(systemName: "face.smiling")
                Image(systemName: "photo")
            }.foregroundStyle(.gray).fontWeight(.medium)
            
        }.padding(8).frame(maxWidth: .infinity).background(RoundedRectangle(cornerRadius: 12).fill(.white).shadow(color: Color.gray.opacity(0.4), radius: 10, x: 0, y: 5)).padding(0)
    }
}

struct chatCard : View{
    var mssg : String
    var isSent : Bool
    var body : some View{
        if isSent{
            Text(mssg)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(Color(.customDarkGray), in: Capsule()).frame(maxWidth: .infinity,alignment: .trailing).padding(.trailing,10).padding(.leading,40)
        }else{
            Text(mssg)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(Color(.gray).opacity(0.4), in: Capsule()).frame(maxWidth: .infinity,alignment: .leading).padding(.trailing,40).padding(.leading,10)
        }
    }
    
}


#Preview {
    
    ChatDetailedView(chatTitle: "Unknown")
    
}
