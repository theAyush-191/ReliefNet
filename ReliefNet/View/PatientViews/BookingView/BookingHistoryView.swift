//
//  BookingView.swift
//  ReliefNet
//
//  Created by Ayush Singh on 01/10/25.
//

import SwiftUI

struct BookingHistoryView: View {
        
        @State var selectedSegment: Int = 0
        @EnvironmentObject var viewModel : BookingViewModel
        
        var filteredBookings: [Appointment] {
                viewModel.bookings.filter(shouldShow)
            }
        
        var body: some View {
                ZStack{
                        Image("appBG").resizable().ignoresSafeArea()
                        VStack{
                                HStack{
                                        Button("Pending") { selectedSegment = 0 }
                                            .buttonStyle(BookingSegmentStyle(isSelected: selectedSegment == 0))
                                        
                                        Button("Upcoming") { selectedSegment = 1 }
                                            .buttonStyle(BookingSegmentStyle(isSelected: selectedSegment == 1)).foregroundStyle(.purple)
                                        
                                        Button("Completed") { selectedSegment = 2 }
                                            .buttonStyle(BookingSegmentStyle(isSelected: selectedSegment == 2)).foregroundStyle(.purple)
                                        
                                        Button("Cancelled") { selectedSegment = 3 }
                                            .buttonStyle(BookingSegmentStyle(isSelected: selectedSegment == 3)).foregroundStyle(.purple)
                                        
                                    }.padding(5)
                                    .background(Color.gray.opacity(0.15))
                                    .cornerRadius(8).padding(.horizontal,10).padding(.top,7)
                                
                               
                                List {
                                        ForEach(filteredBookings) { booking in
                        
                        //                        if shouldShow(booking) {
                                                    
                                                    ZStack {
                                                            BookingCardView(booking:booking)
                                                                .padding(.vertical,5)
                                                            
                                                            NavigationLink(
                                                                    destination: BookingDetailView(
                                                                            booking: binding(for: booking)
                                                                        ).toolbar(.hidden, for: .tabBar)
                                                                ) {
                                                                        EmptyView()
                                                                    }
                                                            .opacity(0)
                                                        }
                                                    .listRowSeparator(.hidden)
                                                    .listRowBackground(Color.clear)
                        //                        }
                                            }
                                    }
                                .listStyle(.plain)
                                .scrollContentBackground(.hidden)
                            
                            }.background(Color(.systemGroupedBackground)).padding(.top,1).safeAreaInset(edge: .bottom) {
                                    Color.clear.frame(height: 20)
                                }
                    } .tint(.purple).navigationBarBackButtonHidden(true)
                    .onAppear{
            //            bookings = Appointments.appointments
                        print(Appointments.appointments)
                    }
        
            }
        
        func shouldShow(_ booking: Appointment) -> Bool {
            switch selectedSegment {
                case 0:
                    return booking.status == .awaitingDoctor || booking.status == .awaitingPatient
                case 1:
                    return booking.status == .upcoming
                case 2:
                    return booking.status == .completed
                case 3:
                    return booking.status == .cancelled
                default:
                    return false
                }
    }
        
        private func binding(for booking: Appointment) -> Binding<Appointment> {
                guard let index = viewModel.bookings.firstIndex(where: { $0.id == booking.id }) else {
                        fatalError("Booking not found")
                    }
                return $viewModel.bookings[index]
            }
        
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
