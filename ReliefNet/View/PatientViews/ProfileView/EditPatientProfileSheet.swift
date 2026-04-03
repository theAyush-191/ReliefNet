//
//  EditPatientProfileSheet.swift
//  ReliefNet
//
//  Created by Ayush Singh on 17/10/25.
//

import SwiftUI

struct EditPatientProfileSheet: View {
    @Binding var data :Patient
    
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
                    TextField("Enter Name", text: $data.name)
                    TextField("Age (e.g. 8 )",value:  $data.age
                              , formatter: numberFormatter
                    )
                        .keyboardType(.numberPad)
                    
//                    TextField("Age (e.g. 8 )",text:$data.age)
                    
                    Picker("Gender", selection: $data.gender) {
                        Text("Male")
                        Text("Female")
                        Text("Others")
                    }
                    
                    TextField("Address", text: $data.address)
                    
                }
                
                // MARK: - About Section
                Section(header: Text("Contact Information").font(.headline)) {
                    TextField("Email (e.g. xyz@gmail.com)", text: $data.email)
                        .keyboardType(.emailAddress)
                    TextField("Age (e.g. 8 )",value:  $data.phone, formatter: numberFormatter)
                        .keyboardType(.numberPad)
                    
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

#Preview {
    EditPatientProfileSheet(data: .constant(Patient(
        name: "Ayush Singh",
        email: "ayush@example.com",
        age: 22,
        gender: "Male",
        phone: "9876543210",
        address: "Lucknow, India",
        totalBookings: 5,
        
    )
    )
    )
}
