//
//  ProfileView.swift
//  JobsApp
//
//  Created by Artur Lauer on 20.02.24.
//

import SwiftUI

struct ProfileView: View {
    
    var anredeAuswahl = ["Herr", "Frau", "Keine Angabe"]
    
    @State var vorname = ""
    @State var name = ""
    @State var anrede = "Keine Angabe"
    @State var geburtsDatum = Date()
    
    var body: some View {
        
        NavigationView {
            Form {
                Section(header: Text("Persönliche Angaben")){
                    
                    Picker("Anrede:", selection: $anrede) {
                        ForEach(anredeAuswahl, id : \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.menu)
                    
                    TextField("Vorname:", text: $vorname)
                    TextField("Name:", text: $name)
                    
                    
                }
                
                Section(header: Text("Profilaktionen")) {
                    
                    Button(action: {firebaseViewModel.saveProfile(anrede: anrede, vorname: vorname, name: name)}) {
                        Text("Angaben Speichern")
                    }
                    
                    Button(action: {firebaseViewModel.logout()}) {
                        Text("Ausloggen")
                    }
                }
            }
            .navigationTitle("Profil")
        }
        
        
        
        
    }
    
    @EnvironmentObject private var firebaseViewModel: FirebaseViewModel
}


#Preview {
    ProfileView()
}
