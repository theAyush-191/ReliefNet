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

    @EnvironmentObject var session: UserSession
    
    var isFormValid : Bool {
        !medicalID.isEmpty && !email.isEmpty && !password.isEmpty
    }
    
    @State var isLoading : Bool = false
    @State var showVerificationSheet : Bool = false
    @State var didForget : Bool = false
    @State var showAlert : Bool = false
    @State var alertTitle : String = ""
    @State var alertMessage : String = ""
    
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
                        
                        Button{
                            didForget.toggle()
                        }
                        label:{
                            Text("Forgot password?").font(.callout).foregroundStyle(.black).frame(maxWidth: .infinity,alignment: .trailing)
                        }
                        
                       
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
                                alertTitle = "Login Error"
                                alertMessage = error.localizedDescription
                                showAlert = true
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
            }.alert("Reset Password",isPresented: $didForget) {
                TextField("Enter your email", text: $email)
                
                Button("Send Link"){
                    Task{
                        do{
                            try await AuthenticationManager.shared.forgotPassword(email: email)
                            alertTitle = "Status"
                            alertMessage = "Password reset link sent to your email."
                        }catch{
                            alertTitle = "Reset Password Error"
                            alertMessage = error.localizedDescription
                        }
                        showAlert = true
                    }
            
                }
                
                Button("Cancel" , role : .cancel){
                    email = ""
                }
                
            }message:{
                Text("We’ll send a reset link to your email")
            }.alert(alertTitle,isPresented: $showAlert){
                Button("Ok",role: .cancel){}
            }message: {
                Text(alertMessage)
            }


        
    }
}

#Preview {
    DoctorLoginView().environmentObject(UserSession())
}
