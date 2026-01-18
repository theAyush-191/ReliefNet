//
//  DoctorSessionsView.swift
//  ReliefNet
//
//  Created by Ayush Singh on 15/10/25.
//

import SwiftUI

struct DoctorAppointmentView: View {
    
    @State private var sessions : [Session] = sampleSessions
    
    var body: some View {
            List {
                ForEach(sessions) { session in
                    VStack(alignment: .leading, spacing: 6) {
                        HStack {
                            Text(session.patientName)
                                .font(.headline)
                            Spacer()
                            Text(session.status)
                                .font(.caption)
                                .foregroundColor(session.status == "Upcoming" ? .blue : .green)
                                .padding(6)
                                .background(session.status == "Upcoming" ? Color.blue.opacity(0.1) : Color.green.opacity(0.1))
                                .cornerRadius(8)
                        }
                        Text("\(session.date) • \(session.time)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text("Type: \(session.type)")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 6)
                }
            }
            .navigationTitle("Session History")
        
    }
}
#Preview {
    DoctorAppointmentView()
}

