//
//  ReliefNetApp.swift
//  ReliefNet
//
//  Created by Ayush Singh on 27/09/25.
//
import SwiftUI
import FirebaseCore
import Combine
import GoogleSignIn

//App Delegate for Firebase Auth

class AppDelegate: NSObject, UIApplicationDelegate {

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {

        FirebaseApp.configure()
        return true
    }

    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {

        return GIDSignIn.sharedInstance.handle(url)
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
//            LocationView()
                RootView()
            }.environmentObject(session)
        }
    }
}

// MARK: - Root View


