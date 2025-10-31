//
//  BookingView.swift
//  ReliefNet
//
//  Created by Ayush Singh on 01/10/25.
//

import SwiftUI

struct BookingView: View {
    
    @State var selectedSegment: Int = 0
    var bookings : [Booking] = Bookings().sampleBookings
    var filteredBookings: [Booking] {
            if selectedSegment == 0 {
                // Upcoming: show only Confirmed or Pending
                return bookings.filter { $0.status == "Confirmed" || $0.status == "Pending" }
            } else if selectedSegment == 1 {
                // Past: show only Completed
                return bookings.filter { $0.status == "Complete" }
            }else{
                return bookings.filter { $0.status == "Cancelled" }
            }
        }
    var body: some View {
        ZStack{
            Image("appBG").resizable().ignoresSafeArea()
            VStack{
                HStack{
                    Button("Upcoming") { selectedSegment = 0 }
                        .buttonStyle(BookingSegmentStyle(isSelected: selectedSegment == 0))
                    
                    Button("Past") { selectedSegment = 1 }
                        .buttonStyle(BookingSegmentStyle(isSelected: selectedSegment == 1)).foregroundStyle(.purple)
                    
                    Button("Cancelled") { selectedSegment = 2 }
                        .buttonStyle(BookingSegmentStyle(isSelected: selectedSegment == 2)).foregroundStyle(.purple)
                    
                }.padding(5)
                    .background(Color.gray.opacity(0.15))
                    .cornerRadius(8).padding(.horizontal,10).padding(.top,7)
                
                List(filteredBookings) { booking in
                    NavigationLink(destination: BookingDetailView()){
                        BookingCardView(booking: booking)
                            .listRowSeparator(.hidden).background(Color.white)
                            .cornerRadius(16)
                            .shadow(color: .gray.opacity(0.2), radius: 10, y: 5)
                    }
                }.background(Color(.systemGroupedBackground)).scrollContentBackground(.hidden)
                    .listStyle(.plain)
                
            }.background(Color(.systemGroupedBackground)).padding(.top,1).safeAreaInset(edge: .bottom) {
                Color.clear.frame(height: 20)
            }
        } .tint(.purple).navigationBarBackButtonHidden(false)

    }
}

#Preview {
    BookingView()
}
