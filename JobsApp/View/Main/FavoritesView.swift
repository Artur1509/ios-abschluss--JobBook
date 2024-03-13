//
//  FavoritesView.swift
//  JobsApp
//
//  Created by Artur Lauer on 12.03.24.
//


import SwiftUI

struct FavoritesView: View {
    
    @StateObject private var firebaseViewModel = FirebaseViewModel()
    
    var body: some View {
        NavigationView {
            List(firebaseViewModel.favorites, id: \.refnr) { favorite in
                NavigationLink(destination: JobDetailView(encodedHashId: encodeToBase64(inputString: favorite.refnr!) ?? "")) {
                    FavoriteListItem(favorite: favorite)
                }
            }
            .onAppear {
                firebaseViewModel.fetchFavorites()
            }
        }
    }
}

#Preview {
    FavoritesView()
}
