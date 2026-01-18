//
//  DoctorProfile.swift
//  ReliefNet
//
//  Created by Ayush Singh on 15/10/25.
//

import SwiftUI

struct DoctorProfile: View {
    @EnvironmentObject var session: UserSession

    var doctor: Doctor {
        session.currentDoctor ?? sampleDoctor
    }
    var doctorBinding: Binding<Doctor> {
        Binding(
            get: { session.currentDoctor ?? sampleDoctor },
            set: { session.currentDoctor = $0 }
        )
    }

    @State private var sessions: [Session] = sampleSessions
    @State private var feedbacks: [Feedback] = sampleFeedbacks
    @State private var showHistory = false
    @State private var showEditSheet = false

    var body: some View {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Profile Header
                    HStack(spacing: 20) {
                        Image(doctor.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .shadow(radius: 6)

                        VStack(alignment: .leading, spacing: 6) {
                            Text(doctor.name)
                                .font(.title2.bold())
                            Text(doctor.specialization)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Text("\(doctor.experience) years of experience")
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.horizontal)

                    Divider()

                    // About Section
                    VStack(alignment: .leading, spacing: 8) {
                        Text("About")
                            .font(.headline)
                        Text(doctor.about)
                            .font(.body)
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal)

                    Divider()

                    // Session History
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("Session History")
                                .font(.headline)
                            Spacer()
                            Button(action: { showHistory.toggle() }) {
                                Text("View All")
                                    .font(.caption)
                                    .foregroundColor(.blue)
                            }
                        }

                        ForEach(showHistory ? sessions : Array(sessions.prefix(3))) { session in
                            SessionCardView(session: session)
                        }
                    }
                    .padding(.horizontal)

                    Divider()

                    // Feedback Section
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("Feedback & Ratings")
                                .font(.headline)
                            Spacer()
                            Text("⭐️ Avg: \(String(format: "%.1f", averageRating()))")
                                .font(.subheadline)
                                .foregroundColor(.orange)
                        }

                        ForEach(feedbacks) { feedback in
                            FeedbackCardView(feedback: feedback)
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .background(Color(.systemGray6))
            .navigationTitle("My Profile")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showEditSheet.toggle() }) {
                        Label("Edit", systemImage: "square.and.pencil")
                    }
                }
            }
            .sheet(isPresented: $showEditSheet) {
                EditDoctorProfileView(doctor: doctorBinding)
            }
        
    }

    func averageRating() -> Double {
        let total = feedbacks.map { $0.rating }.reduce(0, +)
        return total / Double(feedbacks.count)
    }
}

struct SessionCardView: View {
    var session: Session
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(session.patientName)
                    .font(.subheadline.bold())
                Text(session.date)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text(session.duration)
                    .font(.caption)
                    .foregroundColor(.gray)
                Text(session.status)
                    .font(.caption2.bold())
                    .foregroundColor(session.status == "Completed" ? .green : .orange)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 3)
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


    #Preview {
        let session = UserSession()
        session.currentDoctor = Doctor(
            name: "Dr. Meer Sharma",
            specialization: "Psychiatrist",
            address: "Lucknow, Uttar Pradesh",
            experience: 8,
            about: "Experienced psychiatrist specializing in anxiety, depression, and stress-related issues."
        )

        return NavigationStack {
            DoctorProfile()
                .environmentObject(session)
        }
    }
