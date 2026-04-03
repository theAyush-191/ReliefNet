//
//  NewAppointmentRequestView.swift
//  ReliefNet
//
//  Created by Ayush Singh on 21/03/26.
//
import SwiftUI

struct NewAppointmentsView: View {
    
    @Binding var sessions: [DoctorSession]
    
//    var requestSessions: [DoctorSession] {
//        $sessions.filter { $0.wrappedValue.status == .requested } as! [DoctorSession]
//    }
    
    var body: some View {
        
        ScrollView {
            VStack(spacing: 12) {
                
                if $sessions.filter({ $0.wrappedValue.status == .requested }).isEmpty {
                    Text("No new appointment requests")
                        .foregroundColor(.gray)
                        .padding(.top, 40)
                }
                
                ForEach($sessions.filter { $0.wrappedValue.status == .requested }) { $session in
                    NavigationLink(destination: AppointmentDetailView(session: $session)){
                        RequestCard(session: $session)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("New Appointments")
    }
}

struct RequestCard: View {
    
    @Binding var session: DoctorSession
    
    @State private var showReschedule = false
    @State private var showCancelAlert = false
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 12) {
            
            // 🔷 Top Row
            HStack {
                
                Circle()
                    .fill(Color.purple.opacity(0.2))
                    .frame(width: 45, height: 45)
                    .overlay(
                        Text(String(session.patientName.prefix(1)))
                            .font(.headline)
                            .foregroundColor(.purple)
                    )
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(session.patientName)
                        .font(.headline)
                    
                    Text("\(session.patientGender) • \(session.patientAge) yrs")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Text("Requested")
                    .font(.caption2)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .foregroundColor(Color.orange)
                    .background(Color.orange.opacity(0.1))
                    .clipShape(Capsule())
            }
            
            // 🔷 Requested Time
            HStack {
                Image(systemName: "clock")
                Text(session.requestedDateTime.formatted(date: .abbreviated, time: .shortened))
            }
            .font(.caption)
            .foregroundColor(.gray)
            
            // 🔷 Type
            Text(session.appointmentType.rawValue)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            // 🔷 Symptoms
            Text(session.symptoms)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(2)
            
            
            // 🔷 Actions
            HStack(spacing: 10) {
                
                // Accept
                Button("Accept") {
                    print("Accepted")
                    session.confirmedDateTime = session.proposedDateTime ?? session.requestedDateTime
                    session.status = .upcoming
                    
                }
                .frame(maxWidth: .infinity)
                .padding(8)
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(8)
                
                
                // Reschedule
                Button("Reschedule") {
                    showReschedule = true
                }
                .frame(maxWidth: .infinity)
                .padding(8)
                .background(Color.purple.opacity(0.1))
                .foregroundColor(.purple)
                .cornerRadius(8)
                
                
                // Cancel
                Button("Cancel") {
                    
                    showCancelAlert = true
                }
                .frame(maxWidth: .infinity)
                .padding(8)
                .background(Color.red.opacity(0.1))
                .foregroundColor(.red)
                .cornerRadius(8)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(14)
        .shadow(color: .black.opacity(0.05), radius: 8, y: 4)
        
        // 🔴 Cancel Alert
        .alert("Cancel Appointment?", isPresented: $showCancelAlert) {
            Button("Yes", role: .destructive) {
                session.status = .cancelled
            }
            Button("No", role: .cancel) {}
        }
        
        // 🟣 Reschedule Sheet
        .sheet(isPresented: $showReschedule) {
//            RescheduleView(session:$session)
        }
    }
}

//
//#Preview {
//    
//    let sampleRequests: [DoctorSession] = [
//        
//        DoctorSession(
//            doctorId: "D1",
//            doctorName: "Dr. You",
//            patientId: "P1",
//            patientName: "Rahul Verma",
//            patientAge: 28,
//            patientGender: "Male",
//            appointmentType: .clinic,
//            requestedDateTime: Date(),
//            confirmedDateTime: nil,
//            proposedDateTime: nil,
//            symptoms: "Chest pain and breathing issue",
//            diagnosis: nil,
//            prescription: nil,
//            doctorNotes: nil,
//            followUpDate: nil,
//            status: .requested
//        ),
//        
//        DoctorSession(
//            doctorId: "D1",
//            doctorName: "Dr. You",
//            patientId: "P2",
//            patientName: "Ananya Singh",
//            patientAge: 24,
//            patientGender: "Female",
//            appointmentType: .online,
//            requestedDateTime: Calendar.current.date(byAdding: .hour, value: 3, to: Date())!,
//            confirmedDateTime: nil,
//            proposedDateTime: nil,
//            symptoms: "Anxiety, stress, sleep issues",
//            diagnosis: nil,
//            prescription: nil,
//            doctorNotes: nil,
//            followUpDate: nil,
//            status: .requested
//        ),
//        
//        DoctorSession(
//            doctorId: "D1",
//            doctorName: "Dr. You",
//            patientId: "P3",
//            patientName: "Amit Sharma",
//            patientAge: 35,
//            patientGender: "Male",
//            appointmentType: .home,
//            requestedDateTime: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
//            confirmedDateTime: nil,
//            proposedDateTime: nil,
//            symptoms: "Fever and body pain",
//            diagnosis: nil,
//            prescription: nil,
//            doctorNotes: nil,
//            followUpDate: nil,
//            status: .requested
//        )
//    ]
//    
//    NavigationStack {
//        NewAppointmentsView(sessions: sampleRequests)
//    }
//}
