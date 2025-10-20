//
//  DoctorProfileView.swift
//  ReliefNet
//
//  Created by Ayush Singh on 02/10/25.
//

import SwiftUI

struct DoctorDetailView: View {
    
    @State var isSidebarOpen:Bool=false
    
    var data:DoctorData
    
    var body: some View {
        
        let name:String = data.name
        let profession:String = data.role
        let rating:Double = data.rating
        let reviews:Int = data.reviews
        let about:String = data.about
        
        NavigationStack{
            ZStack{
                Image("appBG").resizable().scaledToFill().ignoresSafeArea()
                // MARK: Doctor Info
                
                VStack(spacing: 8) {
                    Text(name)
                        .font(.title2)
                        .fontWeight(.semibold).padding(.top,10)
                    
                    Text(profession)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Image("doctorPic") // doctor image asset
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                    
                    // MARK: About Doctor Section
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("About Doctor")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                            Spacer()
                            Text("★ \(String(format: "%.1f", rating)) (\(reviews) Reviews)")
                                .foregroundColor(.white)
                                .font(.caption)
                        }
                        
                        Text(about)
                            .font(.footnote)
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(Color("darkPurple"))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    
                    // MARK: Action Buttons
                    HStack(spacing: 24) {
                        NavigationLink(destination: VideoCallView(doctorName: data.name)){
                            CircleButton(icon: "video.fill")
                    }
                        NavigationLink(destination: AudioCallView(doctorName: data.name,doctorImageName: "doctorPic")){
                        CircleButton(icon: "phone.fill")
                        }
                        NavigationLink( destination: ChatDetailedView(chatTitle: data.name)){
                            CircleButton(icon: "message.fill")
                        }
                        
                        
                    }
                    
                    // MARK: Availability
                    HStack {
                        Text("AVAILABLE")
                            .font(.headline)
                            .fontWeight(.bold)
                        Circle()
                            .fill(Color.green)
                            .frame(width: 20, height: 20)
                    }
                    .padding(.top)
                    
                    Spacer()
                }.background(.white).padding(.top,1)
                
                if isSidebarOpen {
                                    // Dimmed background
                    Color.black.opacity(0.3)
                                            .ignoresSafeArea()
                                            .onTapGesture {
                                                withAnimation { isSidebarOpen = false }
                                            }
                                            .zIndex(0) // Background

                                        // The Sidebar View
                                        SidebarView(
                                            isOpen: $isSidebarOpen
                                        )
                                        .transition(.move(edge: .trailing))
                                        .zIndex(1)
                                }
                
            }.navigationBarBackButtonHidden(false)
                .toolbar {
                
                    ToolbarItem(placement: .navigationBarLeading) {
                        Text("ReliefNet")
                            .font(.system(size: 35, weight: .bold, design: .serif)).allowsTightening(true)
                            .foregroundColor(.primary)
                            .frame(width:200)
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action:{
                                                        withAnimation { isSidebarOpen.toggle()}
                        })
                        {
                            Image(systemName: "line.3.horizontal")
                        }
                    }
                    
                }.padding(.bottom,0).navigationBarTitleDisplayMode(.inline)
        }
    }
}


// Reusable circle button
struct CircleButton: View {
    var icon: String
    var body: some View {
  
            Image(systemName: icon)
                .foregroundColor(.white)
                .font(.title2)
                .padding()
                .background(Color("darkPurple"))
                .clipShape(Circle())
        
    }
}

#Preview {
    let sampleDoctor = DoctorData(
        name: "Dr. Rahul Verma",
        role: "Therapist & Counsellor",
        experience: 10,
        price: 1200,
        rating: 4.9,
        reviews: 280,
        category: "Therapist",
        image: "doctorPic",
        about: "I specialize in cognitive behavioral therapy and helping individuals manage stress, anxiety, and emotional well-being."
    )
    
    DoctorDetailView(data:sampleDoctor).environmentObject(UserSession())
}
