//
//  FavoritesView.swift
//  JobsApp
//
//  Created by Artur Lauer on 12.03.24.
//

import SwiftUI

struct FavoritesView: View {
    
    @StateObject private var firebaseViewModel = FirebaseViewModel()
    @StateObject private var jobsViewModel = JobsViewModel()
    
    var body: some View {
        
        VStack {
            Button(action: {firebaseViewModel.fetchFavorites()}) {
                Text("Fetch")
            }
            
            Button(action: {print(firebaseViewModel.jobRefNumbers)}) {
                Text("Print")
            }
        }
    }
}

#Preview {
    FavoritesView()
}
