//
//  DoctorData.swift
//  ReliefNet
//
//  Created by Ayush Singh on 06/10/25.
//

import Foundation
import SwiftUI

enum AvailabilityStatus: String, CaseIterable {
    case available = "Available"
    case busy = "Busy"
    case offline = "Offline"
    
    var colour: Color{
        
        switch self {
            
        case .available:
            return .green
            
        case .busy:
            return .red
            
        case .offline:
            return .gray
        }
    }
}

struct Doctor: Identifiable {
    
    var id = UUID().uuidString
    var isCompleteProfile: Bool = false
    var name: String
    var gender: Gender
    var age: Int
    
    var specialization: [String]
    var qualifications: [Qualification]
    var category: DoctorCategory
    
    var experience: Int
    var consultationOptions: [ConsultationOption]
    
    var rating: Double
    var reviews: Int
    

    var image: String
    var about: String
    
    var availability: AvailabilityStatus
    
    // NEW PROPERTIES

    
    var clinic: [Clinic]
}

struct ConsultationOption : Identifiable{
    var id = UUID().uuidString
    var mode: AppointmentType
    var price: Int
    var isEnabled: Bool
    var clinicId: String?
}

struct Clinic: Identifiable {
    
    var id = UUID().uuidString
    
    var name: String
    var address: String
    var availability: AvailabilityStatus
    var isOpen:Bool
    var lat: Double
    var long: Double
    var phone: String
    var openTime: Int
    var closeTime: Int
}

struct Qualification: Identifiable {
    var id = UUID().uuidString
    var degree: String        // e.g., MBBS
    var institute: String     // e.g., AIIMS Delhi
    var year: Int             // e.g., 2015
}


//
//enum AppointmentType: String, CaseIterable{
//    case home = "Home Visit"
//    case clinic = "Clinic Visit"
//    case online = "Online Consultation"
//}

enum DoctorCategory:String, CaseIterable{
    // Mental Health (Core)
       case psychologist = "Psychologist"
       case psychiatrist = "Psychiatrist"
       case therapist = "Therapist"
       case dentist = "Dentist"
       
       // General
       case generalPhysician = "General Physician"
       case pediatrician = "Pediatrician"
       case gynecologist = "Gynecologist"
       
    
       // Specialists (optional)
       case cardiologist = "Cardiologist"
       case dermatologist = "Dermatologist"
       case neurologist = "Neurologist"
       case orthopedist = "Orthopedist"
       case endocrinologist = "Endocrinologist"
       case surgeon = "Surgeon"
}

// Sample Data

struct Doctors{
    
    
    static let doctorsData: [Doctor] = [
        
        // MARK: - Doctor 1 (Psychologist)
        
        {
            let clinic1 = Clinic(
                id: "c1",
                name: "MindCare Clinic",
                address: "Lanka, Varanasi",
                availability: .available,
                isOpen: true,
                lat: 25.2677,
                long: 82.9913,
                phone: "+91 9876543210",
                openTime: 10,
                closeTime: 18
            )
            
            let qualifications = [
                Qualification(degree: "BA Psychology", institute: "DU", year: 2012),
                Qualification(degree: "MSc Clinical Psychology", institute: "BHU", year: 2015)
            ]
            
            return Doctor(
                name: "Dr. Priya Sharma",
                gender: .female,
                age: 34,
                specialization: ["Anxiety", "Depression"],
                qualifications: qualifications, category: .psychologist,
                experience: 8,
                consultationOptions: [
                    ConsultationOption(mode: .online, price: 800, isEnabled: true, clinicId: nil),
                    ConsultationOption(mode: .clinic, price: 1200, isEnabled: true, clinicId: clinic1.id)
                ],
                rating: 4.9,
                reviews: 124,
                image: "doctor1",
                about: "Expert in CBT therapy and emotional wellness.",
                availability: .available,
                clinic: [clinic1]
            )
        }(),
        
        // MARK: - Doctor 2 (Gynecologist)
        
        {
            let clinic1 = Clinic(
                id: "c2",
                name: "Women's Care Hospital",
                address: "Sigra, Varanasi",
                availability: .busy,
                isOpen: false,
                lat: 25.3176,
                long: 82.9886,
                phone: "+91 9123456780",
                openTime: 9,
                closeTime: 17
            )
            
            let qualifications = [
                Qualification(degree: "MBBS", institute: "BHU", year: 2008),
                Qualification(degree: "MD Gynecology", institute: "AIIMS Delhi", year: 2012)
            ]
            
            return Doctor(
                name: "Dr. Neha Singh",
                gender: .female,
                age: 40,
                specialization: ["Pregnancy", "PCOS"],
                qualifications: qualifications, category: .gynecologist,
                experience: 12,
                consultationOptions: [
                    ConsultationOption(mode: .clinic, price: 1500, isEnabled: true, clinicId: clinic1.id),
                    ConsultationOption(mode: .online, price: 1000, isEnabled: true, clinicId: nil)
                ],
                rating: 4.8,
                reviews: 210,
                image: "doctor2",
                about: "Specialist in women’s health and high-risk pregnancies.",
                availability: .busy,
                clinic: [clinic1]
            )
        }(),
        
        // MARK: - Doctor 3 (General Physician)
        
        {
            let clinic1 = Clinic(
                id: "c3",
                name: "City Health Clinic",
                address: "Assi Ghat, Varanasi",
                availability: .available,
                isOpen: true,
                lat: 25.2870,
                long: 82.9995,
                phone: "+91 9988776655",
                openTime: 8,
                closeTime: 20
            )
            
            let qualifications = [
                Qualification(degree: "MBBS", institute: "KGMU", year: 2010)
            ]
            
            return Doctor(
                name: "Dr. Amit Verma",
                gender: .male,
                age: 38,
                specialization: ["Fever", "General Illness"],
                qualifications: qualifications, category: .generalPhysician,
                experience: 10,
                consultationOptions: [
                    ConsultationOption(mode: .home, price: 2000, isEnabled: true, clinicId: nil),
                    ConsultationOption(mode: .clinic, price: 800, isEnabled: true, clinicId: clinic1.id)
                ],
                rating: 4.6,
                reviews: 98,
                image: "doctor3",
                about: "Experienced general physician with strong diagnosis skills.",
                availability: .available,
                clinic: [clinic1]
            )
        }()
    ]

    
    static let currentDoctor: Doctor = {
            
            let clinic1 = Clinic(
                id: "c4",
                name: "ReliefNet Wellness Center",
                address: "BHU Road, Varanasi",
                availability: .available,
                isOpen: true,
                lat: 25.2670,
                long: 82.9895,
                phone: "+91 9000000000",
                openTime: 10,
                closeTime: 18
            )

            let qualifications = [
                Qualification(degree: "BSc Psychology", institute: "BHU", year: 2022),
                Qualification(degree: "Diploma in Counseling", institute: "IGNOU", year: 2024)
            ]

            return Doctor(
                name: "Dr. Ayush Singh",
                gender: .male,
                age: 25,
                specialization: ["Mental Health", "Stress Management"],
                qualifications: qualifications, category: .therapist,
                experience: 2,
                consultationOptions: [
                    ConsultationOption(mode: .online, price: 500, isEnabled: true, clinicId: nil),
                    ConsultationOption(mode: .clinic, price: 700, isEnabled: true, clinicId: clinic1.id)
                ],
                rating: 0.0,
                reviews: 0,
                image: "profile_placeholder",
                about: "Passionate about helping people manage stress and improve mental well-being.",
                availability: .available,
                clinic: [clinic1]
            )
        }()
    
}
