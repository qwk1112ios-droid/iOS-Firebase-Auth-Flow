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
                    //MARK: -Apple Button
                    //TODO: -ADD Apple Button
                    Text("Sign in to continue 🤗")
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
