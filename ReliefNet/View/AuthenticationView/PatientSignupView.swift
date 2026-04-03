//
//  PatientSignUpView.swift
//  ReliefNet
//
//  Created by Ayush Singh on 04/12/25.
//

import SwiftUI
import FirebaseAuth

struct PatientSignupView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var showVerificationSheet = false

    @EnvironmentObject var session: UserSession

    
    var isFormValid : Bool {
        !name.isEmpty && !email.isEmpty && !password.isEmpty
    }
    
//    @Binding var didCreateAccount : Bool
    @State var isLoading : Bool = false
    

    
    var body: some View {
            ZStack {
                // Background gradient for the entire screen.
                Image("appBG").resizable().scaledToFill().ignoresSafeArea()
                
                VStack(spacing: 20) {
                    

                    VStack{
                        Text("Create an Account")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Text("Enter your email to sign up as patient")
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                    }
                    
                    CustomTextField(hint: "Full Name", icon: "person", text: $name, keyboard: .default, isSecure: false)
                    
                    CustomTextField(hint: "email@domain.com", icon: "envelope", text: $email, keyboard: .emailAddress, isSecure: false)
                    
                    CustomTextField(hint: "Password",icon: "key", text: $password, keyboard: .default, isSecure: true)
                    
                    
                    Button{
                        isLoading = true
                        Task{
                            do {
                                try await AuthenticationManager.shared.createUser(email: email, password: password)
                                showVerificationSheet=true
                                
                                
                            }catch{
                                print(error.localizedDescription)
                            }
                            isLoading = false
//                            signedIn = true
                        }
                        
                    }
                    label: {
                        Group {
                            if isLoading {
                                ProgressView()
                                    .progressViewStyle(
                                        CircularProgressViewStyle(tint: .black)
                                    )
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.customPink)
                                    .cornerRadius(12)
                            } else {
                                Text("Sign Up")
                                    .fontWeight(.semibold)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(isFormValid ? Color.customPink : Color.gray)
                                    .foregroundColor(.black)
                                    .cornerRadius(12)
                            }
                        }
                    }
                    .disabled(!isFormValid || isLoading)
                    .opacity(isFormValid ? 1 : 0.6)
                    .animation(.easeInOut, value: isLoading)

                }
                .padding(.horizontal, 35)
                .sheet(isPresented: $showVerificationSheet) {
                            EmailVerificationSheet()
                        }
            }
            
        }
    }




// MARK: - Xcode Preview
//#Preview {
//    PatientSignupView().environmentObject(UserSession())
//}

