//
//  BookingView.swift
//  ReliefNet
//
//  Created by Ayush Singh on 01/10/25.
//

import SwiftUI

struct BookingHistoryView: View {
    
    @State var selectedSegment: Int = 0
    @State var bookings : [Appointment] = Appointments.appointments
    
//    var filteredBookings: [Appointment] {
//        switch selectedSegment {
//            
//        case 0: // Upcoming
//            return bookings.filter {
//                $0.status == .requested ||
//                $0.status == .upcoming ||
//                $0.status == .awaitingPatient
//            }
//
//        case 1: // Past
//            return bookings.filter { $0.status == .completed }
//
//        case 2: // Cancelled
//            return bookings.filter { $0.status == .cancelled }
//
//        default:
//            return bookings
//        }
//    }
    var visibleBookings: [Appointment] {
        bookings.filter {
            (selectedSegment == 0 && ($0.status == .requested || $0.status == .upcoming || $0.status == .awaitingPatient)) ||
            (selectedSegment == 1 && $0.status == .completed) ||
            (selectedSegment == 2 && $0.status == .cancelled)
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
                
               
                List {
                    ForEach(visibleBookings) { booking in
                        
                        if let index = bookings.firstIndex(where: { $0.id == booking.id }) {
                            
                            ZStack {
                                BookingCardView(booking: booking)
                                    .padding(.vertical,5)
                                
                                NavigationLink(
                                    destination: BookingDetailView(
                                        booking: $bookings[index]
                                    )
                                ) {
                                    EmptyView()
                                }
                                .opacity(0)
                            }
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                        }
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
            
            }.background(Color(.systemGroupedBackground)).padding(.top,1).safeAreaInset(edge: .bottom) {
                Color.clear.frame(height: 20)
            }
        } .tint(.purple).navigationBarBackButtonHidden(true)
            .onAppear{
//            bookings = Appointments.appointments
            print(Appointments.appointments)
        }

    }
    
//    func binding(for booking: Appointment) -> Binding<Appointment> {
//        guard let index = bookings.firstIndex(where: { $0.id == booking.id }) else {
//            fatalError("Booking not found")
//        }
//        return $bookings[index]
//    }
}

struct BookingSegmentStyle: ButtonStyle {
    
    var isSelected: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        
        configuration.label
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
            .background(isSelected ? Color.purple : Color.clear)
            .foregroundColor(isSelected ? .white : .purple)
            .cornerRadius(8)
            .font(.subheadline)
            .fontWeight(.semibold)
    }
}

struct EmptyBookingView: View {
    
    var message: String
    
    var body: some View {
        
        VStack(spacing: 16) {
            
            Image(systemName: "calendar.badge.exclamationmark")
                .font(.system(size: 50))
                .foregroundColor(.purple.opacity(0.7))
            
            Text("No Bookings")
                .font(.headline)
            
            Text(message)
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
#Preview {
    BookingHistoryView()
}
