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

    var body: some View {
        HStack {
            TextField(placeholder, text: $text, onCommit: onCommit)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 10)
                .padding(.vertical, 10)
            
            Button(action: {
                text = ""
                onCommit()
            }) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.gray)
                    .padding(.trailing, 10)
            }
        }
    }
}

#Preview {
    SearchBar(text: .constant(""), placeholder: "Search", onCommit: {})
}
