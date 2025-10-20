//
//  DoctorFeedbackView.swift
//  ReliefNet
//
//  Created by Ayush Singh on 15/10/25.
//

import SwiftUI

struct DoctorFeedbackView: View {
    
    @State private var feedbacks:[Feedback]=sampleFeedbacks
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(feedbacks) { feedback in
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text(feedback.patientName)
                                .font(.headline)
                            Spacer()
                            Text(feedback.date)
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        HStack(spacing: 2) {
                            ForEach(0..<5) { index in
                                Image(systemName: index < Int(feedback.rating) ? "star.fill" : "star")
                                    .foregroundColor(.yellow)
                            }
                        }
                        Text("“\(feedback.comment)”")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 8)
                }
            }
            .navigationTitle("Patient Feedback")
        }
    }
}

#Preview {
    DoctorFeedbackView()
}
