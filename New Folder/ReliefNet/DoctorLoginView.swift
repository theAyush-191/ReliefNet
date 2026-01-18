//
//  SignInView.swift
//  ReliefNet
//
//  Created by Ayush Singh on 05/11/25.
//

import SwiftUI
import FirebaseAuth
import Combine

struct DoctorLoginView: View {
    @State private var medicalID: String = ""
    @State private var password: String = ""
    @State private var email: String = ""
    @State var showSignupSheet : Bool = false
//    @StateObject var signinInfo = SignInEmailViewModelInfo()
    @EnvironmentObject var session: UserSession
    
    var isFormValid : Bool {
        !medicalID.isEmpty && !email.isEmpty && !password.isEmpty
    }
    
    @State var isLoading : Bool = false
    @State var showVerificationSheet : Bool = false

    
    var body: some View {
            ZStack {
                // Background Image
                Image("appBG")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    Spacer()
                    
                    // Header section
                    HeaderView()
                        .padding(.bottom, 30)
                    
                    // Title and Description
                    VStack {
                        Text("Sign In as Doctor")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Text("Enter your medical ID to sign in")
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                    }
                    
                    // Input Fields
                    VStack(spacing: 15) {
                        CustomTextField(hint: "Professional email", icon: "envelope", text: $email, keyboard: .emailAddress, isSecure: false)
                        
                        CustomTextField(hint: "Medical ID", icon: "person.text.rectangle", text: $medicalID, keyboard: .emailAddress, isSecure: false)
                        
                        
                        CustomTextField(hint: "Password",icon: "key", text: $password, keyboard: .default, isSecure: true)
                        
                       
                    }
                    
                    // Sign In Button
                    Button {
                        Task{
                            isLoading = true

                            do{
                               let verified = try await AuthenticationManager.shared.signIn(email: email, password: password)
                                
                                session.login(as: "Doctor")
                                
                                if !verified {
                                    showVerificationSheet = true
                                }
                                
                            }catch{
                                print(error.localizedDescription)
                            }
                            isLoading = false
                    }
                        
                    } label: {
                        CustomButton(loader: isLoading, text: "Log In", formValid: isFormValid)
                    }
                    // "or" separator.
                    OrDividerView()
                    
                    // Social login buttons (Google, Apple).
                    SocialLoginButtonsView()

                    
                    Spacer()
//                    Spacer()
                    
                    // Footer with link to signup
                    VStack(spacing: 8) {
                        LegalTextView()
                        
                        HStack {
                            Text("Don't have an account?")
                                .foregroundColor(.white)
                            
                            Button{
                                showSignupSheet = true
                            }
                            label:{
                                Text("Sign Up")
                                    .foregroundColor(.customPink)
                                    .fontWeight(.semibold)
                        }
                        }
                        .font(.footnote)
                    }
                }
                .padding(.horizontal, 35)
            }.sheet(isPresented: $showSignupSheet) {
                        DoctorSignupView()
                            .presentationDetents([.large])
                            .presentationDragIndicator(.visible)
                    
            }.sheet(isPresented:$showVerificationSheet) {
                EmailVerificationSheet().presentationDetents([.medium])
                    .presentationDragIndicator(.visible)
            }

        
    }
}

#Preview {
    DoctorLoginView().environmentObject(UserSession())
}
