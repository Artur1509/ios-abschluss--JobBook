//
//  FavoriteListItem.swift
//  JobsApp
//
//  Created by Artur Lauer on 12.03.24.
//

import SwiftUI

struct FavoriteListItem: View {
    
    var favorite: Favorite
    
    var body: some View {
        
        VStack {
            
            Text(favorite.beruf ?? "")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title2)
                .fontWeight(.bold)
                .padding(4)
                .padding(.horizontal, 4)
            
            Text(favorite.titel ?? "")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 4)
                .padding(4)
            
        }
        
    }
}

#Preview {
    FavoriteListItem(favorite: .init(beruf: "Schreiner", titel: "Schreinereifachkraft (m/w/d)"))
}
