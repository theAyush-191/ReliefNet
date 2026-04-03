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
    @State var showSignupSheet : Bool = false
    @State var didForget : Bool = false
    @State var showAlert : Bool = false
    @State var alertMessage : String = ""
    @State var alertTitle : String = ""
    
    var body: some View {

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
                    
                    Button{
                        didForget.toggle()
                    }
                    label:{
                        Text("Forgot password?").font(.callout).foregroundStyle(.black).frame(maxWidth: .infinity,alignment: .trailing)
                    }
                    
                    Button {
                        Task{
                            isLoading = true
                            do{
                                let verified = try await AuthenticationManager.shared.signIn(email:  email, password: password)
                                
                                
                                
                                if !verified {
                                    showVerificationSheet = true
                                                       }
                                else{
                                    session.selectRole(.patient)
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
            .alert("Reset Password",isPresented: $didForget) {
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



// MARK: - Xcode Preview
//#Preview {
//    PatientLoginView().environmentObject(UserSession())
//}
