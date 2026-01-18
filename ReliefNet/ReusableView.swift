//
//  ReusableView.swift
//  ReliefNet
//
//  Created by Ayush Singh on 30/12/25.
//

import SwiftUI


struct CustomTextField: View {

    let hint: String
    let icon: String
    @Binding var text: String
    var keyboard: UIKeyboardType = .default
    var isSecure: Bool = false

    var body: some View {
        HStack(spacing: 12) {

            Image(systemName: icon)
                .foregroundColor(.black)

            if isSecure {
                SecureField(hint, text: $text)
            } else {
                TextField(hint, text: $text)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .keyboardType(keyboard)
        .autocapitalization(.none)
    }
}

struct CustomButton: View {
    var loader : Bool
    let text : String
    var formValid : Bool
    var body: some View {
        Group {
            if loader {
                ProgressView()
                    .progressViewStyle(
                        CircularProgressViewStyle(tint: .black)
                    )
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.customPink)
                    .cornerRadius(12)
            } else {
                Text(text)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(formValid ? Color.customPink : Color.gray)
                    .foregroundColor(.black)
                    .cornerRadius(12)
            }
        }  .disabled(!formValid || loader)
            .opacity(formValid ? 1 : 0.6)
            .animation(.easeInOut, value: loader)

    }
}

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


// Displays the logo, app name, and tagline.
struct HeaderView: View {
    var body: some View {
        VStack(spacing: 0) {
            
            Image("appLogo").resizable().aspectRatio(contentMode: .fit).frame(maxWidth: 80)
            
            Text("ReliefNet").font(.system(size: 65,design: .serif)).foregroundStyle(.white)
            
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

            VStack(spacing: 15) {
                NavigationLink(destination: LoadingView())
                {
                    SocialLoginButton(imageName: "googleLogo", text: "Continue with Google",isGoogle:true)
                }
                
                NavigationLink(destination: LoadingView())
                {
                    SocialLoginButton(imageName: "apple.logo", text: "Continue with Apple")
                }
            }.navigationBarBackButtonHidden(true )
//        }
    }
}

