//
//  LoginView.swift
//  ReliefNet
//
//  Created by Ayush Singh on 28/09/25.
//

import SwiftUI


struct LoginView: View {
    // State variable to store the user's email input.
    @State private var email: String = ""
    @EnvironmentObject var session: UserSession
    
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
                        Text("Create an account")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Text("Enter your email to sign up for this app")
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                    }
                    TextField("email@domain.com", text: $email).foregroundStyle(Color(.gray))
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                    
                    
                    //                Button(action: {
                    //
                    //                })
                    NavigationLink(destination: LoadingView())
                    {
                        Text("Continue")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(.customPink)
                            .foregroundColor(.black)
                            .cornerRadius(12)
                    }.onTapGesture {
                        email = ""
//                        session.setLoginStatus(true)
//                        session.setRoleSelected(false)
                    }
                    
                    // "or" separator.
                    OrDividerView()
                    
                    // Social login buttons (Google, Apple).
                    SocialLoginButtonsView()
                    
                    Spacer()
                    Spacer()
                    
                    // Footer with legal text.
                    LegalTextView()
                    
                }
                .padding(.horizontal, 35)
            }.navigationBarBackButtonHidden(true )
        }
    }
}


// MARK: - Reusable Components

// Displays the logo, app name, and tagline.
struct HeaderView: View {
    var body: some View {
        VStack(spacing: 0) {
            
            Image("appLogo").resizable().aspectRatio(contentMode: .fit).frame(maxWidth: 80)
            
            Text("ReliefNet").font(.system(size: 75,design: .serif)).foregroundStyle(.white)
            
            Text("Bridging Care, Compassion, and Connection").font(.system(size: 14,design: .serif)).foregroundStyle(.white)
        }
    }
}

// A visual divider with "or" text in the center.
struct OrDividerView: View {
    var body: some View {
        HStack {
            HStack {
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.black)
                
                Text("or")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.horizontal, 5)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.black)
            }
        }
    }
}

// A view that holds the social login buttons.
struct SocialLoginButtonsView: View {
    @EnvironmentObject var session : UserSession
    var body: some View {
//        NavigationStack{
            VStack(spacing: 15) {
                NavigationLink(destination: LoadingView())
                {
                    SocialLoginButton(imageName: "googleLogo", text: "Continue with Google",isGoogle:true)
                }.onTapGesture {
//                    session.setRoleSelected(true)
//                    session.setLoginStatus(true)
                }
                NavigationLink(destination: LoadingView())
                {
                    SocialLoginButton(imageName: "apple.logo", text: "Continue with Apple")
                }.onTapGesture {
//                    session.setRoleSelected(true)
//                    session.setLoginStatus(true)
                }
            }.navigationBarBackButtonHidden(true )
//        }
    }
}

// A reusable button style for social logins.
struct SocialLoginButton: View {
    let imageName: String
    let text: String
    var isGoogle:Bool = false
    
    var body: some View {
            
            HStack {
                
                Spacer()
                
                if isGoogle{
                    Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                    
                }else{
                    Image(systemName:imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                }
                
                Text(text)
                    .fontWeight(.medium)
                
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .foregroundColor(.black)
            .cornerRadius(12)
        
    }
}


// Displays the legal text with embedded links.
struct LegalTextView: View {
    var body: some View {
        // Using markdown for links (requires iOS 15+).
        Text("By clicking continue, you agree to our [Terms of Service](https://www.example.com/terms) and [Privacy Policy](https://www.example.com/privacy).")
            .font(.caption)
            .foregroundColor(.gray)
            .multilineTextAlignment(.center)
            .tint(.gray) // Sets the color for the links
    }
}


// MARK: - Xcode Preview
#Preview {
    LoginView().environmentObject(UserSession())
}
