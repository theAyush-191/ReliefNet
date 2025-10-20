//
//  ChatListView.swift
//  ReliefNet
//
//  Created by Ayush Singh on 17/10/25.
//

import SwiftUI

struct ChatListView: View {
    @EnvironmentObject var session: UserSession
    
    var body: some View {
        VStack {
            
            SearchBarView().padding(.horizontal,20).padding(.top,10)
            
            if session.userType == "Doctor" {
                DoctorChat()
            } else {
                PatientChat()
            }
        }
        .navigationTitle("Chats")
        .navigationBarTitleDisplayMode(.inline)
    }
}

 private struct DoctorChat: View {
    var body: some View {
        List {
            Section(header: Text("Patient Chats")) {
                ForEach(0..<5) { index in
                    NavigationLink(destination: ChatDetailedView(chatTitle: "Patient \(index + 1)")) {
                        HStack {
                            Image(systemName: "person.fill")
                                .foregroundColor(.blue)
                            Text("Patient \(index + 1)")
                        }
                    }
                }
            }
        }
    }
}

private struct PatientChat: View {
    var body: some View {
        List {
            Section(header: Text("Doctor Chats")) {
                ForEach(0..<5) { index in
                    NavigationLink(destination: ChatDetailedView(chatTitle: "Doctor \(index + 1)")) {
                        HStack {
                            Image(systemName: "stethoscope")
                                .foregroundColor(.green)
                            Text("Doctor \(index + 1)")
                        }
                    }
                }
            }
        }
    }
}


#Preview {
    ChatListView().environmentObject(UserSession())
}
