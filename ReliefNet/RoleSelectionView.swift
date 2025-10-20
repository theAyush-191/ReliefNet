//
//  UserSelectionView.swift
//  ReliefNet
//
//  Created by Ayush Singh on 18/10/25.
//

import SwiftUI

struct RoleSelectionView: View {
    @EnvironmentObject var session: UserSession
    @Environment(\.dismiss) var dismiss
    
//    @State private var navigateToTabs = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            
            Text("How would you like to log in?")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .padding(.top, 40)
                .padding(.horizontal).lineLimit(3)
            
            // --- Doctor Card ---
            RoleCardView(
                iconName: "cross.case.fill",
                iconColor: .blue,
                title: "Login as a Doctor",
                subtitle: "Access your patient schedules and records",
                cardColor: Color.blue.opacity(0.1)
            )
            .onTapGesture {
                session.setUserType("Doctor")
                session.setRoleSelected(true)
                session.setLoginStatus(true)
//                navigateToTabs = true
            }
            
            // --- Patient Card ---
            RoleCardView(
                iconName: "person.fill.badge.plus",
                iconColor: .purple,
                title: "Login as a Patient",
                subtitle: "Book an appointment and view health history",
                cardColor: Color.purple.opacity(0.1)
            )
            .onTapGesture {
                session.setUserType("Patient")
                session.setRoleSelected(true)
                session.setLoginStatus(true)
//                navigateToTabs = true
            }
            
            Spacer()
        }
//        .fullScreenCover(isPresented: $navigateToTabs) {
//            TabsView(startingTab: .home)
//                .environmentObject(session) // important to pass environment object
//        }
        .navigationBarBackButtonHidden(true)
//        .navigationBarTitleDisplayMode(.inline)
//        .toolbar{
//            ToolbarItem(placement: .topBarLeading) {
//                Button(action: {
//                    dismiss()
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//                        dismiss()
//                    }
//                }) {
//                    Image(systemName: "chevron.left")
//                }
//            }
//        }
        .padding(.horizontal)
    }
}

// --- Reusable Card Component ---

struct RoleCardView: View {
    let iconName: String
    let iconColor: Color
    let title: String
    let subtitle: String
    let cardColor: Color
    
    var body: some View {
        VStack(alignment:.leading, spacing: 20) {
            
            // Icon
            ZStack {
                Circle()
                    .fill(iconColor.opacity(0.2)) // Slightly darker circle background
                    .frame(width: 110, height: 110)
                
                Image(systemName: iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .foregroundColor(iconColor)
            }
            
            // Text Content
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.title)
                    .fontWeight(.bold)
                
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(3)
            }
            .padding(.trailing, 10) // Small padding on the right for text
            
            Spacer()
        }
        .padding(20)
        .frame(maxWidth: .infinity)
        .background(cardColor) // Use the light card color for the background
        .cornerRadius(15) // Rounded corners for the card
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 5) // Subtle shadow
        .padding(.horizontal)
    }
}



#Preview {
    RoleSelectionView().environmentObject(UserSession())
}
