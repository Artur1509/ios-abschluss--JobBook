//
//  HomeView.swift
//  JobsApp
//
//  Created by Artur Lauer on 24.01.24.
//

import SwiftUI

struct HomeView: View {
    
    
    var body: some View {
        
        Button(action: {firebaseViewModel.logout()} ) {
            
            Text("Ausloggen →")
                .foregroundColor(Color("Primary"))
        }
        
    }
    
    @EnvironmentObject private var firebaseViewModel: FirebaseViewModel

}

#Preview {
    HomeView()
}
