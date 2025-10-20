//
//  ProfileView.swift
//  ReliefNet
//
//  Created by Ayush Singh on 29/09/25.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var session: UserSession
    
    @State private var isSidebarOpen = false
    
    @State private var doctor: Doctor = sampleDoctor
    @State private var patient: Patient = samplePatient
    
    
    var userData:Any{
        if session.userType == "Patient"{
            return samplePatient
        }
        else{
            return sampleDoctor
        }
    }
    var body: some View {
        let name = session.userType == "Patient" ? patient.name : doctor.name
        let profileImage = session.userType == "Patient" ? patient.image : doctor.image
        let location = session.userType == "Patient" ? patient.address : doctor.address
        
            ZStack{
                Image("appBG").resizable().ignoresSafeArea()
                VStack{
                    ScrollView{
                    HStack{
                        Image(profileImage).resizable().scaledToFit().frame(width: 70).clipShape(Circle())
                        VStack{
                            Text(name).font(.system(size: 25,weight: .regular,design: .serif))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text(location).font(.callout).fontDesign(.monospaced).fontWeight(.ultraLight)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }.padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(.customPink).opacity(0.6))
                        .cornerRadius(16).padding(20)
                    
                    if session.userType=="Patient"{
                        NavigationLink(destination: PatientProfileView(patient: userData as! Patient)){
                            CardView(title: "Personal Information")
                        }
                    }
                    else{
                        NavigationLink(destination: DoctorProfile()){
                            CardView(title: "Personal Information")
                        }
                    }
                    
                    if session.userType=="Doctor"{
                        NavigationLink(destination: DoctorSessionsView()) {
                            CardView(title: "Sessions")
                        }
                        NavigationLink(destination: DoctorFeedbackView()) {
                            CardView(title: "Feedbacks")
                        }
                    }
                    
                    NavigationLink(destination: PaymentHistoryView()){
                        CardView(title: "Payment History")
                    }
                    
                        NavigationLink(destination: HelpSupportView()) {
                            CardView(title: "Help & Support")
                        }
                        
                  
                        Button(action: {
                       
                            session.setLoginStatus(false)
                            session.setRoleSelected(false)
                        }) {
                            HStack{
                                Text("Log Out")
                                    .font(.title3).fontDesign(.rounded)
                                
                              
                                Image(systemName: "rectangle.portrait.and.arrow.right")
                                    
                            }.foregroundStyle(.white).bold().font(.title3).fontDesign(.rounded).padding(20).frame(maxWidth: .infinity, alignment: .leading)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.red, lineWidth: 1)
                                ).background(RoundedRectangle(cornerRadius: 12).fill(Color(.red))).padding(.vertical,10).padding(.horizontal,30)
                        }
                    
                    Spacer()
                }
                }.background(Color(.systemGroupedBackground)).padding(.top,1).safeAreaInset(edge: .bottom) {
                    Color.clear.frame(height: 20)
                }
            } .tint(.purple).navigationBarBackButtonHidden(false)
            .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Text("Profile")
                    .font(.system(size: 35, weight: .bold, design: .serif)).allowsTightening(true)
                    .foregroundColor(.primary)
                    .frame(width:240)
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action:{ withAnimation { isSidebarOpen.toggle()} })
                {
                    Image(systemName: "line.3.horizontal")
                }
            }

    }.padding(.bottom,0).navigationBarTitleDisplayMode(.inline).navigationBarBackButtonHidden(true)
        
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
