//
//  LoginView.swift
//  ReliefNet
//
//  Created by Ayush Singh on 28/09/25.
//

import SwiftUI
import FirebaseAuth


struct PatientLoginView: View {
    // State variable to store the user's email input.
    @State private var email: String = ""
    @State private var password: String = ""
    @State var showSignupSheet : Bool = false
//    @State private var showVerificationSheet = false
    
    @EnvironmentObject var session: UserSession
    
//    @State var signedIn : Bool
    @State var isLoading : Bool = false
    var isFormValid : Bool {
        !email.isEmpty && !password.isEmpty
    }
    
    
//    let isLoggedIn : Bool = Auth.auth().currentUser != nil
    @State private var showVerificationSheet = false
//    @State private var didCreateAccount = false
    
    
    
    var body: some View {
        NavigationStack{
            ZStack {
                // Background gradient for the entire screen.
                Image("appBG").resizable().scaledToFill().ignoresSafeArea()
                
                VStack(spacing: 20) {
                    Spacer()
                    
                    // Header section with logo and app name.
                    HeaderView()
                        .padding(.bottom, 30)
                    
                    // Form section for email sign up.
                    VStack{
                        Text("Sign In as Patient")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Text("Enter your email to sign in for this app")
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                    }
                    
                    CustomTextField(hint: "email@domain.com", icon: "envelope", text: $email, keyboard: .emailAddress, isSecure: false)
                    
                    CustomTextField(hint: "Password",icon: "key", text: $password, keyboard: .default, isSecure: true)
                        
                    
                    
                    Button {
                        Task{
                            isLoading = true
                            do{
                                let verified = try await AuthenticationManager.shared.signIn(email:  email, password: password)
                                
                                
                                
                                if !verified {
                                    showVerificationSheet = true
                                                       }
                                else{
                                    session.login(as: "Patient")
                                }
                                
                            }catch{
                                print(error.localizedDescription)
                            }
                           isLoading = false
                        }
                    } label: {
                        CustomButton(loader: isLoading, text: "Log In", formValid: isFormValid)
                    }
                    
                    
                    OrDividerView()
                    

                    SocialLoginButtonsView()
                    

                    Spacer()
 
                    LegalTextView()
                    
                    HStack {
                        Text("Don't have an account?")
                            .foregroundColor(.white)
                        Button{
                            showSignupSheet = true

                        }label:{
                            Text("Sign Up")
                                .foregroundColor(.customPink)
                                .fontWeight(.semibold)
                        }
                    }
                    .font(.footnote)
                    
                }  
                .padding(.horizontal, 35)
            }.sheet(isPresented: $showSignupSheet){
                    PatientSignupView()
                        .presentationDetents([.medium])
                        .presentationDragIndicator(.visible)
            }
            .sheet(isPresented: $showVerificationSheet) {
                EmailVerificationSheet()
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.visible)
            }
        }
    }
}



// MARK: - Xcode Preview
#Preview {
    PatientLoginView().environmentObject(UserSession())
}
