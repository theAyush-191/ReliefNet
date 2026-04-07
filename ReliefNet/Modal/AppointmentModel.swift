//
//  AppointmentModel.swift
//  ReliefNet
//
//  Created by Ayush Singh on 23/03/26.
//

import SwiftUI

struct Appointment: Identifiable {
    
    var id : UUID = UUID()
    
    // Doctor
    var doctorId: String
    var doctorName: String
    var doctorSpeciality: String
    
    // Patient
    var patientId: String
    var patientName: String
    var patientAge: Int
    var patientGender: Gender
    
    // Appointment Type
    var appointmentType: AppointmentType
    
    // Timeline
    var requestedDateTime: Date
    var proposals: [TimeProposal] // all negotiations
    var confirmedDateTime: Date?
    
    var rescheduleReason: String?
    
    // Medical Info
    var symptoms: String
    var patientNotes:String?
    
    var prescription: String?
    var doctorNotes: String?
    
    // Clinic Contact
    var clinicPhone: String
    
    // User Contact
    var patientPhone: String
    
    // Appointment Location Data
    var appointmentAddress: String?
    var addressLat: Double?
    var addressLong: Double?
    
    // Payment
    var payment: PaymentData
    
    // Status
    var status: SessionStatus
    
    var cancellation:CancellationInfo?
    
    var createdAt: Date = Date()
    
    var bookingCode:String
    
    // 🔥 Core logic
    var displayDateTime: Date {
        confirmedDateTime ?? proposals.last?.dateTime  ?? requestedDateTime
    }
}



enum AppointmentType: String, CaseIterable {
    case online = "Online Consultation"
    case clinic = "Clinic Visit"
    case home = "Home Visit"
}

enum Gender : String, CaseIterable{
    case male = "Male"
    case female = "Female"
    case other = "Other"
}

enum SessionStatus: String, CaseIterable {
    
//    case requested = "Requested"
    case upcoming = "Upcoming"
    case awaitingDoctor = "Awaiting Doctor"
    case awaitingPatient = "Awaiting Patient"
    case completed = "Completed"
    case cancelled = "Cancelled"
    
    var color: Color {
        switch self {
//        case .requested:
//            return .orange
        case .upcoming:
            return .blue
        case .awaitingDoctor:
            return .pink
        case .awaitingPatient:
            return .purple
        case .completed:
            return .green
        case .cancelled:
            return .red
        }
    }
}

struct TimeProposal: Identifiable{
    var id = UUID().uuidString
    var proposedBy: UserType
    var dateTime: Date
    var reason: String?
}

struct CancellationInfo: Identifiable{
    var id = UUID().uuidString
    var cancelledBy: UserType
    var reason: String
    var cancelledAt: Date
}

// MARK: - Payment

struct PaymentData: Identifiable {

    var id = UUID().uuidString

    var paymentDate: Date = Date()

    var amount: Double

    var method: PaymentMethod

    var transactionId: String?

    var isPaid: Bool = false
}



// MARK: - Payment Method

enum PaymentMethod: String, CaseIterable {

    case gpay = "Google Pay / UPI"

    case phonepe = "PhonePe"

    case payAtVisit = "Pay at Visit"
}


struct Appointments{
    static var appointments: [Appointment] = Appoint.appointments
}

struct Appoint{
    static var appointments: [Appointment] {
        
        let now = Date()
        let future = Calendar.current.date(byAdding: .hour, value: 4, to: now)!
        let future2 = Calendar.current.date(byAdding: .day, value: 1, to: now)!
        
        return [
            
            // MARK: 1. Online - Awaiting Patient (Doctor proposed time)
            Appointment(
                doctorId: "doc01",
                doctorName: "Dr. Rahul Verma",
                doctorSpeciality: "Therapist",
                
                patientId: "pat1",
                patientName: "Ayush",
                patientAge: 22,
                patientGender: .male,
                
                appointmentType: .online,
                
                requestedDateTime: now,
                proposals: [
                    TimeProposal(proposedBy: .doctor, dateTime: future, reason: "Busy at requested time")
                ],
                confirmedDateTime: nil,
                
                symptoms: "Anxiety",
                patientNotes: "Feeling low",
                
                clinicPhone: "9876543210",
                patientPhone: "9999999999",
                
                appointmentAddress: "Online Consultation",
                
                payment: PaymentData(amount: 500, method: .payAtVisit),
                
                status: .awaitingPatient, bookingCode: "592004"
            ),
            
            // MARK: 2. Clinic - Awaiting Doctor (Patient proposed again)
            Appointment(
                doctorId: "doc2",
                doctorName: "Dr. Priya Sharma",
                doctorSpeciality: "Dermatologist",
                
                patientId: "pat1",
                patientName: "Ayush",
                patientAge: 22,
                patientGender: .male,
                
                appointmentType: .clinic,
                
                requestedDateTime: now,
                proposals: [
                    TimeProposal(proposedBy: .doctor, dateTime: future, reason: "Unavailable"),
                    TimeProposal(proposedBy: .patient, dateTime: future2, reason: "Not free at that time")
                ],
                confirmedDateTime: nil,
                
                symptoms: "Skin rash",
                patientNotes: nil,
                
                clinicPhone: "8888888888",
                patientPhone: "9999999999",
                
                appointmentAddress: "Apollo Clinic, Lucknow",
                addressLat: 26.8467,
                addressLong: 80.9462,
                
                payment: PaymentData(amount: 600, method: .payAtVisit),
                
                status: .awaitingDoctor, bookingCode: "892939"
            ),
            
            // MARK: 3. Home Visit - Upcoming (Confirmed)
            Appointment(
                doctorId: "doc3",
                doctorName: "Dr. Amit Singh",
                doctorSpeciality: "General Physician",
                
                patientId: "pat1",
                patientName: "Ayush",
                patientAge: 22,
                patientGender: .male,
                
                appointmentType: .home,
                
                requestedDateTime: now,
                proposals: [],
                confirmedDateTime: future,
                
                symptoms: "Fever",
                patientNotes: "High temperature",
                
                clinicPhone: "7777777777",
                patientPhone: "9999999999",
                
                appointmentAddress: "Gomti Nagar, Lucknow",
                addressLat: 26.8500,
                addressLong: 80.9920,
                
                payment: PaymentData(amount: 800, method: .payAtVisit),
                
                status: .upcoming, bookingCode: "432432"
            ),
            
            // MARK: 4. Online - Completed
            Appointment(
                doctorId: "doc4",
                doctorName: "Dr. Neha Kapoor",
                doctorSpeciality: "Psychologist",
                
                patientId: "pat1",
                patientName: "Ayush",
                patientAge: 22,
                patientGender: .male,
                
                appointmentType: .online,
                
                requestedDateTime: now,
                proposals: [],
                confirmedDateTime: now,
                
                symptoms: "Stress",
                patientNotes: nil,
                
                clinicPhone: "6666666666",
                patientPhone: "9999999999",
                
                appointmentAddress: "Online",
                
                payment: PaymentData(amount: 400, method: .payAtVisit),
                
                status: .completed, bookingCode: "235235"
            ),
            
            // MARK: 5. Clinic - Cancelled
            Appointment(
                doctorId: "doc5",
                doctorName: "Dr. Vikram Joshi",
                doctorSpeciality: "Cardiologist",
                
                patientId: "pat1",
                patientName: "Ayush",
                patientAge: 22,
                patientGender: .male,
                
                appointmentType: .clinic,
                
                requestedDateTime: now,
                proposals: [],
                confirmedDateTime: nil,
                
                symptoms: "Chest pain",
                patientNotes: nil,
                
                clinicPhone: "5555555555",
                patientPhone: "9999999999",
                
                appointmentAddress: "Medanta Hospital",
                addressLat: 28.4595,
                addressLong: 77.0266,
                
                payment: PaymentData(amount: 1000, method: .payAtVisit),
                
                status: .cancelled,
                
                cancellation: CancellationInfo(
                    cancelledBy: .patient,
                    reason: "Feeling better",
                    cancelledAt: now
                ), bookingCode: "523525"
            )
        ]
    }
}


