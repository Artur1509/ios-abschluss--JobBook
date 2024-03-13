//
//  FavoriteButton.swift
//  JobsApp
//
//  Created by Artur Lauer on 14.02.24.
//

import SwiftUI

struct FavoriteButton: View {
    @State private var isFavorited = false // Zustand des Favoriten
    
    var body: some View {
        Button(action: {
            isFavorited.toggle() // Umschalten des Favoritenstatus beim Klicken
        }) {
            Image(systemName: isFavorited ? "heart.fill" : "heart") // Verwende das gefüllte Herzsymbol, wenn favorisiert, sonst das leere Herzsymbol
                .foregroundColor(isFavorited ? Color("Primary") : Color("Secondary")) // Ändere die Farbe basierend auf dem Zustand
                .font(.title2)// Passe die Schriftgröße an
        }
    }
}

#Preview {
    FavoriteButton()
}
