//
//  Settings.swift
//  AmericanoChallenge
//
//  Created by Michele Barbato on 10/12/24.
//


import SwiftUI

struct SettingsView: View {
    @State private var isVoiceOverEnabled = false

    var body: some View {
        NavigationView {
            List {
                // Preferences Section
                Section {
                    NavigationLink(destination: AppIconView()) {
                        HStack {
                            Image(systemName: "app.fill") // Replace with your custom icon
                                .foregroundColor(.gray)
                            Text("Theme")
                                .font(.custom("basis33", size: 20))
                        }
                    }
                    
                    NavigationLink(destination: StickView()) {
                        HStack {
                            Image(systemName: "figure.run")
                                .foregroundColor(.gray)
                            Text("Skin")
                                .font(.custom("basis33", size: 20))
                        }
                    }
                    
                    Toggle(isOn: $isVoiceOverEnabled) {
                        HStack {
                            Image(systemName: "speaker.wave.3.fill")
                                .foregroundColor(.gray)
                            Text("VoiceOver")
                                .font(.custom("basis33", size: 20))
                        }
                    }
                }
                
            }
            .navigationTitle("Settings")
        }
    }
}

// Placeholder views for navigation destinations
struct AppIconView: View { var body: some View { Text("App Icon Settings").font(.custom("basis33", size: 20)) } }
struct AppearanceView: View { var body: some View { Text("Appearance Settings").font(.custom("basis33", size: 20)) } }

#Preview {
    SettingsView()
}

