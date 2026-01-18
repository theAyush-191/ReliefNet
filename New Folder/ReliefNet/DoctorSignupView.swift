//
//  DoctorSignupView.swift
//  ReliefNet
//
//  Created by Ayush Singh on 04/12/25.
//



import SwiftUI

// --- 1. Data Model for Professional Role ---
enum ProfessionalRole: String, CaseIterable, Identifiable {
    case psychologist = "Psychologist"
    case therapist = "Therapist"
    case psychiatrist = "Psychiatrist"
    case counselor = "Counselor"
    case clinicalPsychologist = "Clinical Psychologist"
    case mentalHealthSpecialist = "Mental Health Specialist"
    
    var id: String { self.rawValue }
}

// --- 2. Main View ---
struct DoctorSignupView: View {
    // State variables for user input
    @State private var fullName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var phoneNumber: String = ""
    @State private var selectedRole: ProfessionalRole = .counselor
    @State private var instituteName: String = ""
    
    var isFormValid : Bool {
        !fullName.isEmpty && !email.isEmpty && !password.isEmpty && !phoneNumber.isEmpty && !instituteName.isEmpty
    }
    
    @State var isLoading : Bool = false
    @State var showVerificationSheet = false
    
    @EnvironmentObject var session : UserSession
    @Environment(\.dismiss) var dismiss

    
    var body: some View {
        ZStack {
            Image("appBG").resizable()
                .ignoresSafeArea()
            
     
                VStack(spacing: 15) {
                    
                    // --- Header Section (ReliefNet Logo and Title) ---
                    VStack(spacing: 5) {
//                       
//                        HeaderView()
//                            .padding(.bottom, 30)
 
                        Text("Sign In as Doctor")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Text("Join Our Network of Healthcare Professionals")
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                    }
                    
                    // --- Personal Information Section ---
                    VStack(alignment: .leading, spacing: 10) {
                        // "Personal Information" Header
                        Text("Personal Information")
                            .font(.headline)
                            .bold()
                            .foregroundColor(.customPink)
                            .padding(.bottom, 5)
                        
                        
                        CustomTextField(hint: "Full Name", icon: "person", text: $fullName, keyboard: .default, isSecure: false)
                        
                        CustomTextField(hint: "email@domain.com", icon: "envelope", text: $email, keyboard: .emailAddress, isSecure: false)
                        
                        CustomTextField(hint: "Password",icon: "key", text: $password, keyboard: .default, isSecure: true)
                            
                        
                        CustomTextField(hint: "Phone Number", icon: "phone.fill", text: $phoneNumber, keyboard: .numberPad, isSecure: false)
               
                    }
                    .padding(.horizontal, 25) // Reduced horizontal padding slightly

                    // --- Professional Information Section ---
                    VStack(alignment: .leading, spacing: 10) {
                        // "Professional Information" Header
                        Text("Professional Information")
                            .font(.headline)
                            .bold()
                            .foregroundColor(.customPink)
                            .padding(.bottom, 5)
                        
                        // Role Selection (Picker/Menu mimicking the image style)
                        CustomRoleMenu(selectedRole: $selectedRole, primaryColor: Color("customPink"))
                        
                        CustomTextField(hint: "Hospital / Institute Name", icon: "building", text: $instituteName, keyboard: .default, isSecure: false)
                        
                    }
                    .padding(.horizontal, 25)
                    
                    // --- Register Button ---
                    Button{
                        Task{
                            isLoading = true
                            do{
                                try await AuthenticationManager.shared.createUser(email: email, password: password)
                                
                                session.login(as: "Doctor")
                                showVerificationSheet = true
                            }catch{
                                print(error.localizedDescription)
                            }
                            isLoading = false
                        }
                    }
                    label:{
                        CustomButton(loader: isLoading, text: "Register", formValid: isFormValid)
                    }
                    .padding(.horizontal, 25)
                    .padding(.vertical, 20)
                    .sheet(isPresented: $showVerificationSheet) {
                        EmailVerificationSheet()
                    }
                }
            
        }
    }
}

//// --- 3. Custom Reusable TextField Style ---
//struct CustomSignupTextField: View {
//    var placeholder: String
//    @Binding var text: String
//    var keyboardType: UIKeyboardType = .default
//    
//    var body: some View {
//        TextField(placeholder, text: $text)
//            .padding(.vertical, 12) // Smaller vertical padding for compact look
//            .padding(.horizontal, 15)
//            .background(Color.white)
//            .cornerRadius(8)
//            .font(.body) // Using .body font size
//            .keyboardType(keyboardType)
//    }
//}
//
//// --- 4. Custom Reusable SecureField Style ---
//struct CustomSignupSecureField: View {
//    var placeholder: String
//    @Binding var text: String
//    
//    var body: some View {
//        SecureField(placeholder, text: $text)
//            .padding(.vertical, 12)
//            .padding(.horizontal, 15)
//            .background(Color.white)
//            .cornerRadius(8)
//            .font(.body)
//    }
//}

// --- 5. Custom Role Menu (mimics dropdown field) ---
struct CustomRoleMenu: View {
    @Binding var selectedRole: ProfessionalRole
    var primaryColor: Color
    
    var body: some View {
        Menu {
            ForEach(ProfessionalRole.allCases) { role in
                Button(role.rawValue) {
                    selectedRole = role
                }
            }
        } label: {
            HStack {
                Text(selectedRole.rawValue)
                    .foregroundColor(.black)
                Spacer()
                Image(systemName: "chevron.down")
                    .foregroundColor(primaryColor)
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 15)
            .background(Color.white)
            .cornerRadius(8)
            .font(.body)
        }
    }
}

// --- 6. Preview ---
#Preview {
    DoctorSignupView().environmentObject(UserSession())
}
