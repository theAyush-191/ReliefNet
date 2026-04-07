//
//  EditPatientProfileSheet.swift
//  ReliefNet
//
//  Created by Ayush Singh on 17/10/25.
//

import SwiftUI

struct EditPatientProfileSheet: View {
    
    @Binding var data: Patient
    @State var name:String = ""
    @State var age:Int = 0
    @State var gender:Gender = .male
    @State var number:String = ""
    @State var address:String = ""
    @State var lat : Double = 0.0
    @State var long : Double = 0.0
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {

            Form {
                
                // MARK: - Profile Image
                Section {
                    HStack {
                        Spacer()
                        
                        Image(data.imageURL)
                            .resizable()
                            .frame(width: 90, height: 90)
                            .clipShape(Circle())
                        
                        Spacer()
                    }
                }
                
                // MARK: - Basic Info
                Section("Basic Information") {
                    
                    TextField("Full Name", text: $name)
                    
                    TextField("Age", value: $age, format: .number)
                        .keyboardType(.numberPad)
                    
                    Picker("Gender", selection: $gender) {
                        ForEach(Gender.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                }
                
                // MARK: - Contact
                Section("Contact Information") {
                    
                    TextField("Phone Number", text: $number)
                        .keyboardType(.phonePad)
                    
                    // Email (Read Only)
                    HStack {
                        Text("Email")
                        Spacer()
                        Text(data.email)
                            .foregroundColor(.gray)
                            .font(.subheadline)
                    }
                }
                
                // MARK: - Address
                Section("Address") {
                    
                    NavigationLink(
                        destination: LocationView(
                            addressText: $address,
                            latitude: $lat,
                            longitude: $long
                        )
                    ) {
                        HStack(spacing: 12) {
                            
                            Image(systemName: "map.fill")
                                .foregroundColor(.purple)
                                .font(.title3)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                
                                Text("Location")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                
                                Text(address.isEmpty ? "Tap to select location" : address)
                                    .foregroundColor(address.isEmpty ? .gray : .primary)
                                    .lineLimit(2)
                            }
                            
                            Spacer()
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                    }
                }
            }
            .navigationTitle("Edit Profile")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear{
                name = data.name
                age = data.age
                gender = data.gender
                number = data.phone
                
                if let add = data.address, let latitude = data.addressLat, let longitude = data.addressLong {
                    address = add
                    lat = latitude
                    long  = longitude
                }
                
            }
            
            // MARK: - Toolbar
            .toolbar {
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveData()
                        dismiss()
                    }
                    .bold()
                    .disabled(name.isEmpty || number.isEmpty)
                }
            }
//        }
    }
    
    func saveData(){
        data.name = name
        data.age = age
        data.gender = gender
        data.phone = number
        data.address = address.isEmpty ? nil : address
        data.addressLat = lat
        data.addressLong = long
    }
}

#Preview {
    EditPatientProfileSheet(data: .constant(Patient(
        id: UUID().uuidString,
        name: "Ayush Singh",
        email: "ayush@example.com",
        age: 22,
        gender: .male,
        phone: "9876543210",
        address: "Lucknow, India"
    )
    )
    )
}
