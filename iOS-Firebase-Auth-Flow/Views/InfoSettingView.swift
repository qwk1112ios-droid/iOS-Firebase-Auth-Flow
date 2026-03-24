//
//  InfoSettingView.swift
//  iOS-Firebase-Auth-Flow
//
//  Created by Amel Sbaihi on 3/24/26.
//

import SwiftUI

struct InfoSettingView: View {
    @Environment(AuthenticationManager.self) var authManager
    
    var body: some View {
        NavigationStack {
            ZStack {
                Text("user info 📲 👥")
            }

            .navigationTitle("Info&Settings")
            .navigationBarTitleDisplayMode(.inline)
        }

    }
}

#Preview {
    InfoSettingView()
        .environment(AuthenticationManager())

}
