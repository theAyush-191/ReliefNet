import SwiftUI

// MARK: - Session Status

//enum AppointmentType: String, CaseIterable {
//    case online = "Online Consultation"
//    case clinic = "Clinic Visit"
//    case home = "Home Visit"
//}






// MARK: - Doctor Session Model

struct DoctorSession: Identifiable {
    
    var id = UUID().uuidString
    
    // Doctor
    var doctorId: String
    var doctorName: String
    
    // Patient Info
    var patientId: String
    var patientName: String
    var patientAge: Int
    var patientGender: String
    
    // Appointment Type
    var appointmentType: AppointmentType
    
    // ⏰ TIMELINE (VERY IMPORTANT)
    
    // What patient requested
    var requestedDateTime: Date
    
    // What is reason to reschedule
    var rescheduleReason: String?
    
    // What doctor confirmed
    var confirmedDateTime: Date?
    
    // If doctor suggests new time
    var proposedDateTime: Date?
    
    // Medical Info
    var symptoms: String
//    var diagnosis: String?
    var prescription: String?
    
    // Notes for doctor
    var doctorNotes: String?
    
    // Follow-up
    var followUpDate: Date?
    
    // Status
    var status: SessionStatus
    
    // Created date
    var createdAt: Date = Date()
    
    var displayDateTime: Date {
        confirmedDateTime ?? proposedDateTime ?? requestedDateTime
    }
}

struct Sessions{
    
    static var sampleSession : [DoctorSession] = [DoctorSession(
        
        // Doctor
        doctorId: "doc_001",
        doctorName: "Dr. Sharma",
        
        // Patient Info
        patientId: "pat_001",
        patientName: "Rahul Verma",
        patientAge: 25,
        patientGender: "Male",
        
        // Appointment Type (coming from your existing model)
        appointmentType: .online, // or .clinic / .home
        
        // Timeline
        requestedDateTime: Date(),
        confirmedDateTime: Date().addingTimeInterval(3600), // +1 hour
        proposedDateTime: nil,
        
        // Medical Info
        symptoms: "Fever, headache, body pain",
//        diagnosis: "Viral Fever",
        prescription: "Paracetamol 500mg twice a day",
        
        // Notes
        doctorNotes: "Advise rest and hydration",
        
        // Follow-up
        followUpDate: Date().addingTimeInterval(86400 * 3),
        
        // Status
        status: .upcoming
    ),
                                                  DoctorSession(
                                                      doctorId: "D1",
                                                      doctorName: "Dr. You",
                                                      patientId: "P1",
                                                      patientName: "Rahul Verma",
                                                      patientAge: 28,
                                                      patientGender: "Male",
                                                      appointmentType: .clinic,
                                                      requestedDateTime: Date(),
                                                      confirmedDateTime: nil,
                                                      proposedDateTime: nil,
                                                      symptoms: "Chest pain and breathing issue",
//                                                      diagnosis: nil,
                                                      prescription:nil,
                                                      doctorNotes:nil,
                                                      followUpDate: nil,
                                                      status: .awaitingDoctor
                                                  ),
                                                  
                                                  DoctorSession(
                                                      doctorId: "D1",
                                                      doctorName: "Dr. You",
                                                      patientId: "P2",
                                                      patientName: "Ananya Singh",
                                                      patientAge: 24,
                                                      patientGender: "Female",
                                                      appointmentType: .online,
                                                      requestedDateTime: Calendar.current.date(byAdding: .hour, value: 3, to: Date())!,
                                                      confirmedDateTime: nil,
                                                      proposedDateTime: nil,
                                                      symptoms: "Anxiety, stress, sleep issues",
//                                                      diagnosis: nil,
                                                                                                          prescription:nil,
                                                                                                          doctorNotes:nil,
                                                      followUpDate: nil,
                                                      status: .awaitingDoctor
                                                  ),
                                                  
                                                  DoctorSession(
                                                      doctorId: "D1",
                                                      doctorName: "Dr. You",
                                                      patientId: "P3",
                                                      patientName: "Amit Sharma",
                                                      patientAge: 35,
                                                      patientGender: "Male",
                                                      appointmentType: .home,
                                                      requestedDateTime: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
                                                      confirmedDateTime: nil,
                                                      proposedDateTime: nil,
                                                      symptoms: "Fever and body pain",
//                                                      diagnosis: nil,
                                                                                                          prescription:nil,
                                                      doctorNotes:nil,
                                                      followUpDate: nil,
                                                      status: .awaitingDoctor
                                                  )]
}
