//
//  ReliefNetApp.swift
//  ReliefNet
//
//  Created by Ayush Singh on 27/09/25.
//
import SwiftUI
import Combine
// MARK: - User Session
enum Tab: Hashable {
    case home, discover, booking, chat, profile
    var title: String {
        switch self {
        case .home: return "ReliefNet"
        case .discover: return "Discover"
        case .booking: return "My Bookings"
        case .chat: return "Chats"
        case .profile: return "Profile"
        }
    }
}
// Shared app state: user type, login status, selected role
class UserSession: ObservableObject {
    // MARK: - AppStorage properties
    @AppStorage("userType") private var storedUserType: String = "doctor"
    @AppStorage("isLoggedIn") private var storedIsLoggedIn: Bool = false
    @AppStorage("roleSelected") private var storedRoleSelected: Bool = false

    // MARK: - Published properties (EnvironmentObject)
    @Published var userType: String = "doctor"
    @Published var isLoggedIn: Bool = false
    @Published var roleSelected: Bool = false
    
    @Published var selectedTab: Tab = .home

    init() {
        // Initialize Published properties from UserDefaults directly to avoid accessing
        // @AppStorage (which requires `self`) before initialization is complete.
        let defaults = UserDefaults.standard
        let initialUserType = defaults.string(forKey: "userType") ?? "doctor"
        let initialIsLoggedIn = defaults.object(forKey: "isLoggedIn") as? Bool ?? false
        let initialRoleSelected = defaults.object(forKey: "roleSelected") as? Bool ?? false

        self.userType = initialUserType
        self.isLoggedIn = initialIsLoggedIn
        self.roleSelected = initialRoleSelected
    }

    // MARK: - Methods to update both Published and AppStorage
    func setUserType(_ type: String) {
        userType = type
        storedUserType = type
    }

    func setLoginStatus(_ status: Bool) {
        isLoggedIn = status
        storedIsLoggedIn = status
    }

    func setRoleSelected(_ role: Bool) {
        roleSelected = role
        storedRoleSelected = role
    }
}

// MARK: - Main App

@main
struct ReliefNetApp: App {
    @StateObject private var session = UserSession()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(session) // Inject session globally
        }
    }
}

// MARK: - Root View

struct RootView: View {
    @EnvironmentObject var session: UserSession
    
    var body: some View {
        Group {
            if session.isLoggedIn && session.roleSelected{
                TabsView(startingTab: .home)
                    .environmentObject(session)
                        } else {
                            LoginView()
                                .environmentObject(session)
                        }
        }
    }
}
