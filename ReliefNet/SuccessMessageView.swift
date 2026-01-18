//
//  SuccessMessageView.swift
//  ReliefNet
//
//  Created by Ayush Singh on 31/12/25.
//

import SwiftUI

struct AccountCreatedSheet: View {

//    var onContinue: () -> Void

    var body: some View {
        VStack(spacing: 20) {

            Spacer()

            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 80))
                .foregroundColor(.green)

            Text("Account Created!")
                .font(.title)
                .fontWeight(.bold)

            Text("Your account has been successfully created. Please verify your email to continue.")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Spacer()

            Button(action:{}) {
                Text("Verify Email")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.customPink)
                    .foregroundColor(.black)
                    .cornerRadius(12)
            }
            .padding(.horizontal)

        }
        .padding()
        .presentationDetents([.medium])
    }
}
#Preview {
    AccountCreatedSheet()
}
