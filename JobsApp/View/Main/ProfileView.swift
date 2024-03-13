//
//  ProfileView.swift
//  JobsApp
//
//  Created by Artur Lauer on 20.02.24.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        
        Button(action: {firebaseViewModel.logout()}) {
            Text("Ausloggen")
        }
        
    }
    
    @EnvironmentObject private var firebaseViewModel: FirebaseViewModel
}


#Preview {
    ProfileView()
}
