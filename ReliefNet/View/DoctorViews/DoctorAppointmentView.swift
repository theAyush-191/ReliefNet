import SwiftUI

// MARK: - View

struct DoctorAppointmentView: View {
    
    @Binding var sessions: [DoctorSession]
    @State private var selectedSegment = 0
    
   
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            // MARK: - Segment Control
            HStack {
                segmentButton(title: "Today", index: 0)
                segmentButton(title: "Upcoming", index: 1)
                segmentButton(title: "Past", index: 2)
            }
            .padding(6)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
            .padding()
            
            
            // MARK: - List
            ScrollView {
                VStack(spacing: 12) {
                    
                    if $sessions.isEmpty {
                        Text("No appointments")
                            .foregroundColor(.gray)
                            .padding(.top, 40)
                    }
                    
                    ForEach($sessions) { $session in
                        if isVisisble(session: session){
                            NavigationLink(destination: AppointmentDetailView(session: $session)){
                                SessionRow(session: $session)
                            }
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
        }
        .navigationTitle("Appointments")
    }
    
    // MARK: - Segment Button
    func segmentButton(title: String, index: Int) -> some View {
        Button {
            selectedSegment = index
        } label: {
            Text(title)
                .font(.subheadline)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
                .background(selectedSegment == index ? Color.purple : Color.clear)
                .foregroundColor(selectedSegment == index ? .white : .purple)
                .cornerRadius(8)
        }
    }
    
    func isVisisble(session:DoctorSession)->Bool{

            let calendar = Calendar.current
            
            switch selectedSegment {
            case 0: // Today
                return calendar.isDateInToday(session.displayDateTime)
                
            case 1: // Upcoming
                return session.displayDateTime > Date() && !calendar.isDateInToday(session.displayDateTime)
                
            case 2: // Past
                return session.displayDateTime < Date()
                
            default:
                return true
            }
        
    }
}


// MARK: - Card UI

struct SessionRow: View {
    
    @Binding var session: DoctorSession
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 12) {
            
            // 🔷 Top Row
            HStack(alignment: .top, spacing: 12) {
                
                // Avatar
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
                    
                    Text(session.appointmentType.rawValue)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                // Status Badge
                Text(session.status.rawValue)
                    .font(.caption2)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .foregroundColor(session.status.color)
                    .background(session.status.color.opacity(0.1))
                    .clipShape(Capsule())
            }
            
            // 🔷 Time
            HStack {
                Image(systemName: "clock")
                Text(session.displayDateTime.formatted(date: .abbreviated, time: .shortened))
            }
            .font(.caption)
            .foregroundColor(.gray)
            
            // 🔷 Symptoms
            Text(session.symptoms)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(1)
            
            // 🔷 Actions
            HStack {
                
                if session.status == .upcoming {
//                    Button("Start") {}
//                        .buttonStyle(.borderedProminent)
                    
//                    NavigationLink(destination:RescheduleView(session:$session)){
//                        Text("Reschedule").border(Color.purple, width: 1)
//                    }
                }
                else if session.status == .completed {
                    Button("View Summary") {}
                        .buttonStyle(.bordered)
                }
            }
            .tint(.purple)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(14)
        .shadow(color: .black.opacity(0.05), radius: 8, y: 4)
    }
}
//
//#Preview {
//    var sampleSessions: [DoctorSession] = [
//        DoctorSession(
//            
//            // Doctor
//            doctorId: "doc_001",
//            doctorName: "Dr. Sharma",
//            
//            // Patient Info
//            patientId: "pat_001",
//            patientName: "Rahul Verma",
//            patientAge: 25,
//            patientGender: "Male",
//            
//            // Appointment Type (coming from your existing model)
//            appointmentType: .online, // or .clinic / .home
//            
//            // Timeline
//            requestedDateTime: Date(),
//            confirmedDateTime: Date().addingTimeInterval(3600), // +1 hour
//            proposedDateTime: nil,
//            
//            // Medical Info
//            symptoms: "Fever, headache, body pain",
//            diagnosis: "Viral Fever",
//            prescription: "Paracetamol 500mg twice a day",
//            
//            // Notes
//            doctorNotes: "Advise rest and hydration",
//            
//            // Follow-up
//            followUpDate: Date().addingTimeInterval(86400 * 3),
//            
//            // Status
//            status: .upcoming
//        ),
//        DoctorSession(
//            
//            // Doctor
//            doctorId: "doc_001",
//            doctorName: "Dr. Sharma",
//            
//            // Patient Info
//            patientId: "pat_001",
//            patientName: "Rahul Verma",
//            patientAge: 25,
//            patientGender: "Male",
//            
//            // Appointment Type (coming from your existing model)
//            appointmentType: .online, // or .clinic / .home
//            
//            // Timeline
//            requestedDateTime: Date(),
//            confirmedDateTime: Date().addingTimeInterval(-3600 * 24), // +1 hour
//            proposedDateTime: nil,
//            
//            // Medical Info
//            symptoms: "Fever, headache, body pain",
//            diagnosis: "Viral Fever",
//            prescription: "Paracetamol 500mg twice a day",
//            
//            // Notes
//            doctorNotes: "Advise rest and hydration",
//            
//            // Follow-up
//            followUpDate: Date().addingTimeInterval(86400 * 3),
//            
//            // Status
//            status: .completed
//        ),
//        DoctorSession(
//            
//            // Doctor
//            doctorId: "doc_001",
//            doctorName: "Dr. Sharma",
//            
//            // Patient Info
//            patientId: "pat_001",
//            patientName: "Rahul Verma",
//            patientAge: 25,
//            patientGender: "Male",
//            
//            // Appointment Type (coming from your existing model)
//            appointmentType: .online, // or .clinic / .home
//            
//            // Timeline
//            requestedDateTime: Date(),
//            confirmedDateTime: Date().addingTimeInterval(3600 * 24), // +1 hour
//            proposedDateTime: nil,
//            
//            // Medical Info
//            symptoms: "Fever, headache, body pain",
//            diagnosis: "Viral Fever",
//            prescription: "Paracetamol 500mg twice a day",
//            
//            // Notes
//            doctorNotes: "Advise rest and hydration",
//            
//            // Follow-up
//            followUpDate: Date().addingTimeInterval(86400 * 3),
//            
//            // Status
//            status:.upcoming
//        )
//    ]
//    
//    NavigationStack {
//DoctorAppointmentView(sessions: $sampleSessions)
//    }
//}

