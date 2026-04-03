import SwiftUI




struct RelieBotView: View {
    
    @State var talked : Bool = false
    @State var searchText : String = ""
    @State var relieChatData : [ChatData] = healthChatData
    
    @State var isSidebarOpen: Bool = false
    @State var showHelpSheet:Bool = false
    
    @EnvironmentObject private var session:UserSession
    

    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
//        NavigationStack{
      
        ZStack{
       
            
            Image("appBG").resizable().ignoresSafeArea()
            
            if talked{
                VStack{
                    ScrollView{
                        ForEach(relieChatData){chat in
                            chatBox(mssg: chat.message, isSent: chat.isSent)
                        }
                    }
                    SearchBar(talked: $talked, searchText: $searchText, chatData: $relieChatData)
                }.padding(.horizontal,20)
            }else{
                VStack{
                    Group{
                        Text("Hello There!!").font(.system(size: 48))
                        Text("How can I help you Today?").font(.system(size: 23))
                    }.fontDesign(.serif).foregroundStyle(.white)
                    
                    SearchBar(talked: $talked, searchText: $searchText, chatData: $relieChatData)
                    
                }.padding(.horizontal,20)
            }
            
            if isSidebarOpen {
                // Dimmed background
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation { isSidebarOpen = false }
                    }
                    .zIndex(0) // Background

                // The Sidebar View
                SidebarView(
                    isOpen: $isSidebarOpen
                )
                .transition(.move(edge: .trailing))
                .zIndex(1)
            }
            
        }
        // --- 4. ADD THE .sheet MODIFIER ---
        .sheet(isPresented: $showHelpSheet) {
            HelpSupportView()
        }
        .navigationBarBackButtonHidden(false).toolbar {
            
            ToolbarItem(placement: .topBarLeading) {
                Text("RelieBot").font(.system(size:35,weight: .semibold, design: .serif)).frame(width:160)
            }
            
            ToolbarItem(placement: .primaryAction) {
                Button(action:{ withAnimation { isSidebarOpen.toggle()} })
                {
                    Image(systemName: "line.3.horizontal")
                }
            }
        }
//      } // Closes NavigationStack
    }
}

//MARK: - SearchBar View

private struct SearchBar : View{
    
    @Binding var talked : Bool
    @Binding var searchText : String
    @Binding var chatData : [ChatData]
    
    var body : some View{
        HStack{
            TextField("Message...", text: $searchText).onSubmit {
                talked = true
                let text = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
                guard !text.isEmpty else { return }
                chatData.append(ChatData(message: text, isSent: true))
                searchText = ""
                // Add logic to get bot response here
            }
            Group{
                Image(systemName: "mic")
                Image(systemName: "face.smiling")
                Image(systemName: "photo")
            }.foregroundStyle(.gray).fontWeight(.medium)
            
        }.padding(8).frame(maxWidth: .infinity).background(RoundedRectangle(cornerRadius: 12).fill(.white).shadow(color: Color.gray.opacity(0.4), radius: 10, x: 0, y: 5)).padding(0)
    }
}

//MARK: - ChatBox View
struct chatBox : View{
    var mssg : String
    var isSent : Bool
    var body : some View{
        if isSent{
            Text(mssg).foregroundStyle(.white)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(Color(.black), in: Capsule()).frame(maxWidth: .infinity,alignment: .trailing).padding(.trailing,10).padding(.leading,40)
        }else{
            Text(mssg)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(Color(.white), in: Capsule()).frame(maxWidth: .infinity,alignment: .leading).padding(.trailing,40).padding(.leading,10)
        }
    }
    
}



//#Preview {
//    RelieBotView()
//        .environmentObject(UserSession()) // Add mock session
//}
