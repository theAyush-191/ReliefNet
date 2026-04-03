//
//  DoctorProfile.swift
//  ReliefNet
//
//  Created by Ayush Singh on 15/10/25.
//

import SwiftUI

struct DoctorProfile: View {
    @EnvironmentObject var session: UserSession

    @State private var data: Doctor = Doctors.currentDoctor
    @State private var feedbacks: [Feedback] = sampleFeedbacks
    @State private var showHistory = false
    @State private var showEditSheet = false

    // MARK: - Computed Properties for Data
//    var doctor: Doctor {
//        sessions.currentDoctor ?? sampleDoctor
//    }
    
//    var doctorBinding: Binding<Doctor> {
//        Binding(
//            get: { session.currentDoctor ?? sampleDoctor },
//            set: { session.currentDoctor = $0 }
//        )
//    }

    // MARK: - Main Body
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                profileHeader
                
                Divider()
                
                aboutSection
                
                Divider()
                
                sessionHistorySection
                
                Divider()
                
                FeedSection(feedbacks: feedbacks)
            }
            .padding(.vertical)
        }
        .background(Color(.systemGray6))
        .navigationTitle("My Profile")
        .toolbar {
            editToolbarItem
        }
        .sheet(isPresented: $showEditSheet) {
            EditDoctorProfileView(doctor: $data)
        }
    }
}

// MARK: - View Components (Extracted Parts)
private extension DoctorProfile {
    
    // 1. Profile Header Part
    var profileHeader: some View {
        HStack(spacing: 20) {
            Image(data.image)
                .resizable()
                .scaledToFill() // Changed to fill for circular crop
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .shadow(radius: 6)

            VStack(alignment: .leading, spacing: 6) {
                Text(data.name)
                    .font(.title2.bold())
                
//                Text(data.specialization)
//                    .font(.subheadline)
//                    .foregroundColor(.gray)
                
                Text("\(data.experience) years of experience")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
        }
        .padding(.horizontal)
    }

    // 2. About Section Part
    var aboutSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("About")
                .font(.headline)
            Text(data.about)
                .font(.body)
                .foregroundColor(.gray)
        }
        .padding(.horizontal)
    }

    // 3. Session History Part
    var sessionHistorySection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Session History")
                    .font(.headline)
                Spacer()
                Button(action: { showHistory.toggle() }) {
                    Text(showHistory ? "Show Less" : "View All")
                        .font(.caption)
                        .foregroundColor(.blue)
                }
            }

//            let displaySessions = showHistory ? data : Array(data.prefix(3))
//            ForEach(displaySessions) { session in
//                SessionCardView(session: session)
//            }
        }
        .padding(.horizontal)
    }
    
    // 4. Toolbar Part
    var editToolbarItem: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button(action: { showEditSheet.toggle() }) {
                Label("Edit", systemImage: "square.and.pencil")
            }
        }
    }
}

struct SessionCardView: View {
    var session: DoctorSession
    var body: some View {
//        HStack {
//            VStack(alignment: .leading, spacing: 4) {
//                Text(session.patientName)
//                    .font(.subheadline.bold())
////                Text(session.createdAt)
////                    .font(.caption)
////                    .foregroundColor(.gray)
//            }
//            Spacer()
//            VStack(alignment: .trailing) {
//                Text(session.duration)
//                    .font(.caption)
//                    .foregroundColor(.gray)
//                Text(session.status)
//                    .font(.caption2.bold())
//                    .foregroundColor(session.status == "Completed" ? .green : .orange)
//            }
//        }
//        .padding()
//        .background(Color.white)
//        .cornerRadius(12)
//        .shadow(radius: 3)
    }
}

struct FeedbackCardView: View {
    var feedback: Feedback
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(feedback.patientName)
                    .font(.subheadline.bold())
                Spacer()
                Text("⭐️ \(String(format: "%.1f", feedback.rating))")
                    .font(.caption)
                    .foregroundColor(.orange)
            }
            Text(feedback.comment)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 3)
    }
}

struct FeedSection:View{
    var feedbacks: [Feedback]
    var body:some View{
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Feedback & Ratings")
                    .font(.headline)
                Spacer()
                Text("⭐️ Avg: ")
                    .font(.subheadline)
                    .foregroundColor(.orange)
            }

            ForEach(feedbacks) { feedback in
                FeedbackCardView(feedback: feedback)
            }
        }
        .padding(.horizontal)
    }
}


//    #Preview {
//        let session = UserSession()
//        session.currentDoctor = Doctor(
//            name: "Dr. Meer Sharma",
//            specialization: "Psychiatrist",
//            address: "Lucknow, Uttar Pradesh",
//            clinicLat: 26.8467,
//            clinicLong: 80.9462,
//            experience: 8,
//            about: "Experienced psychiatrist specializing in anxiety, depression, and stress-related issues."
//        )
//
//        NavigationStack {
//            DoctorProfile()
//                .environmentObject(session)
//        }
//    }
