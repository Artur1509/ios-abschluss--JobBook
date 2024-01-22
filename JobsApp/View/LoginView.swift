//
//  LoginView.swift
//  JobsApp
//
//  Created by Artur Lauer on 22.01.24.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        
        Circle()
            .fill(Color("Primary"))
            .frame(width: 800, height: 600)
            .padding(.top, -440)
            .padding(.leading, -440)
        
        VStack {
            Image("logo_1")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 300)
                
            
            Spacer()
            
            Button(action: greeting ) {
                
                Text("Anmelden")
                    .frame(width: 280, height: 56)
                    .foregroundColor(Color("Secondary"))
                    .background(
                        RoundedRectangle(cornerRadius: 100)
                            .stroke(Color("Secondary"), lineWidth: 2)
                            .background(Color.clear)
                    )
                
            }
            .padding(.bottom, 8)
            
            Button(action: greeting ) {
                
                Text("Registrieren")
                    .frame(width: 280, height: 56)
                    .foregroundColor(Color.white)
                    .background(
                        RoundedRectangle(cornerRadius: 100)
                            .stroke(Color("Primary"), lineWidth: 2)
                            .fill(Color("Primary"))
                    )
                
            }
            .padding(.bottom, 160)
            
            Spacer()
            
        }
        Spacer()
        
        Circle()
            .fill(Color("Secondary"))
            .frame(width: 800, height: 600)
            .padding(.bottom, -440)
            .padding(.trailing, -400)
            
            
    }
}

func greeting() {
    print("Test")
}

#Preview {
    LoginView()
}
