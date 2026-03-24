//
//  iOS_Firebase_Auth_FlowApp.swift
//  iOS-Firebase-Auth-Flow
//
//  Created by Amel Sbaihi on 3/23/26.
//

import SwiftUI
import Firebase
import FirebaseAuth

@main
struct iOS_Firebase_Auth_FlowApp: App {
    @State var authManager: AuthenticationManager
    init () {
        FirebaseApp.configure()
        _authManager = State(initialValue: AuthenticationManager())
    }
    var body: some Scene {
        WindowGroup {
         RootView()
                .environment( authManager)
        }
    }
}
