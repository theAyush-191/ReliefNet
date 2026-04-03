import SwiftUI
import FirebaseAuth
import Combine

// MARK: - App Tabs
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

// MARK: - User Session
class UserSession: ObservableObject {

    // Persisted
    @AppStorage("userType") private var storedUserType: String = UserType.patient.rawValue
    @AppStorage("roleSelected") private var storedRoleSelected: Bool = false

    // App State
    @Published var userType: UserType = .patient {
        didSet { storedUserType = userType.rawValue }
    }
    
    @Published var roleSelected: Bool = false {
        didSet { storedRoleSelected = roleSelected }
    }
    
    @Published var selectedTab: Tab = .home

    // Firebase Auth State (REAL SOURCE)
    @Published var isLoggedIn: Bool = false

    private var authListener: AuthStateDidChangeListenerHandle?

    init() {
        let defaults = UserDefaults.standard
        
        // Restore role
        let typeString = defaults.string(forKey: "userType") ?? UserType.patient.rawValue
        userType = UserType(rawValue: typeString) ?? .patient
        roleSelected = defaults.bool(forKey: "roleSelected")

        // Listen to Firebase login state
        listenToAuthChanges()
    }

    // MARK: - Firebase Auth Listener
    func listenToAuthChanges() {
        authListener = Auth.auth().addStateDidChangeListener { _, user in
            DispatchQueue.main.async {
                self.isLoggedIn = user != nil
            }
        }
    }

    // MARK: - Role Selection
    func selectRole(_ type: UserType) {
        userType = type
        roleSelected = true
    }

    // MARK: - Logout
    func logout() {
        try? Auth.auth().signOut()
        userType = .patient
        roleSelected = false
        selectedTab = .home
    }
}
