//import SwiftUI
//
//// MARK: - Appointment Type
//
//enum AppointmentType: String, CaseIterable {
//    case online = "Online Consultation"
//    case clinic = "Clinic Visit"
//    case home = "Home Visit"
//}
//
//
//
//// MARK: - Booking Status
//
//enum BookingStatus: String, CaseIterable {
//    
//    case requestSent = "Request Sent"
//    case doctorAccepted = "Doctor Accepted"
//    case doctorRescheduled = "Doctor Rescheduled"
//    case completed = "Completed"
//    case cancelled = "Cancelled"
//    
//    var color: Color {
//        switch self {
//        case .requestSent:
//            return .orange
//        case .doctorAccepted:
//            return .green
//        case .doctorRescheduled:
//            return .purple
//        case .completed:
//            return .blue
//        case .cancelled:
//            return .red
//        }
//    }
//    
//    var isCompleted: Bool {
//        self == .completed
//    }
//}
//
//
//
//// MARK: - Payment
//
//struct PaymentData: Identifiable {
//    
//    var id = UUID().uuidString
//    
//    var paymentDate: Date = Date()
//    
//    var amount: Double
//    
//    var method: PaymentMethod
//    
//    var transactionId: String?
//    
//    var isPaid: Bool = false
//}
//
//
//
//// MARK: - Payment Method
//
//enum PaymentMethod: String, CaseIterable {
//    
//    case gpay = "Google Pay / UPI"
//    
//    case phonepe = "PhonePe"
//    
//    case payAtVisit = "Pay at Visit"
//}
//
//
//
//// MARK: - Booking Model
//
//struct Booking: Identifiable {
//    
//    var id = UUID().uuidString
//    
//    // Doctor
//    var doctorId: String
//    var doctorName: String
//    var doctorSpeciality: String
//    
//    // Patient
//    var patientId: String
//    
//    // Appointment
//    var appointmentType: AppointmentType
//    
//    // Patient request
//    var requestedDateTime: Date
//    
//    // Doctor confirmation
//    var confirmedDateTime: Date?
//    
//    // Reschedule Reason
//    var rescheduleReason:String?
//    
//    // Medical details
//    var symptoms: String
//    var notes: String?
//    
//    // Clinic details
//    var clinicAddress: String
//    var clinicPhone: String
//    
//    // Clinic location
//    var clinicLat: Double
//    var clinicLong: Double
//    
//    // Payment
//    var payment: PaymentData
//    
//    // Status
//    var status: BookingStatus
//    
//    // Created date
//    var bookingCreatedAt: Date = Date()
//
//}
//
//struct Bookings{
//    static var sampleBookings:[Booking]=[Booking(
//        doctorId: "DOC001",
//        doctorName: "Dr. Rahul Sharma",
//        doctorSpeciality: "Cardiologist",
//        patientId: "PAT001",
//        appointmentType: .online,
//        requestedDateTime: Date(),
//        confirmedDateTime: Date(),
//        symptoms: "Chest Pain",
//        notes: nil,
//        clinicAddress: "Apollo Clinic, Lucknow",
//        clinicPhone: "+91 9876543210",
//        clinicLat: 26.8467,
//        clinicLong: 80.9462,
//        payment: PaymentData(amount: 500, method: .gpay, isPaid: true),
//        status: .doctorAccepted
//    )]
//}
