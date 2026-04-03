import SwiftUI

struct BookingCardView: View {
    
    var booking: Appointment
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 16) {
            
            // MARK: - Top Section
            HStack {
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(booking.symptoms)
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    Text(booking.doctorName)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                // Status Badge
                Text(booking.status.rawValue)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color(booking.status.color).opacity(0.15))
                    .foregroundColor(Color(booking.status.color))
                    .clipShape(Capsule())
            }
            
            
            Divider()
            
            
            // MARK: - Booking Info
            VStack(alignment: .leading, spacing: 10) {
                
                HStack(spacing: 10) {
                    Image(systemName: "calendar")
                        .foregroundColor(.purple)
                    
                    Text(booking.createdAt.formatted(date: .abbreviated,
                                                           time: .shortened))
                }
                
                HStack(spacing: 10) {
                    Image(systemName: "video.fill")
                        .foregroundColor(.purple)
                    
                    Text(booking.appointmentType.rawValue)
                }
            }
            .font(.subheadline)
            .foregroundColor(.secondary)
            
            
//            // MARK: - Action Buttons
//            HStack(spacing: 12) {
//                
//                if booking.status == .completed || booking.status == .cancelled{
//                    
//                    Button("Book Again") {
//                    }
//                    .buttonStyle(PrimaryButtonStyle())
//                    
//                    
//                    Button("Leave Review") {
//                    }
//                    .buttonStyle(SecondaryButtonStyle())
//                    
//                } else {
//                    
//                    Button("Join / Directions") {
//                    }
//                    .buttonStyle(PrimaryButtonStyle())
//                    
//                    
//                    Button {
//                    } label: {
//                        Image(systemName: "trash")
//                    }
//                    .buttonStyle(DeleteButtonStyle())
//                }
//            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.05),
                        radius: 8,
                        x: 0,
                        y: 4)
        )
        .padding(.horizontal)
    }
}

struct PrimaryButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        
        configuration.label
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity)
            .padding(12)
            .background(Color.purple.opacity(configuration.isPressed ? 0.7 : 1))
            .foregroundColor(.white)
            .cornerRadius(10)
    }
}

struct SecondaryButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        
        configuration.label
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity)
            .padding(12)
            .background(Color.purple.opacity(0.1))
            .foregroundColor(.purple)
            .cornerRadius(10)
    }
}

struct DeleteButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        
        configuration.label
            .padding(12)
            .background(Color.red.opacity(0.1))
            .foregroundColor(.red)
            .cornerRadius(10)
            .opacity(configuration.isPressed ? 0.6 : 1)
    }
}

//#Preview {
//    
//    BookingCardView(
//        booking:  Booking(
//            doctorId: "DOC001",
//            doctorName: "Dr. Rahul Sharma",
//            doctorSpeciality: "Cardiologist",
//            patientId: "PAT001",
//            appointmentType: .online,
//            requestedDateTime: Date(),
//            confirmedDateTime: Date(),
//            symptoms: "Chest Pain",
//            notes: nil,
//            clinicAddress: "Apollo Clinic, Lucknow",
//            clinicPhone: "+91 9876543210",
//            clinicLat: 26.8467,
//            clinicLong: 80.9462,
//            payment: PaymentData(amount: 500, method: .gpay, isPaid: true),
//            status: .doctorAccepted
//        )
//    )
//    .padding()
//    .previewLayout(.sizeThatFits)
//}
