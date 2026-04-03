//
//  RescheduleView.swift
//  ReliefNet
//
//  Created by Ayush Singh on 20/03/26.
//

import SwiftUI

struct RescheduleBookingView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var user:UserSession
    
    // Selected values
    @State private var selectedDate = Date()
    @State private var selectedTime = Date()
    @State private var reason = ""
    @Binding var detail:Appointment
    
    var isValid: Bool {
        if user.userType == .doctor {
            return combineDateAndTime() > Date()
        } else {
            return !reason.trimmingCharacters(in: .whitespaces).isEmpty
                && combineDateAndTime() > Date()
        }
    }
    
    var body: some View {
        
//        NavigationStack {
        ScrollView{
            VStack(spacing: 20) {
                
                // MARK: - Date Picker
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text("Select Date")
                        .font(.headline)
                    
                    DatePicker(
                        "",
                        selection: $selectedDate,
                        displayedComponents: [.date]
                    )
                    .datePickerStyle(.graphical)
                }
                
                
                // MARK: - Time Picker
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text("Select Time")
                        .font(.headline)
                    
                    DatePicker(
                        "",
                        selection: $selectedTime,
                        displayedComponents: [.hourAndMinute]
                    )
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                }
                
                
                // MARK: - Reason (Optional)
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text(user.userType == .patient ? "Reason" : "Reason (Optional)")
                        .font(.headline)
                    
                    TextField("Add note for patient...", text: $reason)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                }
                
                
                Spacer()
                
                
                // MARK: - Confirm Button
                Button {
                    addProposal()
                    dismiss()
                    
                } label: {
                    Text("Confirm Reschedule")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(isValid ? Color.purple : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }.disabled(!isValid)
                
            }
            .padding()
        }.navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Reschedule")
            .navigationBarTitleDisplayMode(.inline)
//        }
    }
    
    // MARK: - Combine Date & Time
    
    func combineDateAndTime() -> Date {
        let calendar = Calendar.current
        
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: selectedDate)
        let timeComponents = calendar.dateComponents([.hour, .minute], from: selectedTime)
        
        var finalComponents = DateComponents()
        finalComponents.year = dateComponents.year
        finalComponents.month = dateComponents.month
        finalComponents.day = dateComponents.day
        finalComponents.hour = timeComponents.hour
        finalComponents.minute = timeComponents.minute
        
        return calendar.date(from: finalComponents) ?? Date()
    }
    
    func addProposal() {
        
        let finalDateTime = combineDateAndTime()
        let lastProposal  = detail.proposals.last
        
        let newProposal = TimeProposal(
            proposedBy: user.userType,
            dateTime: finalDateTime,
            reason: reason.trimmingCharacters(in: .whitespaces).isEmpty ? nil : reason
        )
        if let index = detail.proposals.lastIndex(where: { $0.proposedBy == user.userType }) {
                // overwrite existing proposal from same user
                detail.proposals[index] = newProposal
            } else {
                // first proposal from this user
                detail.proposals.append(newProposal)
            }
        
        detail.status = user.userType == .patient ? .awaitingDoctor : .awaitingPatient
        
    }
}

//#Preview {
//    RescheduleView()
//}
