//
//  WelcomePageView.swift
//  iOS-Firebase-Auth-Flow
//
//  Created by Amel Sbaihi on 3/23/26.
//

import FirebaseAuth
import SwiftUI

struct WelcomePageView: View {
    @Environment(AuthenticationManager.self) var authManager
    @Environment(\.dismiss) var dismiss 

    var body: some View {
        NavigationStack {
            ZStack {
                FluidModernBackground()
                VStack {
                    Image("security")

                        .resizable()
                        .scaledToFit()
                        .frame(
                            width: 230,
                            alignment: .init(
                                horizontal: .center,
                                vertical: .center
                            )
                        )
                        .foregroundStyle(Color.primaryIcon)
                    Spacer()
                
                    //MARK: -Apple Button
                    //TODO: -ADD Apple Button
                    Button {
                       // simulate SignIn
                        authManager.authState = .signedIn
                        dismiss()

                    } label: {
                        Text("SignIn")
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
                    }.padding()
                    //MARK: -Skip Button
                    if authManager.authState == .signedOut {
                        Button {
                            Task {
                                await handleSignInAnonymously()
                            }

                        } label: {
                            Text("Skip")
                                .font(.body.bold())
                                .foregroundStyle(Color.primaryIcon)
                                .frame(
                                    width: 280,
                                    height: 45,
                                    alignment: .center
                                )
                        }.padding()
                    }
                }
            }.navigationTitle("Welcome")
        }
    }
}
#Preview {
    WelcomePageView()
        .environment(AuthenticationManager())

}

extension WelcomePageView {
    //MARK: -SignIn Anonymously
    // SignInAnonymously funciton
    func handleSignInAnonymously() async {
        do {
            let result = try await authManager.signInAnonymously()
            print("SignInAnonymouslySuccess: \(result.user.uid)")
        } catch {
            print("SignInAnonymouslyError: \(error.localizedDescription)")
        }
    }
}
