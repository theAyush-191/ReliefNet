//
//  ProfileView.swift
//  ReliefNet
//
//  Created by Ayush Singh on 29/09/25.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var session: UserSession

    // Derived data from session (NOT local fake state)
    var doctor: Doctor {
        session.currentDoctor ?? sampleDoctor
    }

    var patient: Patient {
        session.currentPatient ?? samplePatient
    }

    var body: some View {

        let name = session.userType == "Patient" ? patient.name : doctor.name
        let profileImage = session.userType == "Patient" ? patient.image : doctor.image
        let location = session.userType == "Patient" ? patient.address : doctor.address

        ZStack {
            Image("appBG").resizable().ignoresSafeArea()

            VStack {
                ScrollView {

                    // Header
                    HStack(spacing: 30) {
                        Image(profileImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100)
                            .clipShape(Circle())
                        
//                        Spacer()
                        
                        VStack(alignment: .leading) {
                            Text(name)
                                .font(.system(size: 30, design: .serif))
                            Text(location)
                                .font(.callout)
                                .fontDesign(.monospaced)
                                .fontWeight(.ultraLight)
                        }
                    }.padding(.horizontal,10)
                    .frame(maxWidth: .infinity)
                        .padding(.vertical,10)
                    .background(Color(.customPink).opacity(0.6))
                    .cornerRadius(16)
                    .padding(30)

                    // Personal Info
                    if session.userType == "Patient" {
                        NavigationLink(destination: PatientProfileView(patient: patient)) {
                            CardView(title: "Personal Information")
                        }
                    } else {
                        NavigationLink(destination: DoctorProfile()) {
                            CardView(title: "Personal Information")
                        }
                    }

                    // Doctor-only
                    if session.userType == "Doctor" {
                        NavigationLink(destination: DoctorAppointmentView()) {
                            CardView(title: "Sessions")
                        }
                        NavigationLink(destination: DoctorFeedbackView()) {
                            CardView(title: "Feedbacks")
                        }
                    }

                    NavigationLink(destination: PaymentHistoryView()) {
                        CardView(title: "Payment History")
                    }

                    NavigationLink(destination: HelpSupportView()) {
                        CardView(title: "Help & Support")
                    }

                    // Logout
                    Button {
                        Task{
                            do{
                                
                                let result = try AuthenticationManager.shared.signOut()
                                if result {
                                    session.logout()
                                    print("LogOut Successful!")
                                }
                                else{
                                    print("LogOut Failed!")
                                }
                                
                            }catch{
                                print(error.localizedDescription)
                            }
                        }
                    } label: {
                        HStack {
                            Text("Log Out")
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                        }
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.red)
                        .cornerRadius(12)
                        .padding(.horizontal, 30)
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
    }
}
private struct CardView: View{
    
    var title:String
    
    var body: some View{
        Text(title).frame(maxWidth: .infinity, alignment: .leading)
            .font(.title3).fontDesign(.rounded).padding(20).overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.purple, lineWidth: 1)
            ).background(RoundedRectangle(cornerRadius: 12).fill(Color(.white))).padding(.vertical,10).padding(.horizontal,30)
    }
}

#Preview {
    NavigationStack{
        ProfileView().environmentObject(UserSession())
    }
}

