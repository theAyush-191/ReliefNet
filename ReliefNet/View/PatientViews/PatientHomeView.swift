//
//  HomeView.swift
//  ReliefNet
//
//  Created by Ayush Singh on 28/09/25.
//

import SwiftUI

struct PatientHomeView: View {
    var body: some View {
//        NavigationStack{
            ZStack{
                Image("appBG").resizable().scaledToFill().ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        WelcomeBannerView()
                        RelieButtonView()
                        ServicesView()
                        BookingHistoryView().frame(maxWidth: .infinity).frame(height: 300)
//                        BookingsView()
                    }
                    .padding()
                }.background(Color(.systemGray6)).padding(.top,20).safeAreaInset(edge: .bottom) {
                    Color.clear.frame(height: 20)
                  
                }
                
            }
            .tint(.purple).navigationBarBackButtonHidden(true)
            .padding(.bottom,0)
    }
}



struct WelcomeBannerView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Welcome to ReliefNet")
                .font(.system(size: 30,design:.serif))
                .fontWeight(.medium)
            Text("Bridging Care, Compassion and connection")
                .font(.headline)
                .fontWeight(.light)
                .foregroundColor(.black.opacity(0.7))
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.customPink).opacity(0.7))
        .cornerRadius(16)
    }
}

struct RelieButtonView: View {
    var body: some View {
        NavigationLink(destination: RelieBotView())
        {
            HStack {
                Text("RelieBot")
                    .font(.system(size: 30,design:.serif))
                    .fontWeight(.medium)
                
                Spacer()
                
                Image("relieBot").resizable().scaledToFit().frame(width:25)
            }
            .foregroundColor(.black)
            .padding(.horizontal, 30)
            .padding(.vertical, 15)
            .background(Color.pink.opacity(0.4))
            .cornerRadius(20)
            
        }
    }
}

struct ServicesView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Our Services")
                .font(.title3)
                .fontWeight(.bold)
            
            NavigationLink(destination: HealthSupportView()){
                HStack {
                    Text("Mental Health Support")
                        .fontWeight(.semibold)
                    Spacer()
                    Image(systemName: "chevron.right").foregroundStyle(.purple)
                }
                .foregroundColor(.primary)
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.purple, lineWidth: 1)
                )
            }
        }
    }
}

//struct BookingsView: View {
//    @State private var selectedSegment = 0 // 0 for Upcoming, 1 for Past
//    var bookings : [Booking] = Bookings().sampleBookings
//    var filteredBookings: [Booking] {
//            if selectedSegment == 0 {
//                // Upcoming: show only Confirmed or Pending
//                return bookings.filter { $0.status == "Confirmed" || $0.status == "Pending" }
//            } else {
//                // Past: show only Completed
//                return bookings.filter { $0.status == "Complete" }
//            }
//        }
//    var body: some View {
//        VStack(alignment: .leading, spacing: 12) {
//            Text("Your Bookings")
//                .font(.title3)
//                .fontWeight(.bold)
//            
//            VStack {
//                // Custom Segmented Control
//                HStack {
//                    Button("Upcoming") { selectedSegment = 0 }
//                        .buttonStyle(BookingSegmentStyle(isSelected: selectedSegment == 0))
//                    
//                    Button("Past") { selectedSegment = 1 }
//                        .buttonStyle(BookingSegmentStyle(isSelected: selectedSegment == 1))
//                }
//                .padding(5)
//                .background(Color.gray.opacity(0.15))
//                .cornerRadius(8)
//                
//                // Sample Booking Card
//                ScrollView{
//                    LazyVStack(spacing: 16) {
//                        ForEach(filteredBookings) { booking in
//                            BookingCardView(booking: booking)
//                        }.background(Color.white)
//                            .cornerRadius(16)
//                            .shadow(color: .gray.opacity(0.2), radius: 10, y: 5)
//                            .padding(.horizontal)
//
//                        
//                    }
//                }.frame(height: 200)
//            }
//            .padding()
//            .background(Color.white)
//            .cornerRadius(16)
//            .shadow(color: .gray.opacity(0.1), radius: 10, y: 5)
//        }
//    }
//}





// MARK: - Preview

#Preview {
    PatientHomeView()
}
