//
//  PatientProfile.swift
//  ReliefNet
//
//  Created by Ayush Singh on 16/10/25.
//

import SwiftUI

struct PatientProfileView: View {
    
    @State var patient: Patient
    @State private var showingEditProfile = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    
                    // MARK: - Header
                    VStack {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 120, height: 120)
                            .foregroundColor(.blue)
                            .padding(.top)
                        
                        Text(patient.name)
                            .font(.title2.bold())
                        
                        Text(patient.email)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                    Divider()
                    
                    // MARK: - Stats
                    HStack(spacing: 30) {
                        VStack {
                            Text("\(patient.totalBookings)")
                                .font(.title2.bold())
                            Text("Bookings")
                                .font(.caption)
                        }
                        VStack {
                            Text("\(patient.age)")
                                .font(.title2.bold())
                            Text("Age")
                                .font(.caption)
                        }
                        VStack {
                            Text(patient.gender)
                                .font(.title2.bold())
                            Text("Gender")
                                .font(.caption)
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(15)
                    .padding(.horizontal)
                    
                    // MARK: - Contact Info
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Contact Information")
                            .font(.headline)
                        
                        HStack {
                            Image(systemName: "phone.fill")
                            Text(String(patient.phone))
                        }
                        
                        HStack {
                            Image(systemName: "house.fill")
                            Text(patient.address)
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(.systemGray6))
                    .cornerRadius(15)
                    .padding(.horizontal)
                    
                    // MARK: - Recent Doctor Section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Recently Visited Doctor")
                            .font(.headline)
                        
//                        if let doctor = patient.lastVisitedDoctor {
//                            HStack {
//                                Image(systemName: "stethoscope")
//                                VStack(alignment: .leading) {
////                                    Text(doctor)
////                                        .font(.subheadline.bold())
////                                    Text(doctor.specialization)
////                                        .font(.caption)
////                                        .foregroundColor(.gray)
//                                }
//                            }
//                        } else {
//                            Text("No recent visit.")
//                                .font(.subheadline)
//                                .foregroundColor(.gray)
//                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(.systemGray6))
                    .cornerRadius(15)
                    .padding(.horizontal)
                    
                    Spacer()
                }
                .padding(.bottom, 20)
            }
            .navigationTitle("Patient Profile")
            .toolbar {
                Button(action: {
                    showingEditProfile.toggle()
                }){Label("Edit", systemImage: "square.and.pencil")}
            }
            .sheet(isPresented: $showingEditProfile) {
                EditPatientProfileSheet(
                    data:$patient
                )
            }
        }
    }
}

#Preview {
    PatientProfileView(patient: Patient(
        name: "Ayush Singh",
        email: "ayush@example.com",
        age: 22,
        gender: "Male",
        phone: "9876543210",
        address: "Lucknow, India",
        totalBookings: 5,

    ))
}


