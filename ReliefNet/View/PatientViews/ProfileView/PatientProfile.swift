import SwiftUI

struct PatientProfileView: View {
    @State var patient: Patient
    @State private var showingEditProfile = false
    
    var body: some View {
        ZStack {
            // Background Layer
            Color(.systemGroupedBackground).ignoresSafeArea()
            Image("appBG")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .opacity(0.1)
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 25) {
                    
                    // MARK: - 1. Profile Header
                    VStack(spacing: 15) {
                        ZStack {
                            Circle()
                                .fill(LinearGradient(colors: [.purple.opacity(0.3), .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                                .frame(width: 120, height: 120)
                            
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 110, height: 110)
                                .foregroundColor(.white)
                                .clipShape(Circle())
                        }
                        .shadow(color: .purple.opacity(0.2), radius: 10, x: 0, y: 5)
                        
                        VStack(spacing: 4) {
                            Text(patient.name)
                                .font(.system(size: 24, weight: .bold, design: .serif))
                            
                            Text(patient.email)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.top, 20)
                    
                    // MARK: - 2. Quick Stats Card
                    HStack(spacing: 0) {
                        ProfileStat(title: "Age", value: "\(patient.age)", icon: "calendar")
                        
                        Divider().frame(height: 30).padding(.horizontal, 20)
                        
                        ProfileStat(title: "Gender", value: patient.gender.rawValue, icon: "person.fill.questionmark")
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 20).fill(Color.white))
                    .padding(.horizontal)
                    .shadow(color: .black.opacity(0.03), radius: 10, y: 5)
                    
                    // MARK: - 3. Information Sections
                    VStack(spacing: 20) {
                        InfoSectionCard(title: "Contact Details") {
                            VStack(spacing: 16) {
                                ProfileRow(icon: "phone.circle.fill", text: patient.phone, color: .green)
                                if let address = patient.address {
                                    ProfileRow(icon: "mappin.circle.fill", text: address, color: .red)
                                }
                            }
                        }
                        
                        InfoSectionCard(title: "Health Records") {
                            VStack(spacing: 16) {
                                NavigationLink(destination: Text("Blood Group")) {
                                    ProfileRow(icon: "drop.fill", text: "Blood Group: B+", color: .red, hasChevron: true)
                                }
                                NavigationLink(destination: Text("Allergies")) {
                                    ProfileRow(icon: "exclamationmark.triangle.fill", text: "No Known Allergies", color: .orange, hasChevron: true)
                                }
                            }
                        }
                        
                        InfoSectionCard(title: "Recent Activity") {
                            HStack {
                                Image(systemName: "clock.badge.checkmark.fill")
                                    .foregroundColor(.gray)
                                Text("No recent visits yet")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .padding(.horizontal)
                    
                    // MARK: - 4. Logout Button
                    Button(action: { /* Logout Logic */ }) {
                        Label("Sign Out", systemImage: "arrow.right.circle.fill")
                            .font(.headline)
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 15).stroke(Color.red, lineWidth: 1))
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                    
                    Spacer(minLength: 50)
                }
            }
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button { showingEditProfile = true } label: {
                    Text("Edit").fontWeight(.bold)
                }
            }
        }
        .sheet(isPresented: $showingEditProfile) {
            NavigationStack {
                EditPatientProfileSheet(data: $patient)
            }
        }
    }
}

// MARK: - Reusable Sub-components

struct InfoSectionCard<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(title)
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(.secondary)
                .textCase(.uppercase)
                .padding(.leading, 5)
            
            VStack {
                content
            }
            .padding()
            .background(Color.white)
            .cornerRadius(18)
            .shadow(color: .black.opacity(0.02), radius: 5, y: 2)
        }
    }
}

struct ProfileStat: View {
    var title: String
    var value: String
    var icon: String
    
    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: icon)
                .font(.caption2)
                .foregroundColor(.purple)
            Text(value)
                .font(.headline)
            Text(title)
                .font(.caption2)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
    }
}

struct ProfileRow: View {
    var icon: String
    var text: String
    var color: Color = .purple
    var hasChevron: Bool = false
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(color)
                .frame(width: 24)
            
            Text(text)
                .font(.subheadline)
                .foregroundColor(.primary)
            
            Spacer()
            
            if hasChevron {
                Image(systemName: "chevron.right")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
        }
    }
}

#Preview {
    NavigationStack {
        PatientProfileView(patient: Patient(
            id: UUID().uuidString,
            name: "Ayush Singh",
            email: "ayush@example.com",
            age: 22,
            gender: .male,
            phone: "9876543210",
            address: "Lucknow, India"
        ))
    }
}
