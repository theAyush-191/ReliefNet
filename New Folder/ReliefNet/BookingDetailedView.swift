import SwiftUI

// MARK: - Booking Models
struct BookingData: Identifiable {
    var id = UUID().uuidString
    var doctorId: String
    var patientId: String
    var date: Date
    var slot: String
    var symptoms: String
    var notes: String
    var amount: Double
    var appointmentType: AppointmentType
    var payment: PaymentData
    var status: BookingStatus
}

enum AppointmentType: String, CaseIterable {
    case online = "Online Consultation"
    case clinic = "Clinic Visit"
    case home = "Home Visit"
}

enum BookingStatus: String {
    case pending = "Pending"
    case confirmed = "Confirmed"
    case cancelled = "Cancelled"
}

struct PaymentData: Identifiable {
    var id = UUID().uuidString
    var amount: Double
    var method: PaymentMethod
    var transactionId: String?
}

enum PaymentMethod: String, CaseIterable {
    case gpay = "Google Pay / BHIM UPI"
    case phonepe = "PhonePe"
    case payAtVisit = "Pay at Visit"
}

// MARK: - Booking Detail View
struct BookingDetailView: View {
    @State private var selectedDate = Date()
    @State private var selectedSlot: String? = nil
    @State private var symptoms = ""
    @State private var notes = ""
    @State private var appointmentType: AppointmentType = .online
    @State private var showPayment = false
    
    let availableSlots = [
        "09:00 AM - 09:15 AM", "09:30 AM - 09:45 AM", "10:00 AM - 10:15 AM",
        "11:00 AM - 11:15 AM", "05:00 PM - 05:15 PM"
    ]
    
    var appointmentPrice: Double {
        switch appointmentType {
        case .online: return 300
        case .clinic: return 500
        case .home: return 800
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    // Date Picker
                    VStack(alignment: .leading) {
                        Text("Select Date").font(.headline)
                        DatePicker("Choose a date", selection: $selectedDate, displayedComponents: .date)
                            .datePickerStyle(GraphicalDatePickerStyle()).tint(Color("darkPurple"))
                    }
                    
                    // Time Slot Picker
                    VStack(alignment: .leading) {
                        Text("Select Time Slot").font(.headline)
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
                            ForEach(availableSlots, id: \.self) { slot in
                                Button(action: {
                                    selectedSlot = slot
                                }) {
                                    Text(slot)
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .background(selectedSlot == slot ? Color("darkPurple").opacity(0.8) : Color.gray.opacity(0.2))
                                        .foregroundColor(selectedSlot == slot ? .white : .black)
                                        .cornerRadius(10)
                                }
                            }
                        }
                    }
                    
                    // Appointment Type
                    VStack(alignment: .leading) {
                        Text("Appointment Type").font(.headline)
                        Picker("Select Type", selection: $appointmentType) {
                            ForEach(AppointmentType.allCases, id: \.self) { type in
                                Text(type.rawValue).tag(type)
                            }
                        }
                        .pickerStyle(.automatic).tint(Color("darkPurple"))
                    }
                    
                    // Symptoms
                    VStack(alignment: .leading) {
                        Text("Symptoms / Reason for Visit").font(.headline)
                        TextField("e.g. Fever, Cough, Headache", text: $symptoms)
                            .textFieldStyle(.roundedBorder)
                    }
                    
                    // Notes
                    VStack(alignment: .leading) {
                        Text("Additional Notes (Optional)").font(.headline)
                        TextField("Any other details for the doctor", text: $notes)
                            .textFieldStyle(.roundedBorder)
                    }
                    
                    // Price Summary
                    HStack {
                        Text("Consultation Fee:").font(.headline)
                        Spacer()
                        Text("₹\(appointmentPrice, specifier: "%.0f")")
                            .font(.title3)
                            .bold()
                    }
                    
                    // Proceed Button
                    Button(action: { showPayment = true }) {
                        Text("Proceed to Payment")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(selectedSlot != nil ? Color("darkPurple") : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .disabled(selectedSlot == nil)
                }
                .padding()
            }
            .navigationTitle("Book Appointment")
            .sheet(isPresented: $showPayment) {
                PaymentOptionView(
                    amount: appointmentPrice,
                    appointmentType: appointmentType.rawValue,
                    date: selectedDate,
                    slot: selectedSlot ?? "",
                    symptoms: symptoms,
                    notes: notes
                )
            }
        }
    }
}

// MARK: - Payment Option View
struct PaymentOptionView: View {
    var amount: Double
    var appointmentType: String
    var date: Date
    var slot: String
    var symptoms: String
    var notes: String
    
    @Environment(\.dismiss) var dismiss
    @State private var selectedMethod: PaymentMethod = .gpay
    @State private var showConfirmation = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                
                // Appointment Details
                VStack(alignment: .leading, spacing: 8) {
                    Text("Appointment Details").font(.headline)
                    HStack { Text("Date:"); Spacer(); Text(formattedDate(date)) }
                    HStack { Text("Time:"); Spacer(); Text(slot) }
                    HStack { Text("Type:"); Spacer(); Text(appointmentType) }
                    HStack { Text("Symptoms:"); Spacer(); Text(symptoms.isEmpty ? "None" : symptoms) }
                    HStack { Text("Notes:"); Spacer(); Text(notes.isEmpty ? "None" : notes) }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                
                // Payment Method
                VStack(alignment: .leading, spacing: 10) {
                    Text("Select Payment Method").font(.headline)
                    ForEach(PaymentMethod.allCases, id: \.self) { method in
                        HStack {
                            Image(systemName: selectedMethod == method ? "largecircle.fill.circle" : "circle")
                            Text(method.rawValue)
                            Spacer()
                        }
                        .contentShape(Rectangle())
                        .onTapGesture { selectedMethod = method }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                    }
                }
                
                // Amount
                HStack {
                    Text("Total Amount").font(.headline)
                    Spacer()
                    Text("₹\(amount, specifier: "%.0f")")
                        .bold()
                }
                .padding(.top)
                
                Spacer()
                
                // Confirm / Pay Button
                Button(action: { showConfirmation = true }) {
                    Text(selectedMethod == .payAtVisit ? "Confirm Booking" : "Pay & Confirm")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .alert("Appointment Confirmed", isPresented: $showConfirmation) {
                    Button("OK") { dismiss() }
                } message: {
                    Text("""
                        Your booking for \(appointmentType) is confirmed!
                        Date: \(formattedDate(date))
                        Time: \(slot)
                        Payment: \(selectedMethod.rawValue)
                        Total: ₹\(amount, specifier: "%.0f")
                        """)
                }
            }
            .padding()
            .navigationTitle("Payment")
        }
    }
    
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

// MARK: - Preview
#Preview {
    BookingDetailView()
}
