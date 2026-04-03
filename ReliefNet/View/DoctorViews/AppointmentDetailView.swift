import SwiftUI

struct AppointmentDetailView: View {
    
    @Binding var session: DoctorSession
    @State private var showAcceptSheet = false
    @State private var showRescheduleSheet = false
    @State private var showCancelAlert = false
    
    @State var prescription: String = ""
    @State var notes: String = ""
    
    var body: some View {
        
        ScrollView {
            VStack(spacing: 16) {
                
                // MARK: - Status
                HStack {
                    Text(session.status.rawValue)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(session.status.color.opacity(0.15))
                        .foregroundColor(session.status.color)
                        .cornerRadius(8)
                    
                    Spacer()
                }
                
                // MARK: - Patient Info
                VStack(alignment: .leading, spacing: 6) {
                    
                    Text(session.patientName)
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    Text("\(session.patientGender) • \(session.patientAge) yrs")
                        .foregroundColor(.gray)
                    
                    Text(session.appointmentType.rawValue)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                
                Divider()
                
                
                // MARK: - Time Info
                VStack(alignment: .leading, spacing: 10) {
                    
                    DetailRow(
                        icon: "calendar",
                        title: "Requested",
                        value: session.requestedDateTime.formatted(date: .abbreviated, time: .shortened)
                    )
                    
                    if let confirmed = session.confirmedDateTime {
                        DetailRow(
                            icon: "checkmark.calendar",
                            title: "Confirmed",
                            value: confirmed.formatted(date: .abbreviated, time: .shortened)
                        )
                    }
                    
                    if let proposed = session.proposedDateTime {
                        DetailRow(
                            icon: "arrow.triangle.2.circlepath",
                            title: "Rescheduled",
                            value: proposed.formatted(date: .abbreviated, time: .shortened)
                        )
                    }
                }
                
                
                Divider()
                
                
                // MARK: - Symptoms
                VStack(alignment: .leading, spacing: 6) {
                    
                    Text("Symptoms")
                        .font(.headline)
                    
                    Text(session.symptoms)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                
                // MARK: - Diagnosis (if completed)
//                if let diagnosis = session.diagnosis {
//                    Divider()
//                    
//                    VStack(alignment: .leading, spacing: 6) {
//                        Text("Diagnosis")
//                            .font(.headline)
//                        Text(diagnosis)
//                            .foregroundColor(.gray)
//                    }
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                }
                
                
                // MARK: - Prescription
                if session.status == .completed{
//                    if let prescription = session.prescription {
                        Divider()
                        
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Prescription")
                                .font(.headline)
                            TextField("Prescription", text: $prescription)
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
//                    }
                    
                    
                    // MARK: - Notes
//                    if let notes = session.doctorNotes {
                        Divider()
                        
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Doctor Notes")
                                .font(.headline)
                            TextField("Add Notes",text:$notes)
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
//                    }
                }
                
                // MARK: - Follow-up
                if let followUp = session.followUpDate {
                    Divider()
                    
                    DetailRow(
                        icon: "arrow.clockwise",
                        title: "Follow-up",
                        value: followUp.formatted(date: .abbreviated, time: .shortened)
                    )
                }
                
                
                Divider()
                
                
                // MARK: - Actions
                
                VStack(spacing: 12) {
                    
                    if session.status == .requested {
                        Button("Accept") {
                            //                            showAcceptSheet = true
                            session.confirmedDateTime = session.proposedDateTime ?? session.requestedDateTime
                                                        session.status = .upcoming
                            
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    // Reschedule
                    if session.status != .completed && session.status != .cancelled {
                    Button("Reschedule") {
                        showRescheduleSheet = true
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                    
                    if session.status == .upcoming {
                        Button("Completed") {
//                            showAcceptSheet = true
                            session.status = .completed
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    // Cancel (destructive)
                    
                    if session.status != .completed && session.status != .cancelled {
                        Button("Cancel Appointment") {
                            showCancelAlert = true
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red.opacity(0.1))
                        .foregroundColor(.red)
                        .cornerRadius(10)
                    }
                }
                .padding(.top, 10)
                
            }
            .padding()
        }
        .navigationTitle("Appointment")
        .navigationBarTitleDisplayMode(.inline)
        
        // MARK: - Cancel Alert
        .alert("Cancel Appointment?", isPresented: $showCancelAlert) {
            Button("Yes, Cancel", role: .destructive) {
                // Handle cancel
                session.status = .cancelled
            }
            Button("No", role: .cancel) {}
        }
        
        // MARK: - Reschedule Sheet
        .sheet(isPresented: $showRescheduleSheet) {
//            RescheduleView(session:$session)
        }
        .onDisappear {
            session.prescription = prescription
            session.doctorNotes = notes
        }
        .onAppear {
            if let note = session.doctorNotes, let prescrip = session.prescription{
                notes=note
                prescription = prescrip
            }
        }
    }
}
