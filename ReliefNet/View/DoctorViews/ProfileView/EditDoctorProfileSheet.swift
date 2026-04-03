//
//  EditDoctorProfileView.swift
//  ReliefNet
//
//  Created by Ayush Singh on 15/10/25.
//

import SwiftUI

struct EditDoctorProfileView: View {
    @Binding var doctor: Doctor
    @Environment(\.dismiss) private var dismiss
    
    
    @State private var numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        return formatter
    }()
    
    var body: some View {
        NavigationStack {
            Form {
                // MARK: - Basic Information
                Section(header: Text("Basic Information").font(.headline)) {
                    TextField("Enter Name", text: $doctor.name)
//                    TextField("Specialization", text: $doctor.specialization)
                    TextField("Experience (e.g. 8 )",value:  $doctor.experience, formatter: numberFormatter)
                        .keyboardType(.numberPad)
                }
                
                // MARK: - About Section
                Section(header: Text("About").font(.headline)) {
                    TextEditor(text: $doctor.about)
                        .frame(height: 120)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.3))
                        )
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Edit Profile")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        dismiss()
                    }
                    .bold()
                }
            }
        }
    }
}

//#Preview {
//    // ✅ Provide a constant binding for preview
//    EditDoctorProfileView(doctor: .constant(
//        Doctor(
//            name: "Dr. Meera Sharma",
//            specialization: "Psychiatrist",
//            address: "Lucknow, Uttar Pradesh", experience: 8,
//            clinicLat: 26.8467,
//            clinicLong: 80.9462,
//            image: "doctorPic",
//            about: "Experienced psychiatrist specializing in anxiety, depression, and stress-related issues."
//        )
//    ))
//}
