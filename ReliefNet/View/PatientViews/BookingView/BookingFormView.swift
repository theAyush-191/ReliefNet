import SwiftUI

// MARK: - Booking Detail View

struct BookingFormView: View {
//    @Environment(\.dismiss) var dismiss

//    var doctorName: String = "Dr. Rahul Verma"
//    var doctorSpeciality: String = "Therapist & Counsellor"
    
    @State var patientName:String = ""
    @State var patientAge:Int = 0
    @State var patientGender: Gender = .male

    @State private var selectedDate = Date()
    @State private var selectedTime = Date()
    @State private var symptoms = ""
    @State private var notes = ""
    
    

    @State private var showRequestAlert = false
    @State private var showInvalidTimeAlert = false
    
    @State private var requestBooking:Bool = false

    @Binding var doctorData : Doctor
    
    let clinicOpenHour = 9
    let clinicCloseHour = 18
    
    @State var address: String = ""
    @State var latitude: Double = 0.0
    @State var longitude: Double = 0.0

    var isValid : Bool{
        let basicValid = !symptoms.isEmpty && !patientName.isEmpty && patientAge>0
        
        if appointmentType.requiresLocation{
            
            return basicValid && !address.isEmpty && latitude>0.0 && longitude>0.0
        }
        
        return basicValid
    }
    
    @State var appointmentDetail:Appointment?
    
    var availableOptions :[ConsultationOption]{ doctorData.consultationOptions.filter({$0.isEnabled})}
    
    @State private var appointmentType: AppointmentType = .clinic
    
    var selectedOption : ConsultationOption? { doctorData.consultationOptions.first{$0.mode == appointmentType}}
    
    var appointmentPrice: Double {
        Double(selectedOption?.price ?? 0)
    }

    var body: some View {


            ScrollView {

                VStack(alignment: .leading, spacing: 20) {
                    
                    // MARK: Doctor Header
                    DoctorHeaderView(
                        name: doctorData.name,
                        speciality: doctorData.category.rawValue
                    )
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Patient Name")
                            .font(.headline)
                        TextField("Enter Patient's Name", text: $patientName)
                            .textFieldStyle(.roundedBorder)
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Patient Age")
                            .font(.headline)
                        
                        TextField("Enter age", value: $patientAge, format: .number)
                            .keyboardType(.numberPad)
                            .textFieldStyle(.roundedBorder)
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Patient Gender")
                            .font(.headline)
                        
                        Picker("Patient Gender", selection: $patientGender) {
                            ForEach(Gender.allCases , id:\.self){gender in
                                Text(gender.rawValue).tag(gender)
                            }
                        }.pickerStyle(.menu)
                            .tint(.black)
                    }
                    
                    // MARK: Date Selection
                    VStack(alignment: .leading, spacing: 8) {
                        
                        Text("Select Preferred Date")
                            .font(.headline)
                        
                        DatePicker(
                            "Choose date",
                            selection: $selectedDate,
                            displayedComponents: .date
                        )
                        .datePickerStyle(.graphical)
                        .tint(Color("darkPurple"))
                    }
                    
                    // MARK: Preferred Slot
                    VStack(alignment: .leading, spacing: 8) {
                        
                        Text("Preferred Time")
                            .font(.headline)
                        
                        Text("Doctor may adjust based on availability")
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        
                        DatePicker("Select Time", selection: $selectedTime, displayedComponents:.hourAndMinute).datePickerStyle(.compact).labelsHidden().tint(Color("darkPurple"))
                        
                        
                        
                    }
                    
                    
                    
                    // MARK: Appointment Type
                    VStack(alignment: .leading, spacing: 8) {
                        
                        Text("Consultation Type")
                            .font(.headline)
                        
                        Picker(
                            "Type",
                            selection: $appointmentType
                        ) {
                            
                            ForEach(
                                availableOptions
                            ) { option in
                                
                                Text(option.mode.rawValue)
                                    .tag(option.mode)
                            }
                        }
                        .pickerStyle(.menu)
                        .tint(.black)
                    }
                    
                    // MARK: Symptoms
                    VStack(alignment: .leading, spacing: 8) {
                        
                        Text("Symptoms")
                            .font(.headline)
                        
                        TextField(
                            "Fever, headache, anxiety etc",
                            text: $symptoms
                        )
                        .textFieldStyle(.roundedBorder)
                    }
                    
                    // MARK: Notes
                    VStack(alignment: .leading, spacing: 8) {
                        
                        Text("Additional Notes")
                            .font(.headline)
                        
                        TextField(
                            "Optional details for doctor",
                            text: $notes
                        )
                        .textFieldStyle(.roundedBorder)
                    }
                    
                    if appointmentType.requiresLocation{
                    
                                            VStack(alignment: .leading, spacing: 8) {
                                                Text("Choose your location for Home Visit")
                                                    .font(.headline)
                                                
                                                Spacer()
                                                
                                                Text(address.isEmpty ? "N/A (Add Location)":address)
                                                    .font(.subheadline)
                                                    .bold()
                                            }
                                        }
                    
                    
                    // MARK: Fee Summary
                    
                    HStack {
                        
                        Text("Consultation Fee")
                            .font(.headline)
                        
                        Spacer()
                        
                        Text("₹\(selectedOption?.price ?? 0)")
                            .font(.title3)
                            .bold()
                    }
                    
                    FormActionButtonView(isValid: isValid, appointmentType: $appointmentType, address: $address, latitude: $latitude, longitude: $longitude,onSubmit: sendBookingRequest)
                    
                    

                }
                .padding()
            }

            .navigationTitle("Appointment Request")
            
            .alert("Invalid Time", isPresented: $showInvalidTimeAlert) {
                       Button("OK", role: .cancel) { }
                   } message: {
                       Text("Please select a time between \(clinicOpenHour):00 and \(clinicCloseHour):00")
                   }
            
            .alert(
                "Request Sent",
                isPresented: $showRequestAlert
            ) {

                Button("OK") {}

            } message: {

                Text("""
                Your appointment request has been sent.
                Doctor will confirm the time shortly.
                """)
            }
            .navigationDestination(isPresented: $requestBooking) {
                if let appointment = appointmentDetail{
                    BookingRequestView(booking: appointment)
                }
            }.onAppear {
                if let first = availableOptions.first {
                    appointmentType = first.mode
                }
            }
        
    }
    
    func isValidTime(_ date:Date)->Bool{
        let hour = Calendar.current.component(.hour, from:date)
        return hour>=clinicOpenHour && hour<clinicCloseHour
    }

    // MARK: Send Booking Request

    func sendBookingRequest() {
        if !isValidTime(selectedTime){
            showInvalidTimeAlert = true
            return
        }
        
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: selectedTime)
        let minute = calendar.component(.minute, from: selectedTime)
        let requestedDateTime = calendar.date(bySettingHour: hour, minute: minute,second:0, of: selectedDate) ?? Date()

        
        var finalAddress: String = ""
        var finalLat: Double = 0
        var finalLong: Double = 0
        
        if let clinic = doctorData.clinic.first{
            
            if appointmentType == .home {
                finalAddress = address
                finalLat = latitude
                finalLong = longitude
            }else if appointmentType == .clinic{
                finalAddress = clinic.address
                finalLat = clinic.lat
                finalLong = clinic.long
            }else{
                finalAddress = "Online Consultation"
            }
            
            let initialProposal = TimeProposal(proposedBy: .patient, dateTime: requestedDateTime, reason: nil)
            
            appointmentDetail = Appointment(
                
                doctorId: doctorData.id,
                doctorName: doctorData.name,
                doctorSpeciality: doctorData.category.rawValue,
                
                patientId: patientData.samplePatient.id.uuidString,
                patientName: patientName,
                patientAge: patientAge,
                patientGender: patientGender,
                
                appointmentType: appointmentType,
                
                requestedDateTime: requestedDateTime,
                proposals: [initialProposal],
                confirmedDateTime: nil,
                
                symptoms: symptoms,
                patientNotes: notes.isEmpty ? nil : notes,
                
                clinicPhone: clinic.phone ,
                patientPhone: patientData.samplePatient.phone ,
                
                    appointmentAddress: finalAddress,
                    addressLat: finalLat,
                    addressLong: finalLong,
                
                payment: PaymentData(
                    amount: appointmentPrice,
                    method: .payAtVisit,
                    transactionId: nil,
                    isPaid: false
                ),
                
                status: .requested
            )
        }
        
        if let newAppointment = appointmentDetail{
            Appointments.appointments.append(newAppointment)
        }
        
        print("Booking Request:", appointmentDetail)
        
        
        requestBooking = true
        
    }
}

struct FormActionButtonView : View {
    var isValid : Bool
    @Binding var appointmentType: AppointmentType
    @Binding var address : String
    @Binding var latitude : Double
    @Binding var longitude : Double
    
    var onSubmit: ()->Void
    
    
    var body: some View {
        HStack(spacing:10){
            
            // MARK: Send Request Button
            Button(action:{
                onSubmit()
            }){
                Text("Send Appointment Request")
                    .font(.headline)
                    .frame(maxWidth: .infinity,maxHeight: 30)
                    .padding()
                    .background(isValid ? Color("darkPurple") : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }.disabled(!isValid)
        
            if appointmentType.requiresLocation{
                
                NavigationLink(destination:LocationView(addressText: $address, latitude:$latitude, longitude:$longitude)
                ){
                    Text("Add Location")
                        .font(.headline)
                        .frame(maxWidth: .infinity,maxHeight: 30)
                        .padding()
                        .background(
                            Color(.pink)
                        )
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }.navigationTitle("Add your location")
            }
        }
    }
}







// MARK: Doctor Header

struct DoctorHeaderView: View {

    var name: String
    var speciality: String

    var body: some View {

        HStack(spacing: 15) {

            Image("doctorPic")
                .resizable().scaledToFit()
                .frame(width: 70, height: 70)
                .clipShape(Circle())

            VStack(alignment: .leading) {

                Text(name)
                    .font(.headline)

                Text(speciality)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }

            Spacer()
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }
}

extension AppointmentType {
    
    var requiresLocation: Bool {
        self == .home
    }
}



// MARK: Slot Button
//
//struct SlotButton: View {
//
//    var slot: String
//
//    @Binding var selectedSlot: String?
//
//    var body: some View {
//
//        Button {
//
//            selectedSlot = slot
//
//        } label: {
//
//            Text(slot)
//                .font(.subheadline)
//                .padding()
//                .frame(maxWidth: .infinity)
//                .background(
//                    selectedSlot == slot
//                    ? Color("darkPurple")
//                    : Color.gray.opacity(0.2)
//                )
//                .foregroundColor(
//                    selectedSlot == slot
//                    ? .white
//                    : .primary
//                )
//                .cornerRadius(10)
//        }
//    }
//}





// MARK: Preview
//
//#Preview {
//
//    BookingFormView()
//}
