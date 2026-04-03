//
//  DoctorDetailView.swift
//  ReliefNet
//

import SwiftUI
import MapKit

struct DoctorDetailView: View {

    @State var isSidebarOpen: Bool = false
    @Binding var data: Doctor

    var body: some View {


            ZStack {

                Image("appBG")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()

                ScrollView {

                    VStack(spacing: 20) {

                        // MARK: Doctor Image
                        Image(data.image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 180, height: 180)
                            .clipShape(Circle())
                            .shadow(radius: 8)
                            .padding(.top)

                        // MARK: Doctor Name + Role
                        VStack(spacing: 4) {

                            Text(data.name)
                                .font(.title2)
                                .fontWeight(.bold)

                            Text(data.category.rawValue)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            
                            Text(data.specialization.joined(separator: " • "))
                                .font(.subheadline)
                                .foregroundColor(.gray)

                        }

                        // MARK: Doctor Stats
                        DoctorStatsView(data: data)

                        // MARK: About Doctor
                        AboutSection(about: data.about,
                                     rating: data.rating,
                                     reviews: data.reviews)

                        // MARK: Qualifications
                        QualificationSection(qualification: $data.qualifications)

                        // MARK: Action Buttons
                        HStack(spacing: 30) {
                            
                                NavigationLink(
                                    destination: VideoCallView(
                                        doctorName: data.name)) {
                                            
                                            CircleButton(icon: "video.fill",title:"Video")
                                    
                                        }.tint(.black)
                            
                            
                                NavigationLink(
                                    destination: AudioCallView(
                                        doctorName: data.name,
                                        doctorImageName: data.image)) {
                                            CircleButton(icon: "phone.fill",title: "Audio")
                                            
                                        }.tint(.black)
                            
                            
                                NavigationLink(
                                    destination: ChatDetailedView(
                                        chatTitle: data.name)) {
                                            CircleButton(icon: "message.fill",title:"Chat")
                                        }.tint(.black)
                        }

                        // MARK: Book Appointment
                        NavigationLink(destination:
                                        BookingFormView(doctorData: $data)
                        ) {

                            PrimaryButton(title: "Book Appointment")
                        }
                        .padding(.horizontal)


                        if let clinic = data.clinic.first {

                            VStack(alignment: .leading, spacing: 16) {

                                // MARK: Clinic Header
                                HStack {
                                    VStack(alignment: .leading, spacing: 4) {

                                        Text(clinic.name)
                                            .font(.headline)

                                        Text(clinic.address)
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                    }

                                    Spacer()

                                    // Availability Badge
                                    HStack(spacing: 6) {
                                        Circle()
                                            .fill(clinic.isOpen ? Color.green : Color.red)
                                            .frame(width: 8, height: 8)

                                        Text(clinic.isOpen ? "Open" : "Closed")
                                            .font(.caption)
                                            .fontWeight(.medium)
                                            .foregroundColor(clinic.isOpen ? .green : .red)
                                    }
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 6)
                                    .background((clinic.isOpen ? Color.green : Color.red).opacity(0.1))
                                    .cornerRadius(8)
                                }

                                Divider()

                                // MARK: Timing
                                HStack {
                                    Image(systemName: "clock")

                                    Text("Timings: \(clinic.openTime):00 - \(clinic.closeTime):00")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }

                                // MARK: Map
                                MapView(
                                    doctorName: data.name,
                                    lat: clinic.lat,
                                    long: clinic.long
                                )
                                .frame(height: 200)
                                .cornerRadius(12)
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color.white)
                                    .shadow(color: .black.opacity(0.05), radius: 5)
                            )
                            .padding(.horizontal)
                        }
                        
                        // MARK: Reviews Section
                        ReviewsSection()

                        Spacer()
                    }
                    .padding(.bottom, 40)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white)
                    )
                    .padding(.horizontal)
                    
                }.frame(maxWidth: .infinity)

                // MARK: Sidebar
                if isSidebarOpen {

                    Color.black.opacity(0.3)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation { isSidebarOpen = false }
                        }

                    SidebarView(isOpen: $isSidebarOpen)
                        .transition(.move(edge: .trailing))
                }
            }

            // MARK: Toolbar
            .toolbar {

                ToolbarItem(placement: .navigationBarLeading) {

                    Text("ReliefNet")
                        .font(.system(size: 32, weight: .bold, design: .serif))
                }

                ToolbarItem(placement: .navigationBarTrailing) {

                    Button {
                        withAnimation { isSidebarOpen.toggle() }
                    } label: {

                        Image(systemName: "line.3.horizontal")
                    }
                }
            }

            .navigationBarTitleDisplayMode(.inline)
        
    }
}






// MARK: Doctor Stats

struct DoctorStatsView: View {

    var data: Doctor

    var body: some View {

        HStack(spacing: 40) {

            StatItem(title: "Patients", value: "1.2K")

            StatItem(title: "Experience",
                     value: "\(data.experience) yrs")

            StatItem(title: "Rating",
                     value: String(format: "%.1f", data.rating))
        }
        .padding(.vertical)
    }
}

struct StatItem: View {

    var title: String
    var value: String

    var body: some View {

        VStack(spacing: 4) {

            Text(value)
                .font(.headline)
                .fontWeight(.bold)

            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
        }
    }
}





// MARK: About Section

struct AboutSection: View {

    var about: String
    var rating: Double
    var reviews: Int

    var body: some View {

        VStack(alignment: .leading, spacing: 10) {

            HStack {

                Text("About Doctor")
                    .font(.headline)

                Spacer()

                Text("★ \(String(format: "%.1f", rating)) (\(reviews))")
                    .font(.caption)
                    .foregroundColor(.white)
            }

            Text(about)
                .font(.footnote)
                .foregroundColor(.white)
        }
        .padding()
        .background(Color("darkPurple"))
        .foregroundColor(.white)
        .cornerRadius(14)
        .padding(.horizontal)
    }
}





// MARK: Qualification Section

struct QualificationSection: View {
    @Binding var qualification: [Qualification]
    var body: some View {

        VStack(alignment: .leading, spacing: 8) {

            Text("Qualifications")
                .font(.headline)
            
            ForEach(qualification) { qualification in
                Text("• \(qualification.degree) - \(qualification.institute) - \(qualification.year)")
            }

        }
        .font(.footnote)
        .frame(maxWidth: .infinity,alignment: .leading)
        .padding()
        .background(Color("darkPurple"))
        .foregroundColor(.white)
        .cornerRadius(14)
        .padding(.horizontal)
        
    }
}




// MARK: Reviews Section

struct ReviewsSection: View {
    var review:[Review] = SampleReviews.reviews


    var body: some View {

        VStack(alignment: .leading, spacing: 12) {

            HStack {

                Text("Patient Reviews")
                    .font(.headline)

                Spacer()

                Text("\(review.count) Reviews")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            ForEach(review) { review in
                ReviewCard(
                    name: review.patientName,
                    rating: review.rating,
                    comment: review.comment
                )
            }
        }
        .padding(.horizontal)
    }
}





// MARK: Review Card

struct ReviewCard: View {

    var name: String
    var rating: Int
    var comment: String

    var body: some View {

        VStack(alignment: .leading, spacing: 6) {

            HStack {

                Text(name)
                    .fontWeight(.semibold)

                Spacer()

                HStack(spacing: 2) {

                    ForEach(0..<rating, id: \.self) { _ in

                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                            .font(.caption)
                    }
                }
            }

            Text(comment)
                .font(.footnote)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}





// MARK: Primary Button

struct PrimaryButton: View {

    var title: String

    var body: some View {

        Text(title)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color("darkPurple"))
            .cornerRadius(12)
    }
}





// MARK: Circle Button

struct CircleButton: View {
    
    var icon: String
    var title:String
    var body: some View {
        VStack{
            Image(systemName: icon)
                .foregroundColor(.white)
                .font(.title3)
                .padding(16)
                .background(Color("darkPurple"))
                .clipShape(Circle())
                .shadow(radius: 4)
            
            Text("Video").font(.caption)
        }
    }
}





// MARK: Preview

//#Preview {
//
//    let sampleDoctor =  DoctorData(
//        name: "Dr. Arvind Gupta",
//        role: "Psychiatrist",
//        experience: 12,
//        price: 1800,
//        rating: 4.9,
//        reviews: 210,
//        category: "Psychiatrist",
//        image: "doctor4",
//        about: "I specialize in treating mood disorders and anxiety using medication and therapy.",
//        availability: .busy,
//        clinicHours: "10:00 AM - 6:00 PM",
//        clinicAddress: "NeuroWell Hospital, Gomti Nagar, Lucknow",
//        clinicLat: 26.8424,
//        clinicLong: 80.9949,
//        clinicPhone: "+91 9856789014"
//    )
//
//    DoctorDetailView(data: sampleDoctor)
//        .environmentObject(UserSession())
//}
