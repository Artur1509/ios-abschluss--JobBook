//
//  JobsAppApp.swift
//  JobsApp
//
//  Created by Artur Lauer on 22.01.24.
//
//
import SwiftUI
import Firebase

@main
struct JobsAppApp: App {
    @StateObject private var firebaseViewModel: FirebaseViewModel = .shared
    
    init() {
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            if firebaseViewModel.userIsLoggedIn {
                TabView {
                    HomeView()
                        .environmentObject(firebaseViewModel)
                        .tabItem {
                            Label("Suche", systemImage: "magnifyingglass")
                        }
                    
                    // Füge hier weitere Views für die anderen Tabs hinzu
                    Text("Tab 2")
                        .tabItem {
                            Label("Favoriten", systemImage: "heart")
                        }
                    
                    ProfileView()
                        .environmentObject(firebaseViewModel)
                        .tabItem {
                            Label("Profil", systemImage: "person")
                        }
                }
                .accentColor(Color("Primary"))
            }
            else {
                LoginView()
                    .environmentObject(firebaseViewModel)
            }
        }
    }
}

