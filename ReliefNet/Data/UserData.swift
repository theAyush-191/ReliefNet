//
//  DoctorData.swift
//  ReliefNet
//
//  Created by Ayush Singh on 15/10/25.
//

import SwiftUI

struct user{
    var userType: String = "Patient"

    
}


// MARK: - Doctor Model
struct Doctor: Identifiable {
    var id = UUID()
    var name: String
    var specialization: String
    var address:String
    var experience: Int
    var image: String="doctorPic"
    var about: String
}

// Session Model
struct Session: Identifiable {
    let id = UUID()
    let date: String
    let time: String
    let patientName: String
    let duration: String
    let type: String // e.g. "Online" or "In-person"
    let status: String
}

// Feedback Model
struct Feedback: Identifiable {
    let id = UUID()
    let patientName: String
    let rating: Double
    let comment: String
    let date: String    // ✅ New property for feedback date
}

// Sample Data
let sampleDoctor = Doctor(
    name: "Dr. Meera Sharma",
    specialization: "Psychiatrist",
    address: "Lucknow, Uttar Pradesh",
    experience: 8,
    about: "Experienced psychiatrist specializing in anxiety, depression, and stress-related issues. Passionate about improving mental well-being through therapy and guidance."
)

let sampleSessions: [Session] = [
    Session(date: "Oct 12, 2025", time: "10:30 AM", patientName: "Rohit Verma", duration: "45 min", type: "Online", status: "Completed"),
    Session(date: "Oct 13, 2025", time: "11:00 AM", patientName: "Neha Singh", duration: "30 min", type: "In-person", status: "Completed"),
    Session(date: "Oct 14, 2025", time: "1:00 PM", patientName: "Aditya Raj", duration: "40 min", type: "Online", status: "Upcoming")
]

let sampleFeedbacks: [Feedback] = [
    Feedback(patientName: "Rohit Verma", rating: 4.8, comment: "Very helpful session, felt much better after talking.", date: "Oct 12, 2025"),
    Feedback(patientName: "Neha Singh", rating: 5.0, comment: "Excellent advice and caring approach.", date: "Oct 13, 2025"),
    Feedback(patientName: "Aditya Raj", rating: 4.5, comment: "Good experience overall.", date: "Oct 14, 2025")
]



// MARK: - Patient Model
struct Patient: Identifiable {
        var id = UUID()
    var image: String = "profileImage"
        var name: String
        var email: String
        var age: Int
        var gender: String
        var phone: Int
        var address: String
        var totalBookings: Int

    
}


var samplePatient = Patient(
    name: "Ayush Singh",
            email: "ayush@example.com",
            age: 22,
            gender: "Male",
            phone:  9876543210,
            address: "Lucknow, India",
            totalBookings: 5,
//            lastVisitedDoctor: DoctorProfile(
//                name: "Dr. Neha Sharma",
//                specialization: "Dermatologist",
//                experience: "10 years",
//                email: "neha@clinic.com",
//                phone: "+91 9123456789",
//                about: "Specialist in skin care and cosmetic treatments."
//            )
)

//Booking Model
struct Booking: Identifiable {
    var id = UUID()
    var name: String
    var status: String
    var statusColor: Color
    var purpose: String
    var meetingType: String
    var date: Date
    var price: Int
    var isCompleted: Bool {
        if status == "Complete"{
            return true
        }
        else{
            return false
        }
    }
    var isPaid: Bool = false
}

//Bookings Sample
struct Bookings {
    let sampleBookings: [Booking] = [
        Booking(name: "Dr. Meera Sharma",
                status: "Confirmed",
                statusColor: .green,
                purpose: "Therapy Session",
                meetingType: "Video Call",
                date: Date().addingTimeInterval(86400), // +1 day
                price: 1200),
        
        Booking(name: "Dr. Arjun Verma",
                status: "Pending",
                statusColor: .yellow,
                purpose: "Follow-up Consultation",
                meetingType: "Home Visit",
                date: Date().addingTimeInterval(2 * 86400), // +2 days
                price: 1500),
        
        Booking(name: "Dr. Kavita Iyer",
                status: "Cancelled",
                statusColor: .red,
                purpose: "Stress Management",
                meetingType: "Video Call",
                date: Date().addingTimeInterval(-86400),
                price: 1000,
                isPaid: true), // -1 day
        
        Booking(name: "Dr. Rahul Khanna",
                status: "Confirmed",
                statusColor: .green,
                purpose: "Anxiety Therapy",
                meetingType: "Home Visit",
                date: Date().addingTimeInterval(5 * 86400),
                price: 1800,
                isPaid: true), // +5 days
        
        Booking(name: "Dr. Sneha Patil",
                status: "Pending",
                statusColor: .yellow,
                purpose: "Initial Evaluation",
                meetingType: "Video Call",
                date: Date().addingTimeInterval(-7 * 86400),
                price: 900), // -7 days
        
        Booking(name: "Dr. Manish Gupta",
                status: "Complete",
                statusColor: .blue,
                purpose: "Depression Support",
                meetingType: "Home Visit",
                date: Date().addingTimeInterval(-2 * 86400),
                price: 2000,
                isPaid: true), // -2 days
        
        Booking(name: "Dr. Priya Nair",
                status: "Cancelled",
                statusColor: .red,
                purpose: "Mindfulness Coaching",
                meetingType: "Video Call",
                date: Date().addingTimeInterval(10 * 86400),
                price: 1300,
                isPaid: true), // +10 days
        
        Booking(name: "Dr. Rohan Sinha",
                status: "Pending",
                statusColor: .yellow,
                purpose: "Sleep Disorder Check",
                meetingType: "Home Visit",
                date: Date().addingTimeInterval(3 * 86400),
                price: 1600), // +3 days
        
        Booking(name: "Dr. Anjali Menon",
                status: "Complete",
                statusColor: .blue,
                purpose: "Post-Therapy Review",
                meetingType: "Video Call",
                date: Date().addingTimeInterval(-5 * 86400),
                price: 1100,
                isPaid: true), // -5 days
        
        Booking(name: "Dr. Vikram Desai",
                status: "Confirmed",
                statusColor: .green,
                purpose: "Cognitive Behavioral Therapy",
                meetingType: "Home Visit",
                date: Date().addingTimeInterval(14 * 86400),
                price: 1900) // +14 days
    ]
}







//import SwiftUI
//
//// =======================================================
//// MARK: - Patient (User) Model
//// =======================================================
//struct Patient: Identifiable {
//    var id = UUID()
//    var image: String = "profileImage"
//    var name: String
//    var email: String
//    var age: Int
//    var gender: String
//    var phone: Int
//    var address: String
//    var totalBookings: Int
//}
//
//// Sample Patient
//var samplePatient = Patient(
//    name: "Ayush Singh",
//    email: "ayush@example.com",
//    age: 22,
//    gender: "Male",
//    phone: 9876543210,
//    address: "Lucknow, India",
//    totalBookings: 5
//)
//
//
//// =======================================================
//// MARK: - Doctor Model
//// =======================================================
//struct Doctor: Identifiable {
//    var id = UUID()
//    var name: String
//    var specialization: String
//    var address: String
//    var experience: Int
//    var image: String = "doctorPic"
//    var about: String
//}
//
//// Sample Doctor
//let sampleDoctor = Doctor(
//    name: "Dr. Mohit Sharma",
//    specialization: "Psychiatrist",
//    address: "Lucknow, Uttar Pradesh",
//    experience: 8,
//    about: "Experienced psychiatrist specializing in anxiety, depression, and stress-related issues. Passionate about improving mental well-being through therapy and guidance."
//)
//
//
//// =======================================================
//// MARK: - Session Model (Doctor Dashboard)
//// =======================================================
//struct Session: Identifiable {
//    let id = UUID()
//    let date: String
//    let time: String
//    let patientName: String
//    let duration: String
//    let type: String          // Online / In-person
//    let status: String
//}
//
//// Sample Sessions
//let sampleSessions: [Session] = [
//    Session(
//        date: "Oct 12, 2025",
//        time: "10:30 AM",
//        patientName: "Rohit Verma",
//        duration: "45 min",
//        type: "Online",
//        status: "Completed"
//    ),
//    Session(
//        date: "Oct 13, 2025",
//        time: "11:00 AM",
//        patientName: "Neha Singh",
//        duration: "30 min",
//        type: "In-person",
//        status: "Completed"
//    ),
//    Session(
//        date: "Oct 14, 2025",
//        time: "1:00 PM",
//        patientName: "Aditya Raj",
//        duration: "40 min",
//        type: "Online",
//        status: "Upcoming"
//    )
//]
//
//
//// =======================================================
//// MARK: - Feedback Model
//// =======================================================
//struct Feedback: Identifiable {
//    let id = UUID()
//    let patientName: String
//    let rating: Double
//    let comment: String
//    let date: String
//}
//
//// Sample Feedbacks
//let sampleFeedbacks: [Feedback] = [
//    Feedback(
//        patientName: "Rohit Verma",
//        rating: 4.8,
//        comment: "Very helpful session, felt much better after talking.",
//        date: "Oct 12, 2025"
//    ),
//    Feedback(
//        patientName: "Neha Singh",
//        rating: 5.0,
//        comment: "Excellent advice and caring approach.",
//        date: "Oct 13, 2025"
//    ),
//    Feedback(
//        patientName: "Aditya Raj",
//        rating: 4.5,
//        comment: "Good experience overall.",
//        date: "Oct 14, 2025"
//    )
//]
//
//
//// =======================================================
//// MARK: - Booking Model
//// =======================================================
//struct Booking: Identifiable {
//    var id = UUID()
//    var name: String
//    var status: String
//    var statusColor: Color
//    var purpose: String
//    var meetingType: String
//    var date: Date
//    var price: Int
//    var isPaid: Bool = false
//
//    var isCompleted: Bool {
//        status == "Complete"
//    }
//}
//
//// Sample Bookings
//let sampleBookings: [Booking] = [
//    Booking(
//        name: "Dr. Meera Sharma",
//        status: "Confirmed",
//        statusColor: .green,
//        purpose: "Therapy Session",
//        meetingType: "Video Call",
//        date: Date().addingTimeInterval(86400),
//        price: 1200
//    ),
//    Booking(
//        name: "Dr. Arjun Verma",
//        status: "Pending",
//        statusColor: .yellow,
//        purpose: "Follow-up Consultation",
//        meetingType: "Home Visit",
//        date: Date().addingTimeInterval(2 * 86400),
//        price: 1500
//    ),
//    Booking(
//        name: "Dr. Manish Gupta",
//        status: "Complete",
//        statusColor: .blue,
//        purpose: "Depression Support",
//        meetingType: "Home Visit",
//        date: Date().addingTimeInterval(-2 * 86400),
//        price: 2000,
//        isPaid: true
//    )
//]
