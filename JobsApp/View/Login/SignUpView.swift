//
//  SignUpView.swift
//  JobsApp
//
//  Created by Artur Lauer on 22.01.24.
//

import SwiftUI

struct SignUpView: View {
    
    @State private var emailAddress = ""
    @State private var password = ""
    @State private var repeatPassword = ""
    @State private var isSignUpActive = false
    
    var body: some View {
        VStack {
            // Logo
            Image("logo_1")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 100)
            
            Text("Registrieren")
                .font(.title)
            
            Spacer()
            
            
            TextField("E-Mail", text: $emailAddress)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
                .padding(.horizontal)
            
            // Eingabe Passwort
            SecureField("Passwort", text: $password)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
                .padding(.horizontal)
            
            // Eingabe Passwort wiederholen
            SecureField("Passwort wiederholen", text: $repeatPassword)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
                .padding(.horizontal)
            
            // Sign up Button
            Button(action: {isSignUpActive = true} ) {
                
                Text("Registrieren")
                    .frame(width: 280, height: 56)
                    .foregroundColor(Color.white)
                    .background(
                        RoundedRectangle(cornerRadius: 100)
                            .stroke(Color("Primary"), lineWidth: 2)
                            .fill(Color("Primary"))
                    )
                
            }
            .padding()
            .navigationDestination(
                isPresented: $isSignUpActive) {
                    
                }
            
            Spacer()
        }
    }
}

#Preview {
    SignUpView()
}
