//
//  JobsAppApp.swift
//  JobsApp
//
//  Created by Artur Lauer on 22.01.24.
//

import SwiftUI
import Firebase

@main
struct JobsAppApp: App {
    
    @StateObject private var firebaseViewModel = FirebaseViewModel()
    
    init() {
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            if firebaseViewModel.userIsLoggedIn {
                HomeView()
                    .environmentObject(firebaseViewModel)
            }
            else {
                LoginView()
                    .environmentObject(firebaseViewModel)
            }
        }
    }
}
