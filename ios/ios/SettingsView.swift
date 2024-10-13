//
//  SettingsView.swift
//  ios
//
//  Created by Yan on 18.09.2024.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @EnvironmentObject var userSession: UserSession
    
    var body: some View {
        VStack {
            Text("Settings")
                .font(.largeTitle)
                .bold()
                .padding()
                
            if let currentUser = userSession.currentUser {
                Text("Welcome, \(currentUser.username)!")
                    .font(.headline)
                    .padding(.top, 20)
            } else {
                Text("User not logged in!")
                    .font(.headline)
                    .padding(.top, 20)
            }
                
            Toggle(isOn: $themeManager.isDarkMode) {
                Text("Dark mode")
                    .font(.headline)
            }
            .padding()
            
            Spacer()

            VStack {
                Text("Follow us on")
                    .font(.subheadline)
                
                HStack(spacing: 20) {
                    Link(destination: URL(string: "https://github.com/holoapp-dev")!) {
                        Image(systemName: "link.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.blue)
                    }
                }
            }
            .padding(.bottom, 50)
        }
        .navigationTitle("Settings")
        .padding()
    }
}
