//
//  FirebaseViewModel.swift
//  JobsApp
//
//  Created by Artur Lauer on 24.01.24.
//

import Foundation
import Firebase
import FirebaseAuth

class FirebaseViewModel: ObservableObject{
    
    init() {
            checkAuth()
        }
    
    private var auth = Auth.auth()
    
    @Published var user: User?
    
    var userIsLoggedIn: Bool {
        user != nil
    }
    
    // Auth Funktionen
    
    private func checkAuth() {
        
        guard let currentUser = auth.currentUser else {
            print("Not logged in")
            return
        }
        
        self.user = currentUser
    }
    
    // Anmelden mit Email & Passwort
    
    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { authResult, error in
            if let error {
                print("Login failed:", error.localizedDescription)
                return
            }
            
            guard let authResult, let email = authResult.user.email else { return }
            print("User with email '\(email)' is logged in with id '\(authResult.user.uid)'")
            
            self.user = authResult.user
        }
    }
    
    // Registrieren mit Email & Passwort
    
    func signUp(email: String, password: String) {
        auth.createUser(withEmail: email, password: password) { authResult, error in
            if let error {
                print("Registration failed:", error.localizedDescription)
                return
            }
            
            guard let authResult, let email = authResult.user.email else { return }
            print("User with email '\(email)' is registered with id '\(authResult.user.uid)'")
            
            // Nach der Registrierung möchten wir unseren User auch direkt anmelden.
            // Dazu können wir einfach die login()-Funktion aufrufen und E-Mail und Passwort weitergeben
            self.signIn(email: email, password: password)
        }
    }
    
    func logout() {
        do {
            try auth.signOut()
            self.user = nil
            
            print("User wurde abgemeldet!")
        } catch {
            print("Error signing out: ", error.localizedDescription)
        }
    }
    
}


