//
//  AccountVerificationSheet.swift
//  ReliefNet
//
//  Created by Ayush Singh on 31/12/25.
//

import SwiftUI
import FirebaseAuth
struct EmailVerificationSheet: View {

    @State private var message = "Your account has been successfully created. Please verify your email to continue."
    @Environment(\.dismiss) var dismiss
    @State private var isChecking = false
    @State var verified = false
    var body: some View {
        VStack(spacing: 20) {

            Spacer()

            Image(systemName: verified == true ? "checkmark.seal":"person.circle")
                .font(.system(size: 70))
                .foregroundColor(Color(.purple))

            Text(verified == true ? "Email Verified!" : "Account Created!")
                .font(.title2)
                .fontWeight(.bold)

            Text(message).multilineTextAlignment(.center)


            Button {
                Task{
                    isChecking = true
                    do {
                        try await Auth.auth().currentUser?.reload()
                        if Auth.auth().currentUser?.isEmailVerified == true {
                            verified = true
                            dismiss()
                        } else {
                            message = "Email not verified yet."
                        }
                    } catch {
                        message = error.localizedDescription
                    }
                    isChecking = false
                }
            } label: {
                Text("Verified")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        Color.customPink
                    )
                    .foregroundColor(.black)
                    .cornerRadius(12)
            }
            .disabled(isChecking)
   
            .padding(.horizontal)

            Spacer()

        }
        .padding()
        .presentationDetents([.medium])
    }
}
#Preview {
   EmailVerificationSheet()
}

//
//// EmailVerificationSheet.swift
//
//import SwiftUI
//import FirebaseAuth
//
//struct EmailVerificationSheet: View {
//
//    @State private var message = "Please verify your email."
//
//    var body: some View {
//        VStack(spacing: 20) {
//
//            Text("Verify Email")
//                .font(.title3)
//                .fontWeight(.bold)
//
//
//
//            Button("I Have Verified") {
//                Task {
//                    isChecking = true
//                    do {
//                        try await Auth.auth().currentUser?.reload()
//                        if Auth.auth().currentUser?.isEmailVerified == true {
//                            dismiss()
//                        } else {
//                            message = "Email not verified yet."
//                        }
//                    } catch {
//                        message = error.localizedDescription
//                    }
//                    isChecking = false
//                }
//            }
//            
//            .buttonStyle(.borderedProminent)
//        }
//        .padding()
//    }
//}
//
//#Preview {
//    EmailVerificationSheet()
//}
