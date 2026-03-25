//
//  AuthenticationManager.swift
//  iOS-Firebase-Auth-Flow
//
//  Created by Amel Sbaihi on 3/23/26.
//

import FirebaseAuth
import Foundation

enum AuthState {
    case authenticated
    case signedIn
    case signedOut
}

@MainActor
@Observable class AuthenticationManager {
    var authState: AuthState = .signedOut
    var user: User?
    var handleAppState: AuthStateDidChangeListenerHandle!

    init() {
        configureAuthStateChanges()
    }

}

extension AuthenticationManager {

    // MARK: - Auth State Updates Listner
    // State Listner function
    func configureAuthStateChanges() {
        handleAppState = Auth.auth().addStateDidChangeListener { (auth, user) in
            print(
                "user is \(user, default: "No user found") status have been updated "
            )
            self.updateUser(for: user)
        }
    }
    // update User
    func updateUser(for user: User?) {
        self.user = user
        let isAuthenticated = user != nil
        let isAnonymous = user?.isAnonymous ?? false
        if isAuthenticated {
            self.authState = isAnonymous ? .authenticated : .signedIn
        } else {
            self.authState = .signedOut

        }

    }
}

extension AuthenticationManager{
    
    // MARK: - Auth State Updates Listner
    // SignIn Anonymously function
    func signInAnonymously() async throws -> AuthDataResult {
        let result = try await Auth.auth().signInAnonymously()
        print("FirebaseAuthSuccess: Sign in anonymously, UID: \(result.user.uid)")
        return result
    }
}
