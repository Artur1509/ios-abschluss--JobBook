//
//  SearchBar.swift
//  JobsApp
//
//  Created by Artur Lauer on 04.02.24.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    var placeholder: String
    var onCommit: () -> Void
    var searchImageName: String 
    
    var body: some View {
        HStack {
            Image(systemName: searchImageName)
                .foregroundColor(Color("Primary"))
                .padding(.leading, 8)
            
            TextField(placeholder, text: $text, onCommit: onCommit)
                .padding(7)
                .padding(.horizontal, 10)
                .background(Color(.systemGray6))
                .cornerRadius(8)
            
            Button(action: {
                text = ""
                onCommit()
            }) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(Color("Primary"))
                    .padding(.trailing, 10)
            }
            .opacity(text.isEmpty ? 0 : 1)
        }
    }
}


#Preview {
    SearchBar(text: .constant(""), placeholder: "Search", onCommit: {}, searchImageName: "magnifyingglass")
}
