//
//  InfoSettingView.swift
//  iOS-Firebase-Auth-Flow
//
//  Created by Amel Sbaihi on 3/24/26.
//

import FirebaseAuth
import SwiftUI

struct InfoSettingView: View {
    @Environment(AuthenticationManager.self) var authManager
    @State var showWelcomeView: Bool = false

    var body: some View {
        NavigationStack {

            ZStack {
                FluidModernBackground()
                VStack {
                    if authManager.authState == .authenticated {
                        Text(
                            "user: \(authManager.user?.uid ?? "Anonymous User")"
                        )
                        .font(.headline)
                        .padding()
                        
                        Button {
                            handleSignOut()
                        } label: {
                            HStack(spacing: 4) {
                                Text("SignOut demo only")
                                    .font(.body.bold())
                                
                                Text("- not functional")
                                    .font(.footnote)
                                    .foregroundStyle(.white.opacity(0.7))
                                
                            }
                            .foregroundStyle(Color.white)
                            .frame(width: 260, height: 45)
                            .background(Color.appButton)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(
                                        Color.white.opacity(0.25),
                                        lineWidth: 1
                                    )
                            )
                        }
                        
                        
                        Button {
                            // signIn
                            showWelcomeView = true
                            
                        } label: {
                            HStack(spacing: 4) {
                                Text("SignIn")
                                    .font(.body.bold())
                                
                                
                            }
                            .foregroundStyle(Color.white)
                            .frame(width: 260, height: 45)
                            .background(Color.appButton)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(
                                        Color.white.opacity(0.25),
                                        lineWidth: 1
                                    )
                            )
                        }
                    }
                    
                    if authManager.authState == .signedIn {
                       Text("Successfully SignedIn ")
                            .font(.headline)
                            .padding()
                        
                        Button {
                           // Simulate SignOut
                            authManager.authState = .signedOut
                        } label: {
                            HStack(spacing: 4) {
                                Text("SignOut")
                                    .font(.body.bold())
                                }
                            .foregroundStyle(Color.white)
                            .frame(width: 260, height: 45)
                            .background(Color.appButton)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(
                                        Color.white.opacity(0.25),
                                        lineWidth: 1
                                    )
                            )
                        }
                            
                    }
                }

            }.sheet(isPresented: $showWelcomeView) {
                WelcomePageView()
            }
            }

            .navigationTitle("Info&Settings")
            .navigationBarTitleDisplayMode(.inline)
        }

    

    //MARK: -SignOut
    func handleSignOut() {
        do {
            try authManager.signOut()

        } catch {
            print("error")
        }
    }
}

#Preview {
    InfoSettingView()
        .environment(AuthenticationManager())

}
