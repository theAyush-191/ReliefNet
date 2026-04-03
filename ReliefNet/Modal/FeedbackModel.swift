//
//  FeedbackMode.swift
//  ReliefNet
//
//  Created by Ayush Singh on 26/03/26.
//
import Foundation

struct Review: Identifiable, Codable {
    
    var id: String = UUID().uuidString
    
    var doctorId: String
    var patientId: String
    
    var patientName: String
    var rating: Int        // 1 to 5
    var comment: String
    
    var createdAt: Date = Date()
}

struct SampleReviews {
    
    static let reviews: [Review] = [
        
        Review(
            doctorId: "doc001",
            patientId: "pat001",
            patientName: "Rahul Sharma",
            rating: 5,
            comment: "Very professional and calm. Helped me understand my anxiety issues clearly."
        ),
        
        Review(
            doctorId: "doc001",
            patientId: "pat002",
            patientName: "Sneha Verma",
            rating: 4,
            comment: "Good session. Doctor listened patiently, but waiting time was a bit long."
        ),
        
        Review(
            doctorId: "doc001",
            patientId: "pat003",
            patientName: "Amit Singh",
            rating: 5,
            comment: "Highly recommended! I felt much better after just one consultation."
        ),
        
        Review(
            doctorId: "doc002",
            patientId: "pat004",
            patientName: "Neha Gupta",
            rating: 3,
            comment: "Average experience. Advice was helpful but felt a bit rushed."
        ),
        
        Review(
            doctorId: "doc002",
            patientId: "pat005",
            patientName: "Vikas Yadav",
            rating: 4,
            comment: "Good doctor, explained everything clearly."
        )
    ]
}
