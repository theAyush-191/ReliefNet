//
//  TabView.swift
//  ReliefNet
//
//  Created by Ayush Singh on 28/09/25.
//

import SwiftUI

struct MainTabView: View {

    @EnvironmentObject private var session: UserSession
    @State private var isSidebarOpen = false

    var body: some View {
        NavigationStack{
            ZStack {
                
                TabView(selection: $session.selectedTab) {
                    
                    if session.userType != .patient {
                        
                        PatientHomeView()
                            .tabItem { Label("Home", systemImage: "house") }
                            .tag(Tab.home)
                        
                        DiscoverView()
                            .tabItem { Label("Discover", systemImage: "safari") }
                            .tag(Tab.discover)
                        
                        BookingHistoryView()
                            .tabItem { Label("Booking", systemImage: "pencil.and.list.clipboard") }
                            .tag(Tab.booking)
                        
                        ChatListView()
                            .tabItem { Label("Chat", systemImage: "message") }
                            .tag(Tab.chat)
                        
                        ProfileView()
                            .tabItem { Label("Profile", systemImage: "person") }
                            .tag(Tab.profile)
                        
                    } else {
                        
                        DoctorHomeView()
                            .tabItem { Label("Home", systemImage: "house") }
                            .tag(Tab.home)
                        
                        ChatListView()
                            .tabItem { Label("Chat", systemImage: "message") }
                            .tag(Tab.chat)
                        
                        ProfileView()
                            .tabItem { Label("Profile", systemImage: "person") }
                            .tag(Tab.profile)
                    }
                }
                
                // Sidebar
                if isSidebarOpen {
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation { isSidebarOpen = false }
                        }
                    
                    SidebarView(isOpen: $isSidebarOpen)
                        .transition(.move(edge: .trailing))
                }
            }
            .tint(.purple)
            .toolbar {
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Text(session.selectedTab.title)
                        .font(.system(size: 32, weight: .bold, design: .serif))
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        withAnimation { isSidebarOpen.toggle() }
                    } label: {
                        Image(systemName: "line.3.horizontal")
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

//
//#Preview {
//    TabsView(selectedTab: .constant(.home)).environmentObject(UserSession())
//}

