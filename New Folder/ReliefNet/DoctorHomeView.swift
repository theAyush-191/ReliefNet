import SwiftUI

struct DoctorHomeView: View {
    @EnvironmentObject var session: UserSession

    var doctor: Doctor {
        session.currentDoctor ?? sampleDoctor
    }

    var body: some View {

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {

                    // MARK: - Header
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Good Morning,")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Text("Dr. \(doctor.name) 👋")
                                .font(.title2)
                                .bold()
                        }
                        Spacer()
                        Image(systemName: "bell.badge.fill")
                            .font(.title2)
                            .foregroundColor(.blue)
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)

                    // MARK: - Quick Cards
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {

                        NavigationLink(destination: DoctorAppointmentView()) {
                            QuickCardView(title: "Appointments", icon: "calendar.badge.clock", color: .blue)
                        }

                        QuickCardView(title: "Notifications", icon: "bell.fill", color: .orange)

                        NavigationLink(destination: DoctorFeedbackView()) {
                            QuickCardView(title: "Patient Feedback", icon: "star.fill", color: .green)
                        }

                        NavigationLink(destination: SessionCreationView()) {
                            QuickCardView(title: "Create Session", icon: "plus.circle.fill", color: .purple)
                        }
                    }
                    .padding(.horizontal)

                    // MARK: - Upcoming Appointments
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Today's Appointments")
                            .font(.headline)
                            .padding(.horizontal)

                        ForEach(0..<3) { index in
                            AppointmentRowView(patientName: "Patient \(index + 1)", time: "10:\(index)0 AM", type: "Clinic Visit")
                        }
                    }
                    .padding(.top)
                }
                .padding(.bottom, 40)
            }
            .navigationTitle("Dashboard")
            .navigationBarTitleDisplayMode(.inline)
        
    }
}

// MARK: - Components
struct QuickCardView: View {
    let title: String
    let icon: String
    let color: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding(10)
                    .background(color)
                    .clipShape(Circle())
                Spacer()
            }

            Text(title)
                .font(.headline)
                .foregroundColor(.primary)
                .lineLimit(2)
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 120)
        .background(Color(.systemGray6))
        .cornerRadius(16)
        .shadow(color: .gray.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}

struct AppointmentRowView: View {
    let patientName: String
    let time: String
    let type: String

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(patientName)
                    .font(.headline)
                Text("\(time) • \(type)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .padding(.horizontal)
    }
}

