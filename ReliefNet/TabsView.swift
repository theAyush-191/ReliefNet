//
//  TabView.swift
//  ReliefNet
//
//  Created by Ayush Singh on 28/09/25.
//

import SwiftUI

struct TabsView: View {
    enum Tab: Hashable {
        case home, discover, booking, chat, profile
        var title: String {
            switch self {
            case .home: return "ReliefNet"
            case .discover: return "Discover"
            case .booking: return "My Bookings"
            case .chat: return "Chats"
            case .profile: return "Profile"
            }
        }
    }
    
    @State private var isSidebarOpen = false
    @State  var selectedTab: Tab
    
    @EnvironmentObject private var session:UserSession
    @State private var showHelpSheet:Bool = false
    
    init(startingTab: Tab = .home) {
        _selectedTab = State(initialValue: startingTab)
    }
    
    var body: some View {
        NavigationStack{
            
            ZStack{
                TabView(selection: $selectedTab){
                   
                        HomeView().tabItem {
                            Label("Home", systemImage: "house")
                        }
                        .tag(Tab.home)
                    
                    
                        DiscoverView().tabItem {
                            Label("Discover", systemImage: "safari")
                        }
                            .tag(Tab.discover)
                    
                    
                   
                        BookingView().tabItem {
                            Label{
                                Text("Booking")
                            } icon:{
                                Image(systemName: "pencil.and.list.clipboard").symbolVariant(.none)
                            }
                        }
                            .tag(Tab.booking)
                    
                    
                    
                        ChatListView().tabItem {
                            Label{
                                Text("Chat")
                            } icon:{
                                Image(systemName: "message").symbolVariant(.none)
                            }
                        }
                            .tag(Tab.chat)
//
                    
                    
                        ProfileView().tabItem {
                            Label("Profile", systemImage: "person")
                        }
                            .tag(Tab.profile)
                    
                    
                   
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
                
            }.tint(.purple).toolbar {
                // Custom Navigation Bar Items
            
                    ToolbarItem(placement: .navigationBarLeading) {
                        Text(selectedTab.title)
                            .font(.system(size: 35, weight: .bold, design: .serif)).allowsTightening(true)
                            .foregroundColor(.primary)
                            .frame(width:240)
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action:{ withAnimation { isSidebarOpen.toggle()} })
                        {
                            Image(systemName: "line.3.horizontal")
                        }
                    }
        
            }.padding(.bottom,0)
               .navigationBarTitleDisplayMode(.inline).navigationBarBackButtonHidden(true)

        }
            // Add the Sidebar on top of your main content
           
        }
   
    }


#Preview {
    TabsView().environmentObject(UserSession())
}

