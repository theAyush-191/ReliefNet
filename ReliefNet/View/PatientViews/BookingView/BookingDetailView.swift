import SwiftUI

struct BookingDetailView: View {
    @EnvironmentObject var session:UserSession
    @Environment(\.dismiss) var dismiss 
    @Binding var booking: Appointment
    @State var doctors = Doctors.doctorsData
    @State var activeSheet:ActiveSheet?
    @State var isBooking:Bool = false
    @State var navigateToBooking : Bool = false
    
    var body: some View {
        
        ScrollView {
            
            VStack(spacing: 16) {
                
                // STATUS
                HStack {
                    Text(booking.status.rawValue)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .padding(.horizontal,10)
                        .padding(.vertical,6)
                        .background(booking.status.color.opacity(0.15))
                        .foregroundColor(booking.status.color)
                        .cornerRadius(8)
                    
                    Spacer()
                }
                
                // DOCTOR INFO
                VStack(alignment:.leading,spacing:8){
                    
                    Text(booking.doctorName)
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    Text(booking.doctorSpeciality)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth:.infinity,alignment:.leading)
                
                
                Divider()
                
                
                
                // MARK: - APPOINTMENT INFO
                VStack(alignment:.leading,spacing:10){
                    
                    // Requested Time (always visible)
                    DetailRow(
                        icon:"calendar",
                        title:"Requested",
                        value: booking.requestedDateTime.formatted(date:.abbreviated,time:.shortened)
                    )
                    
                    // Confirmed Time (ONLY after acceptance)
                    if let confirmed = booking.confirmedDateTime {
                        DetailRow(
                            icon:"checkmark.calendar",
                            title:"Confirmed",
                            value: confirmed.formatted(date:.abbreviated,time:.shortened)
                        )
                    }
                    
                    DetailRow(
                        icon:"video.fill",
                        title:"Appointment Type",
                        value: booking.appointmentType.rawValue
                    )
                }
                // MARK: - RESCHEDULE HISTORY
                if !booking.proposals.isEmpty {
                    
                    Divider()
                    
                    VStack(alignment: .leading, spacing: 10) {
                        
                        Text("Reschedule History")
                            .font(.headline)
                        
                        ForEach(booking.proposals) { proposal in
                            
                            let isLatest = proposal.id == booking.proposals.last?.id
                            
                            VStack(alignment: .leading, spacing: 6) {
                                
                                HStack {
                                    
                                    Text(proposal.proposedBy == .doctor ? "Doctor Proposed" : "You Proposed")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.purple)
                                    
                                    Spacer()
                                    
                                    Text(proposal.dateTime.formatted(date: .abbreviated, time: .shortened))
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                
                                if let reason = proposal.reason {
                                    Text(reason)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding(10)
                            .background(isLatest ? Color.purple.opacity(0.15) : Color.gray.opacity(0.08))
                            .cornerRadius(10)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                
                Divider()
                
                
                // SYMPTOMS
                VStack(alignment:.leading,spacing:6){
                    
                    Text("Symptoms")
                        .font(.headline)
                    
                    Text(booking.symptoms)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth:.infinity,alignment:.leading)
                
                
                Divider()
                
                // NOTES
                if let note = booking.patientNotes{
                    VStack(alignment:.leading,spacing:6){
                        
                        Text("Notes")
                            .font(.headline)
                        
                        Text(note)
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth:.infinity,alignment:.leading)
                    
                    
                    Divider()
                }
                
                
                
                
                // CLINIC DETAILS
                VStack(alignment:.leading,spacing:10){
                    
                    Text(booking.appointmentType.displayTitle)
                        .font(.headline)
                    
                    if booking.appointmentType == .online {
                        Text("This is an online consultation. Contact clinic for further details.")
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity)
                            .padding(12)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                    }else if let address = booking.appointmentAddress  {
                        DetailRow(icon:"mappin.and.ellipse",
                                  title:"Address",
                                  value: address)
                    }
                    
                    DetailRow(icon:"phone.fill",
                              title:"Clinic Number",
                              value: booking.clinicPhone)
                }
                
                
                Divider()
                
                
                // PAYMENT
                VStack(alignment:.leading,spacing:10){
                    Text("Payment")
                        .font(.headline)
                    
                    DetailRow(icon:"creditcard",
                              title:"Amount",
                              value:"₹\(booking.payment.amount)")
                    
                    //                    DetailRow(icon:"wallet.pass",
                    //                              title:"Method",
                    //                              value:booking.pay)
                }
                
                
                // MARK: - REVIEW DETAILS
                if let review = SampleReviews.reviews.first(where: {$0.bookingId == booking.id.uuidString }) {
                    
                    Divider()
                    
                    ReviewCardView(review:review)
                }

                // MARK: - CANCELLATION DETAILS
                if let cancellation = booking.cancellation {
                    Divider()
                    
                    VStack(alignment: .leading, spacing: 10) {

                        Text("Cancellation Details")
                            .font(.headline)
                            .foregroundColor(.red)

                        VStack(alignment: .leading, spacing: 6) {

                            Text("Cancelled By: \(cancellation.cancelledBy.rawValue)")
                                .font(.subheadline)
                                .fontWeight(.semibold)

                            Text("Reason: \(cancellation.reason)")
                                .font(.subheadline)
                                .foregroundColor(.gray)

                            Text("Cancelled At: \(cancellation.cancelledAt.formatted(date: .abbreviated, time: .shortened))")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .background(Color.red.opacity(0.08))
                        .cornerRadius(12)
                        .frame(maxWidth: .infinity)
                    }
                }
                
                if booking.status == .upcoming || booking.status == .completed { 
                    Divider()
                VStack(alignment: .leading, spacing: 10) {
                    
                    Text("Booking Code")
                        .font(.headline)
                    
                    HStack {
                        Text(booking.bookingCode)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.purple)
                        
                        Spacer()
                        
                        Button {
                            UIPasteboard.general.string = booking.bookingCode
                        } label: {
                            Image(systemName: "doc.on.doc")
                                .foregroundColor(.purple)
                        }
                    }
                    .padding()
                    .background(Color.purple.opacity(0.1))
                    .cornerRadius(12)
                    
                    // Always visible description
                    Text("At the start of your appointment, show this Booking Code to your doctor for verification.")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
                
                //Map View
                
                ActionButtonView(bookingData:$booking,isBooking: $isBooking,activeSheet:$activeSheet, dismiss: $navigateToBooking)
                
            }
            .padding()
        }
        .navigationTitle("Booking Details")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(item: $activeSheet) { sheet in
            BookingActionFlowView(type: sheet, bookingDetail: $booking,navigateToBooking: $navigateToBooking).environmentObject(session)
        }.navigationDestination(isPresented: $isBooking) {
            if let index = doctors.firstIndex(where: {$0.id == booking.doctorId}){
                DoctorDetailView(data: $doctors[index])
                
            }else {
                Text("Doctor not found")
            }
        }.onChange(of: navigateToBooking) { oldValue, newValue in
            if newValue == true {
                dismiss()
            }
        }
    }
}

enum ActiveSheet:CaseIterable,Identifiable{
    case join
    case cancel
    case reschedule
    case review
    
    var id : Int{
        hashValue
    }
}


struct ReviewCardView:View{
    var review:Review
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10) {

            Text("Your Review")
                .font(.headline)

            HStack {

                ForEach(0..<5) { index in
                    Image(systemName: index < review.rating ? "star.fill" : "star")
                        .foregroundColor(.yellow)
                }

                Spacer()

                Text(review.createdAt.formatted(date: .abbreviated, time: .shortened))
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            Text(review.comment)
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.top, 4)

        }
        .padding()
        .background(Color.yellow.opacity(0.08))
        .cornerRadius(12)
    }
    
}

struct ActionButtonView:View{
    
    @Binding var bookingData:Appointment
    @Binding var isBooking:Bool
    @Binding var activeSheet:ActiveSheet?
    @Binding var dismiss:Bool
    
    @ViewBuilder
    var body : some View{
        // ACTION BUTTONS
        
//        Group{
            switch bookingData.status {
            

            case .awaitingPatient:
                VStack(spacing: 10) {
                    
                    HStack(spacing: 10) {
                        
                        BookingActionButton(
                            title: "Reschedule",
                            style: .accent
                        ) {
                            activeSheet = .reschedule
                        }
                        
                        BookingActionButton(
                            title: "Cancel",
                            style: .destructive
                        ) {
                            activeSheet = .cancel
                        }
                    }
                    
                    BookingActionButton(
                        title: "Accept Booking",
                        style: .success
                    ) {
                        acceptProposedTime()
                    }
                }
                
            case .awaitingDoctor :
                VStack(spacing: 10) {
                    
                    HStack(spacing: 10) {
                        
                        BookingActionButton(
                            title: "Reschedule",
                            style: .accent
                        ) {
                            activeSheet = .reschedule
                        }
                        
                        BookingActionButton(
                            title: "Cancel Booking",
                            style: .destructive
                        ) {
                            activeSheet = .cancel
                        }
                    }
                    
                    BookingActionButton(
                        title: "Accept Booking",
                        style: .success
                    ) {
                        acceptProposedTime()
                    }
                    
                }
            case .upcoming:
                VStack(spacing: 10) {
                    
                    BookingActionButton(
                        title: bookingData.appointmentType == .online
                            ? "Join Consultation"
                            : "Get Directions",
                        style: .primary
                    ) {
                        activeSheet = .join
                    }
                    
                    BookingActionButton(
                        title: "Cancel Booking",
                        style: .destructive
                    ) {
                        activeSheet = .cancel
                    }
                }
            case .cancelled:
                HStack(spacing:12){
                    BookingActionButton(
                        title: "Book Again",
                        style: .secondary
                    ) {
                        isBooking = true
                    }
                }
                
            case .completed:
                HStack(spacing:12){
                    
                    
                    BookingActionButton(
                        title: "Leave Review",
                        style: .info
                    ) {
                        activeSheet = .review
                    }
                    
                    BookingActionButton(
                        title: "Book Again",
                        style: .secondary
                    ) {
                        isBooking = true
                    }
                }
                
            default:
              EmptyView()
            }

    }
    
    func acceptProposedTime() {
        
        let lastDoctorProposal = bookingData.proposals.last { $0.proposedBy == .doctor }
        
        guard let proposal = lastDoctorProposal else { return }
        
        bookingData.confirmedDateTime = proposal.dateTime
        bookingData.proposals.removeAll()
        bookingData.status = .upcoming
        dismiss = true
    }
}

extension AppointmentType{
    var displayTitle:String{
        switch self {
        case .online:
            "Online Consultation"
        case .clinic:
            "Clinic Details"
        case .home:
            "Appointment Details"
        }
    }
    
    var mapTitle:String{
        switch self {
        case .online:
            ""
        case .clinic:
            "Clinic Location"
        case .home:
            "Your Location"
        }
    }
}
//#Preview {
//    let sample:Booking=Booking(
//        doctorId: "DOC001",
//        doctorName: "Dr. Rahul Sharma",
//        doctorSpeciality: "Cardiologist",
//        patientId: "PAT001",
//        appointmentType: .online,
//        requestedDateTime: Date(),
//        confirmedDateTime: Date(),
//        symptoms: "Chest Pain",
//        notes: nil,
//        clinicAddress: "Apollo Clinic, Lucknow",
//        clinicPhone: "+91 9876543210",
//        clinicLat: 26.8467,
//        clinicLong: 80.9462,
//        payment: PaymentData(amount: 500, method: .gpay, isPaid: true),
//        status: .doctorAccepted
//    )
//    NavigationStack {
//        BookingDetailView(booking: sample)
//    }
//}
