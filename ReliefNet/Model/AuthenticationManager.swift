// AuthenticationManager.swift

import FirebaseAuth

final class AuthenticationManager {

    static let shared = AuthenticationManager()
    private init() {}

    // MARK: - Sign Up
    func createUser(email: String, password: String) async throws {
        let result = try await Auth.auth().createUser(withEmail: email, password: password)
        try await result.user.sendEmailVerification()
    }

    // MARK: - Sign In
    func signIn(email: String, password: String) async throws -> Bool {
        let result = try await Auth.auth().signIn(withEmail: email, password: password)

        // VERY IMPORTANT
        try await result.user.reload()

        return result.user.isEmailVerified
    }

    // MARK: - Sign Out
    func signOut() throws ->Bool {
        try Auth.auth().signOut()
        return Auth.auth().currentUser == nil
        
    }
    
    func forgotPassword(email:String ) async throws{
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
    // MARK: - Current User
    var currentUser: User? {
        Auth.auth().currentUser
    }
}
