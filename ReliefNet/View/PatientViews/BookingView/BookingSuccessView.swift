//
//  BookingRequestView.swift
//  ReliefNet
//
//  Created by Ayush Singh on 13/03/26.
//
import SwiftUI

struct BookingRequestView: View {
    @Environment(\.dismiss) var dismiss
    
    var booking: Appointment
    
    var requestedDate:String{
        booking.requestedDateTime.formatted(date: .abbreviated, time: .omitted)
    }
    var requestedTime:String{
        booking.requestedDateTime.formatted(date: .omitted, time: .standard)
    }
    
    @State var continuePressed:Bool = false
    
    var body: some View {
            
            ScrollView {
                
                VStack(alignment: .leading, spacing: 20) {
                    
                    // MARK: Success Header
                    
                    VStack(spacing: 10) {
                        
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.green)
                        
                        Text("Appointment Request Sent")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text("Doctor will confirm your appointment shortly")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    
                    
                    // MARK: Doctor Info
                    
                    VStack(alignment: .leading, spacing: 10) {
                        
                        Text("Doctor")
                            .font(.headline)
                        
                        HStack(spacing: 15) {
                            
                            Image("doctorPic")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 60, height: 60)
                                .clipShape(Circle())
                            
                            VStack(alignment: .leading) {
                                
                                Text(booking.doctorName)
                                    .font(.headline)
                                
                                Text(booking.doctorSpeciality)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer()
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)
                    
                    
                    // MARK: Appointment Details
                    
                    VStack(alignment: .leading, spacing: 15) {
                        
                        Text("Appointment Details")
                            .font(.headline)
                        
                        DetailRow(
                            title: "Requested Date",
                            value: requestedDate
                        )
                        
                        DetailRow(
                            title: "Requested Time",
                            value: requestedTime
                        )
                        
                        DetailRow(
                            title: "Consultation Type",
                            value: booking.appointmentType.rawValue
                        )
                        
                        DetailRow(
                            title: "Booking Status",
                            value: booking.status.rawValue
                        )
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)
                    
                    
                    // MARK: Patient Details
                    
                    VStack(alignment: .leading, spacing: 15) {
                        
                        Text("Patient Information")
                            .font(.headline)
                        
                        DetailRow(
                            title: "Symptoms",
                            value: booking.symptoms.isEmpty ? "Not provided" : booking.symptoms
                        )
                        
                        if let note = booking.patientNotes{
                            DetailRow(
                                title: "Notes",
                                value: note
                            )
                        }else{
                            DetailRow(
                                title: "Notes",
                                value: "None"
                            )
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)
                    
                    
                    // MARK: Payment
                    
                    VStack(alignment: .leading, spacing: 15) {
                        
                        Text("Payment Details")
                            .font(.headline)
                        
                        DetailRow(
                            title: "Consultation Fee",
                            value: "₹ \(Int(booking.payment.amount))"
                        )
                        
                        if let address = booking.appointmentAddress{
                            DetailRow(
                                title: "Appointment Location",
                                value: address
                            )
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)
                    
                    
                    Spacer()
                    
                    Button("Continue") {
                        dismiss()
                        dismiss()
//                        continuePressed = true
                    }.buttonStyle(.borderedProminent).background(Color(.customPink)).frame(maxWidth: .infinity,alignment: .center)
                }
                .padding()
                .navigationDestination(isPresented: $continuePressed) {
                    BookingHistoryView()
                }
            }
            .navigationTitle("Booking Request")
            .navigationBarBackButtonHidden(true)
        
    }
}

//#Preview {
//    
//    BookingRequestView(
//        booking: Booking(
//            
//            doctorId: "doc001",
//            doctorName: "Dr. Rahul Verma",
//            doctorSpeciality: "Therapist",
//            
//            patientId: "pat001",
//            
//            appointmentType: .clinic,
//            
//            requestedDateTime: Date(),
//            confirmedDateTime: nil,
//            
//            symptoms: "Headache and fever",
//            notes: "Feeling weak since yesterday",
//            
//            clinicAddress: "Lucknow Clinic",
//            clinicPhone: "9876543210",
//            clinicLat: 26.8467,
//            clinicLong: 80.9462,
//            payment: PaymentData(
//                amount: 500,
//                method: .payAtVisit,
//                transactionId: nil,
//                isPaid: false
//            ),
//            
//            status: .requestSent
//        )
//    )
//}
