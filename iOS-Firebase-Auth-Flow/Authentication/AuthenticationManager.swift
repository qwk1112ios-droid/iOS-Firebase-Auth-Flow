//
//  AuthenticationManager.swift
//  iOS-Firebase-Auth-Flow
//
//  Created by Amel Sbaihi on 3/23/26.
//

import FirebaseAuth
import Foundation
import GoogleSignIn

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

extension AuthenticationManager {

    // MARK: - SignIn Anonymously
    // SignIn Anonymously function
    func signInAnonymously() async throws -> AuthDataResult {
        let result = try await Auth.auth().signInAnonymously()
        print(
            "FirebaseAuthSuccess: Sign in anonymously, UID: \(result.user.uid)"
        )
        return result
    }
}

extension AuthenticationManager {

    // MARK: - SignOut
    // SignOut Function
    func signOut() throws {
        if Auth.auth().currentUser != nil {
            do {
                // TODO: Sign out from signed-in Provider.
                try Auth.auth().signOut()
            } catch let error as NSError {
                print(
                    "FirebaseAuthError: failed to sign out from Firebase, \(error)"
                )
                throw error
            }
        }
    }
}

extension AuthenticationManager {

    // MARK: - Credential Auth
    // Authenticate User
    func authenticateUser(credential: AuthCredential) async throws
        -> AuthDataResult
    {
        if Auth.auth().currentUser != nil {
            return try await authLink(with: credential)!
        } else {
            return try await authSignIn(with: credential)
        }
    }
    // if anonymously signed in then link to provider account
    func authLink(with credentials: AuthCredential) async throws
        -> AuthDataResult?
    {
        do {
            guard let user = Auth.auth().currentUser else { return nil }
            let result = try await user.link(with: credentials)
            // await updateDisplayName(for: result.user)
            updateUser(for: result.user)
            return result
        } catch {
            print("FirebaseAuthError: signIn(with:) failed. \(error)")
            throw error
        }
    }
    // else just signe In provider User to firebase
    func authSignIn(with credentials: AuthCredential) async throws
        -> AuthDataResult
    {

        do {
            let result = try await Auth.auth().signIn(with: credentials)
            updateUser(for: result.user)
            return result
        } catch {
            print("FirebaseAuthError: signIn(with:) failed. \(error)")
            throw error
        }

    }
}

extension AuthenticationManager {
    // MARK: - Google SignIn and SignOut
    // google Auth
    func googleAuth(_ user: GIDGoogleUser) async throws -> AuthDataResult? {
        // get idToken from google provider
        guard let idToken = user.idToken?.tokenString else {
            fatalError("Google idToken is nil")
        }
        // create credential from token
        let credential = GoogleAuthProvider.credential(
            withIDToken: idToken,
            accessToken: user.accessToken.tokenString
        )

        do {
            return try await authenticateUser(credential: credential)
        } catch {
            print("FirebaseAuthError: googleAuth(user:) failed. \(error)")
            throw error
        }

    }
}
