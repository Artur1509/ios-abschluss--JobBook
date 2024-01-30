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
    
    @StateObject private var firebaseViewModel = FirebaseViewModel()
    
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
            Button(action: {checkPasswordAndSignUp(password1: password, password2: repeatPassword) } ) {
                
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
    
    private func checkPasswordAndSignUp(password1: String, password2: String) {
        
        if password1 == password2 {
            firebaseViewModel.signUp(email: emailAddress, password: password)
        }
        else {
            print("Error, Passwort falsch.")
        }
    }
}

#Preview {
    SignUpView()
}
