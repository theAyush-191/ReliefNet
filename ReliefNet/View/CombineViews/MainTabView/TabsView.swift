//
//  TabView.swift
//  ReliefNet
//
//  Created by Ayush Singh on 28/09/25.
//

import SwiftUI

struct MainTabView: View {

    @EnvironmentObject private var session: UserSession
    @StateObject var bookingVM = BookingViewModel()
    @State private var isSidebarOpen = false

    var body: some View {

            ZStack {
                
                TabView(selection: $session.selectedTab) {
                    
                    if session.userType == .patient {
                        NavigationStack{
                            PatientHomeView().customToolbar(title: session.selectedTab.title) {
                                withAnimation { isSidebarOpen.toggle() }
                            }
                                
                        }.tabItem { Label("Home", systemImage: "house") }
                                                        .tag(Tab.home)
                        NavigationStack{
                            DiscoverView().customToolbar(title: session.selectedTab.title) {
                                withAnimation { isSidebarOpen.toggle() }
                            }
                                
                        }.tabItem { Label("Discover", systemImage: "safari") }
                                                        .tag(Tab.discover)
                        NavigationStack{
                            BookingHistoryView().customToolbar(title: session.selectedTab.title) {
                                withAnimation { isSidebarOpen.toggle() }
                            }
                                
                        }.tabItem { Label("Booking", systemImage: "pencil.and.list.clipboard") }
                            .tag(Tab.booking)
                        NavigationStack{
                            ChatListView().customToolbar(title: session.selectedTab.title) {
                                withAnimation { isSidebarOpen.toggle() }
                            }
                                
                        }.tabItem { Label("Chat", systemImage: "message") }
                                                        .tag(Tab.chat)
                        NavigationStack{
                            ProfileView().customToolbar(title: session.selectedTab.title) {
                                withAnimation { isSidebarOpen.toggle() }
                            }
                        }.tabItem { Label("Profile", systemImage: "person") }
                            .tag(Tab.profile)
                                                
                    } else {
                        NavigationStack{
                            DoctorHomeView().customToolbar(title: session.selectedTab.title) {
                                withAnimation { isSidebarOpen.toggle() }
                            }
                        } .tabItem { Label("Home", systemImage: "house") }
                                                        .tag(Tab.home)
                        NavigationStack{
                            ChatListView().customToolbar(title: session.selectedTab.title) {
                                withAnimation { isSidebarOpen.toggle() }
                            }
                        }
                        .tabItem { Label("Chat", systemImage: "message") }
                                .tag(Tab.chat)
                        NavigationStack{
                            ProfileView().customToolbar(title: session.selectedTab.title) {
                                withAnimation { isSidebarOpen.toggle() }
                            }
                               
                        } .tabItem { Label("Profile", systemImage: "person") }
                                                        .tag(Tab.profile)
                    }
                }.environmentObject(bookingVM)
                
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

        }
}


extension View {
    
    func customToolbar(
        title: String,
        onMenuTap: @escaping () -> Void
    ) -> some View {
        
        self
            .navigationBarTitleDisplayMode(.inline)
        
            .toolbar {
                            // Custom Navigation Bar Items
                ToolbarItem(placement: .topBarLeading) {
                                Text(title)
                                    .font(.system(size: 35, weight: .bold, design: .serif))
                                    .foregroundColor(.primary)
                                    .frame(width: 240,height: 100)
//                                    .frame(maxWidth: .infinity, alignment: .leading)
//                                    .lineLimit(1)
                                    
                            }
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button(action:{onMenuTap()})
                                {
                                    Image(systemName: "line.3.horizontal")
                                }
                            }
                        }
    }
}


#Preview {
    MainTabView().environmentObject(UserSession())
}

