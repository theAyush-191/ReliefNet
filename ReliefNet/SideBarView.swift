import SwiftUI

// MARK: - Model
struct UserProfile {
    var name: String = "Ayush Singh"
    var avatar: Image = Image("profileImage")
}

// MARK: - Sidebar
struct SidebarView: View {
    @Binding var isOpen: Bool
    @State private var profile = UserProfile()
    @State private var isLoading = false
    @State private var errorMessage = ""

    @EnvironmentObject private var session:UserSession
    
    var body: some View {
        ZStack {
            if isOpen {
                HStack {
                    Spacer()
                    VStack {
                        sidebarContent
                            .frame(width: 280)
                            .padding()
                            .background(.white)
                            .cornerRadius(20)
                            .shadow(radius: 10)
                            .transition(.move(edge: .trailing))
                        Spacer()
                    }
                    .padding(.top, 10)
                }
            }
        }
        .animation(.easeInOut, value: isOpen)
        .onChange(of: isOpen) { _, newValue in
            if newValue { fetchProfile() }
        }
    }

    // MARK: - Sidebar Content
    private var sidebarContent: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Header
            HStack {
                Text("Menu")
                    .font(.title2.bold())
                    .foregroundColor(.purple)
                Spacer()
                Button(action: closeSidebar) {
                    Image(systemName: "xmark")
                        .font(.title3)
                        .foregroundColor(.primary)
                }
            }

            // Profile
            ProfileCardView(
                profile: $profile,
                isLoading: $isLoading,
                errorMessage: $errorMessage
            )

            // Simple NavigationLinks for direct navigation
            NavigationLink(destination: TabsView(startingTab: .profile)) {
                SidebarRow(icon: "person.fill", text: "Profile")
            }

            NavigationLink(destination: HelpSupportView()) {
                SidebarRow(icon: "questionmark.circle", text: "Help")
            }
            
            Button(action: {session.setLoginStatus(false)
                session.setRoleSelected(false)}) {
                SidebarRow(icon: "rectangle.portrait.and.arrow.right", text: "Log Out")
            }

        }
    }

    // MARK: - Helpers
    private func fetchProfile() {
        isLoading = true
        errorMessage = ""
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            profile.name = "Ayush Singh"
            isLoading = false
        }
    }

    private func closeSidebar() { isOpen = false }
}

// MARK: - Subviews
struct ProfileCardView: View {
    @Binding var profile: UserProfile
    @Binding var isLoading: Bool
    @Binding var errorMessage: String

    var body: some View {
        VStack(spacing: 12) {
            profile.avatar
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
                .clipShape(Circle())

            Text(profile.name)
                .font(.title3.bold())

            if isLoading {
                ProgressView()
            } else if !errorMessage.isEmpty {
                Text(errorMessage)
                    .font(.caption)
                    .foregroundColor(.red)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.pink.opacity(0.15))
        .cornerRadius(15)
    }
}

struct SidebarRow: View {
    let icon: String
    let text: String
    var action: (() -> Void)? = nil // Keep action optional for NavigationLink usage

    var body: some View {
        // Use a Button if action exists, otherwise just display content
        if let action = action {
            Button(action: action) {
                rowContent
            }
            .foregroundColor(.primary) // Apply to Button
        } else {
            rowContent // Just the HStack for NavigationLink label
        }
    }
    
    // Extracted the common row layout
    private var rowContent: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
            Text(text)
                .font(.headline)
            Spacer()
        }
        .padding(8)
        .background(RoundedRectangle(cornerRadius: 10).fill(.white))
        .shadow(color: .gray.opacity(0.2), radius: 6, y: 4)
        .foregroundColor(.primary) // Apply color here for NavigationLink
    }
}



// MARK: - Preview
struct SidebarPreviewWrapper: View {
    @State private var isSidebarOpen = true
    
    @EnvironmentObject private var session:UserSession
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Text("Main App Content")
                    Button("Open Sidebar") { isSidebarOpen = true }
                }
                .navigationTitle("Dashboard")

                // --- 3. 'onLogout' PARAMETER REMOVED FROM PREVIEW ---
                SidebarView(
                    isOpen: $isSidebarOpen
                   
                )
            }
        }
    }
}



#Preview {
    SidebarPreviewWrapper().environmentObject(UserSession())
}
