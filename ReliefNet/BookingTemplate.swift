//
//  BookingTemplate.swift
//  ReliefNet
//
//  Created by Ayush Singh on 01/10/25.
//

import SwiftUI

// MARK: - Custom Styles

struct BookingSegmentStyle: ButtonStyle {
    var isSelected: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical, 8)
            .frame(maxWidth: .infinity)
            .background(isSelected ? Color.white : Color.clear)
            .foregroundColor(isSelected ? .purple : .gray)
            .cornerRadius(6)
            .fontWeight(.semibold)
    }
}

struct BookingCardButtonStyle: ButtonStyle {
    var isPrimary: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity)
            .padding(10)
            .background(isPrimary ? Color.clear : Color.gray.opacity(0.15))
            .foregroundColor(isPrimary ? .purple.opacity(0.8) : .gray)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(isPrimary ? Color.purple.opacity(0.8) : Color.clear, lineWidth: 1.5)
            )
            .opacity(configuration.isPressed ? 0.8 : 1.0)
    }
}

// Booking Template
struct BookingCardView: View {
    var booking: Booking
    var statusColor:Color{
        switch booking.status {
        case "Pending": return .blue
        case "Confirmed":  return .green
        default:          return .gray
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(booking.purpose)
                    .fontWeight(.bold)
                Spacer()
                Text(booking.status)
                    .font(.caption)
                    .foregroundColor(Color(statusColor))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color(statusColor).opacity(0.1))
                    .cornerRadius(6)
            }
            Text(booking.name)
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Divider()
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Image(systemName: "calendar")
                    Text(booking.date.formatted(date: .abbreviated, time: .shortened))
                }
                HStack {
                    Image(systemName: "video.fill")
                    Text(booking.meetingType)
                }
            }
            .font(.caption)
            .foregroundColor(.secondary)
            
            HStack(spacing: 10) {
                if booking.isCompleted{
                    Button("Book Again") {}
                        .buttonStyle(BookingCardButtonStyle(isPrimary: true))
                    Button("Leave Review") {}
                        .buttonStyle(BookingCardButtonStyle(isPrimary: false))
                }else{
                    Button("Join / Directions") {}
                        .buttonStyle(BookingCardButtonStyle(isPrimary: true))
                    Button(action:{}){
                        Image(systemName: "trash").foregroundStyle(.red).padding(8).frame(maxWidth: 30).background(RoundedRectangle(cornerRadius: 6).stroke(Color(.red) , lineWidth: 1))
                    }
                }
                
            }
            .padding(.top, 8)
        }
        .padding()
    }
}
 
