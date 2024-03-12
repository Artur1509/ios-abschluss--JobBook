//
//  FirebaseViewModel.swift
//  JobsApp
//
//  Created by Artur Lauer on 24.01.24.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

class FirebaseViewModel: ObservableObject {
    
    @Published var jobRefNumbers = [String]()
    @Published var favorites = [JobDetails]()
    
    private var auth = Auth.auth()
    @Published var user: User?
    private var db = Firestore.firestore()
    
    init() {
        checkAuth()
    }
    
    // Ist Nutzer eingeloggt?
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
            if let error = error {
                print("Login failed:", error.localizedDescription)
                return
            }
            
            guard let authResult = authResult, let email = authResult.user.email else { return }
            print("User with email '\(email)' is logged in with id '\(authResult.user.uid)'")
            
            self.user = authResult.user
        }
    }
    
    // Registrieren mit Email & Passwort
    
    func signUp(email: String, password: String) {
        auth.createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Registration failed:", error.localizedDescription)
                return
            }
            
            guard let authResult = authResult, let email = authResult.user.email else { return }
            print("User with email '\(email)' is registered with id '\(authResult.user.uid)'")
            
            // Anmeldung sollte nicht automatisch erfolgen
        }
    }
    
    // Ausloggen
    
    func logout() {
        do {
            try auth.signOut()
            self.user = nil
            print("User wurde abgemeldet!")
        } catch {
            print("Error signing out: ", error.localizedDescription)
        }
    }
    
    // Favorit hinzufügen
    
    func addFavorite(job: JobDetails) {
        guard let userEmail = user?.email else {
            print("User not logged in.")
            return
        }
        
        let data: [String: Any] = [
            "refnr": job.refnr ?? ""
        ]
        
        let docRef = db.collection("users").document(userEmail).collection("favorites").document(job.refnr ?? "")
        
        docRef.setData(data) { error in
            if let error = error {
                print("Error uploading data: \(error.localizedDescription)")
            } else {
                print("Data uploaded successfully!")
            }
        }
    }
    
    // Favorit entfernen
    
    func removeFavorite(jobRefnr: String) {
        guard let userEmail = user?.email else {
            print("User not logged in.")
            return
        }
        
        let docRef = db.collection("users").document(userEmail).collection("favorites").document(jobRefnr)
        
        docRef.delete { error in
            if let error = error {
                print("Error deleting document: \(error.localizedDescription)")
            } else {
                print("Document successfully deleted!")
            }
        }
    }
    
    // Prüfe ob in Favoriten vorhanden
    
    func isFavorite(jobRefnr: String, completion: @escaping (Bool) -> Void) {
        guard let userEmail = user?.email else {
            completion(false)
            return
        }
        
        let docRef = db.collection("users").document(userEmail).collection("favorites").document(jobRefnr)
        
        docRef.getDocument { document, error in
            if let error = error {
                print("Error getting document: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            guard let document = document, document.exists else {
                completion(false)
                return
            }
            
            completion(true)
        }
    }
    
    func fetchFavorites() {
        guard let userEmail = user?.email else {
            print("User not logged in.")
            return
        }
        
        db.collection("users").document(userEmail).collection("favorites").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching jobs: \(error.localizedDescription)")
                return
            }
            
            guard let documents = snapshot?.documents else {
                print("No documents found")
                return
            }
            
            self.jobRefNumbers = documents.compactMap { snapshot in
                let data = snapshot.data()
                return data["refnr"] as? String
            }
        }
    }

    
}

extension FirebaseViewModel {
    static let shared = FirebaseViewModel()
}
