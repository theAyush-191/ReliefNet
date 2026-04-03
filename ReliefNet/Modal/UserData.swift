//
//  DoctorData.swift
//  ReliefNet
//
//  Created by Ayush Singh on 15/10/25.
//

import SwiftUI

struct currentUserType{
    var userType: UserType = .patient
}

// MARK: - User Type
enum UserType: String, CaseIterable {
    case patient = "Patient"
    case doctor = "Doctor"
}



// Feedback Model
struct Feedback: Identifiable {
    let id = UUID()
    let patientName: String
    let rating: Double
    let comment: String
    let date: String    // ✅ New property for feedback date
}


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
        var phone: String
        var address: String
        var totalBookings: Int

    
}

struct patientData{
    static var samplePatient:Patient = Patient(
    name: "Ayush Singh",
            email: "ayush@example.com",
            age: 22,
            gender: "Male",
            phone:  "9876543210",
            address: "Lucknow, India",
            totalBookings: 5,

)
}

