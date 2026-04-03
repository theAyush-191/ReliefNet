
import SwiftUI

struct HelpSupportView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    // --- Header ---
                    Text("Help & Support")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top)
                    
                    // --- FAQ Section ---
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Frequently Asked Questions")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        FAQItem(question: "How do I book an appointment?", answer: "Go to the Home tab, select a doctor, and tap on 'Book Appointment'.")
                        FAQItem(question: "How do I cancel a booking?", answer: "Navigate to My Bookings tab, select your booking, and tap 'Cancel'.")
                        FAQItem(question: "How do I reset my password?", answer: "Go to Profile tab and select 'Change Password'.")
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(15)
                    
                    // --- Contact Support ---
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Contact Support")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        HStack {
                            Image(systemName: "envelope.fill")
                                .foregroundColor(.blue)
                            Text("support@reliefnet.com")
                        }
                        
                        HStack {
                            Image(systemName: "phone.fill")
                                .foregroundColor(.green)
                            Text("+91 98765 43210")
                        }
                        
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(15)
                    
                    Spacer()
                }
                .padding()
            }
            .navigationBarBackButtonHidden(false)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// --- FAQ Item Component ---
struct FAQItem: View {
    let question: String
    let answer: String
    
    @State private var isExpanded: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text(question)
                    .fontWeight(.semibold)
                Spacer()
                Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                    .foregroundColor(.gray)
            }
            .onTapGesture {
                withAnimation { isExpanded.toggle() }
            }
            
            if isExpanded {
                Text(answer)
                    .foregroundColor(.gray)
                    .font(.subheadline)
                    .transition(.opacity.combined(with: .slide))
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 2)
    }
}


//#Preview {
//    HelpSupportView().environmentObject(UserSession())
//}
