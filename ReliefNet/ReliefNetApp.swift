//
//  ReliefNetApp.swift
//  ReliefNet
//
//  Created by Ayush Singh on 27/09/25.
//
import SwiftUI
import FirebaseCore
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

    @AppStorage("userType") private var storedUserType: String = "Patient"
    @AppStorage("isLoggedIn") private var storedIsLoggedIn: Bool = false
    @AppStorage("roleSelected") private var storedRoleSelected: Bool = false

    @Published var userType: String = "Patient"
    @Published var isLoggedIn: Bool = false
    @Published var roleSelected: Bool = false
//    @Published var signedIn: Bool = false

    @Published var currentDoctor: Doctor? = nil
    @Published var currentPatient: Patient? = nil
    @Published var selectedTab: TabsView.Tab = .home
    init() {
        let defaults = UserDefaults.standard
        userType = defaults.string(forKey: "userType") ?? "Patient"
        isLoggedIn = defaults.bool(forKey: "isLoggedIn")
        roleSelected = defaults.bool(forKey: "roleSelected")
    }

    func login(as type: String) {
        userType = type
        isLoggedIn = true
        roleSelected = true

        storedUserType = type
        storedIsLoggedIn = true
        storedRoleSelected = true
    }

    func logout() {
        isLoggedIn = false
        roleSelected = false

        storedIsLoggedIn = false
        storedRoleSelected = false
    }
}

//App Delegate for Firebase Auth

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

// MARK: - Main App

@main
struct ReliefNetApp: App {
    
    @StateObject private var session = UserSession()
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                RootView().environmentObject(session)
            }
        }
    }
}

// MARK: - Root View

struct RootView: View {

    @EnvironmentObject var session: UserSession

    var body: some View {

        if !session.roleSelected {
            RoleSelectionView()

        } else if !session.isLoggedIn {

            if session.userType == "Doctor" {
                DoctorLoginView()
            } else {
                PatientLoginView()
            }

        } else {
            TabsView()
        }
    }
}
