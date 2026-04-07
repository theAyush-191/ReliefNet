//
//  BookingActionFLowView.swift
//  ReliefNet
//
//  Created by Ayush Singh on 27/03/26.
//

import SwiftUI

struct BookingActionFlowView: View {
    var type : ActiveSheet?
    @Binding var bookingDetail : Appointment
    @Binding var navigateToBooking : Bool
    var body: some View {
        switch type{
        case .cancel:
            CancelBookingView(booking: $bookingDetail, navigateToBooking: $navigateToBooking)
        case .join:
            JoinConsultaionBookingView(detail: $bookingDetail)
        case .reschedule:
            // In Combine Views Folder
            RescheduleBookingView(detail: $bookingDetail)
        case .review:
            ReviewBookingView(booking: $bookingDetail, navigateToBooking: $navigateToBooking)
        default : EmptyView()
        }
    }
}

struct JoinConsultaionBookingView: View {
    @Binding var detail: Appointment
    
    var screenTitle: String {
        switch detail.appointmentType {
        case .online: return "Join Consultation"
        case .clinic: return "Get Directions"
        case .home: return "Home Visit Details"
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                
                // MARK: - TOP INFO CARD
                VStack(spacing: 0) {
                    Text(screenTitle)
                        .font(.headline)
                        .padding(.vertical, 12)
                        .frame(maxWidth: .infinity)
                        .background(Color.purple.opacity(0.1))
                        .foregroundColor(.purple)
                    
                    Group {
                        if detail.appointmentType == .online {
                            onlineView
                        } else if detail.appointmentType == .clinic {
                            clinicView
                        } else if detail.appointmentType == .home {
                            homeView
                        }
                    }
                    .padding(.vertical, 20)
                    .padding(.horizontal, 16)
                }
                .background(Color(.secondarySystemGroupedBackground))
                .cornerRadius(16)
                .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)
                
                // MARK: - MAP SECTION
                if detail.appointmentType != .online {
                    if let lat = detail.addressLat, let long = detail.addressLong {
                        VStack(alignment: .leading, spacing: 16) {
                            
                            // Section Header
                            HStack(spacing: 12) {
                                Image(systemName: detail.appointmentType == .home ? "house.fill" : "building.2.fill")
                                    .foregroundColor(.purple)
                                    .font(.system(size: 14, weight: .bold))
                                    .padding(8)
                                    .background(Color.purple.opacity(0.1))
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(detail.appointmentType == .home ? "Your Home" : "Clinic Location")
                                        .font(.subheadline)
                                        .fontWeight(.bold)
                                    Text(detail.appointmentType == .home ? "Doctor will arrive here" : "Navigate to this address")
                                        .font(.caption2)
                                        .foregroundColor(.secondary)
                                }
                            }
                            .padding(.horizontal, 4)

                            MapView(doctorName: detail.appointmentType.mapTitle, lat: lat, long: long)
                                .frame(height: 400) // 400 is usually the sweet spot for detail maps
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.gray.opacity(0.1), lineWidth: 1)
                                )
                        }
                    } else {
                        ContentUnavailableView("Location Unavailable", systemImage: "map.badge.xmark", description: Text("Coordinate data is missing for this booking."))
                    }
                }
                
                Spacer(minLength: 40)
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
        .navigationTitle("Appointment")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Subviews (Kept clean)
    
    var onlineView: some View {
        VStack(spacing: 12) {
            Image(systemName: "video.circle.fill")
                .font(.system(size: 60))
                .foregroundStyle(.purple.gradient)
            
            VStack(spacing: 4) {
                Text("Scheduled for")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(detail.displayDateTime.formatted(date: .abbreviated, time: .shortened))
                    .font(.title3)
                    .bold()
            }
            
            Text("Doctor will contact you via phone or video call.")
                .font(.footnote)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
            
            Button(action: callDoctor) {
                Label("Call Clinic", systemImage: "phone.fill")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .tint(.purple)
            .padding(.top, 8)
        }
    }
    
    var clinicView: some View {
        VStack(spacing: 12) {
            Image(systemName: "mappin.and.ellipse.circle.fill")
                .font(.system(size: 60))
                .foregroundStyle(.blue.gradient)
            
            VStack(spacing: 4) {
                Text("Clinic Address")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(detail.appointmentAddress ?? "Address not available")
                    .font(.body)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
            }
            
            Button(action: openMaps) {
                Label("Open in Maps", systemImage: "location.fill")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
        }
    }
    
    var homeView: some View {
        VStack(spacing: 12) {
            Image(systemName: "house.circle.fill")
                .font(.system(size: 60))
                .foregroundStyle(.green.gradient)
            
            VStack(spacing: 8) {
                Text("Doctor visiting your location")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                Text(detail.appointmentAddress ?? "Not available")
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
            
            Divider().padding(.horizontal)
            
            HStack {
                Text("Expected Arrival:")
                    .font(.caption)
                Text(detail.displayDateTime.formatted(date: .omitted, time: .shortened))
                    .font(.caption)
                    .bold()
            }
            .foregroundColor(.purple)
        }
    }

    // MARK: - Helpers
    func callDoctor() {
           if let url = URL(string: "tel://\(detail.clinicPhone)") {
               UIApplication.shared.open(url)
           }
       }
       
       func openMaps() {
           guard let lat = detail.addressLat,
                 let long = detail.addressLong else { return }
           
           let url = URL(string: "http://maps.apple.com/?ll=\(lat),\(long)")!
           UIApplication.shared.open(url)
       }
}


struct CancelBookingView: View {
    
    @Binding var booking: Appointment
    @Environment(\.dismiss) var dismiss
    @Binding var navigateToBooking : Bool
    
    // MARK: - State
    @State private var selectedReason: String = ""
    @State private var customReason: String = ""
    @State private var isCancelling: Bool = false
    
    let reasons = [
        "Change of plans",
        "Found another doctor",
        "Feeling better",
        "Doctor unavailable",
        "Other"
    ]
    
    var isFormValid: Bool {
        if selectedReason == "Other" {
            return !customReason.trimmingCharacters(in: .whitespaces).isEmpty
        }
        return !selectedReason.isEmpty
    }
    
    var body: some View {
            
            VStack(spacing: 20) {
                
                // MARK: - Title
                VStack(spacing: 8) {
                    Text("Cancel Appointment")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("Please tell us why you are cancelling")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.top)
                
                
                // MARK: - Reasons List
                VStack(spacing: 12) {
                    
                    ForEach(reasons, id: \.self) { reason in
                        
                        HStack {
                            
                            Text(reason)
                                .foregroundColor(.black)
                            
                            Spacer()
                            
                            if selectedReason == reason {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.purple)
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(selectedReason == reason ? Color.purple.opacity(0.1) : Color(.systemBackground))
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(selectedReason == reason ? Color.purple : Color.gray.opacity(0.2))
                        )
                        .onTapGesture {
                            selectedReason = reason
                        }
                    }
                }
                
                
                // MARK: - Custom Reason
                if selectedReason == "Other" {
                    
                    TextField("Enter your reason...", text: $customReason)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                }
                
                
                Spacer()
                
                
                // MARK: - Buttons
                VStack(spacing: 12) {
                    
                    Button {
                        cancelBooking()
                    } label: {
                        if isCancelling {
                            ProgressView()
                                .frame(maxWidth: .infinity)
                                .padding()
                        } else {
                            Text("Confirm Cancellation")
                                .frame(maxWidth: .infinity)
                                .padding()
                        }
                    }
                    .background(isFormValid ? Color.red : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .disabled(!isFormValid || isCancelling)
                    
                    
                    Button("Keep Booking") {
                        dismiss()
                    }
                    .foregroundColor(.purple)
                }
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
        
    }
    
    
    // MARK: - Cancel Logic
    func cancelBooking() {
        
        isCancelling = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            
            // You can store reason later in Firebase
            let finalReason = selectedReason == "Other" ? customReason : selectedReason
            print("Cancelled with reason: \(finalReason)")
            
            booking.cancellation = CancellationInfo(
                cancelledBy: .patient,
                reason: finalReason,
                cancelledAt: Date()
            )
            withAnimation {
                booking.status = .cancelled
            }
            
            isCancelling = false
            navigateToBooking = true
            dismiss()
        }
    }
}


struct ReviewBookingView: View {
    
    @Binding var booking: Appointment
    @Environment(\.dismiss) var dismiss
    @Binding var navigateToBooking : Bool
    
    // MARK: - State
    @State private var rating: Int = 0
    @State private var reviewText: String = ""
    @State private var isSubmitting: Bool = false
    
    var isFormValid: Bool {
        rating > 0
    }
    
    var body: some View {
        
        NavigationStack {
            
            VStack(spacing: 20) {
                
                // MARK: - Header
                VStack(spacing: 8) {
                    Text("Rate Your Experience")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("How was your consultation with \(booking.doctorName)?")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                }
                .padding(.top)
                
                
                // MARK: - Star Rating
                HStack(spacing: 12) {
                    
                    ForEach(1...5, id: \.self) { index in
                        
                        Image(systemName: index <= rating ? "star.fill" : "star")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .foregroundColor(index <= rating ? .yellow : .gray)
                            .onTapGesture {
                                rating = index
                            }
                    }
                }
                .padding(.vertical, 10)
                
                
                // MARK: - Rating Label
                Text(ratingText)
                    .font(.headline)
                    .foregroundColor(.purple)
                
                
                // MARK: - Review Text
                TextEditor(text: $reviewText)
                    .frame(height: 120)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray.opacity(0.2))
                    )
                
                
                Spacer()
                
                
                // MARK: - Submit Button
                Button {
                    submitReview()
                } label: {
                    if isSubmitting {
                        ProgressView()
                            .frame(maxWidth: .infinity)
                            .padding()
                    } else {
                        Text("Submit Review")
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                }
                .background(isFormValid ? Color.purple : Color.gray)
                .foregroundColor(.white)
                .cornerRadius(12)
                .disabled(!isFormValid || isSubmitting)
                
                
                // MARK: - Cancel Button
                Button("Skip") {
                    dismiss()
                }
                .foregroundColor(.gray)
                
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    // MARK: - Rating Text
    var ratingText: String {
        switch rating {
        case 1: return "Very Bad"
        case 2: return "Bad"
        case 3: return "Okay"
        case 4: return "Good"
        case 5: return "Excellent"
        default: return "Tap to rate"
        }
    }
    
    // MARK: - Submit Logic
    func submitReview() {
        
        isSubmitting = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            let id = booking.id
            let review = Review(
                id: UUID().uuidString,
                doctorId: booking.doctorId,
                patientId: booking.patientId,
                patientName: booking.patientName,
                bookingId: id.uuidString,
                rating: rating,
                comment: reviewText,
                createdAt: Date()
            )
            
            if let index = SampleReviews.reviews.firstIndex(where: {$0.bookingId == id.uuidString}){
                SampleReviews.reviews[index] = review
            }else{
                SampleReviews.reviews.append(review)
            }
            print("Review Submitted:", review)
            
            // TODO: Send to Firebase
            
            isSubmitting = false
//            navigateToBooking = true
            dismiss()
        }
    }
}

//struct RescheduleBookingView : View {
//    @Binding var detail : Appointment
//    var body : some View{
//        
//    }
//}



//#Preview {
//    BookingActionFLowView()
//}
