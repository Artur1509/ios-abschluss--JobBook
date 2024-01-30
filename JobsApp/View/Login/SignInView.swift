//
//  SignInView.swift
//  JobsApp
//
//  Created by Artur Lauer on 22.01.24.
//

import SwiftUI

struct SignInView: View {
    
    @State private var emailAddress = ""
    @State private var password = ""
    @State private var isSignUpActive = false
    
    @EnvironmentObject private var firebaseViewModel : FirebaseViewModel
    
    var body: some View {
        
        VStack {
            
            // Logo
            Image("logo_1")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 100)
            
            // Title Text
            Text("Anmelden")
                .font(.title)
            
            Spacer()
            
            // Eingabe der Email
            
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
            
            // Anmelden Button
            Button(action: {firebaseViewModel.signIn(email: emailAddress, password: password)} ) {
                Text("Anmelden")
                    .frame(width: 280, height: 56)
                    .foregroundColor(Color.white)
                    .background(
                        RoundedRectangle(cornerRadius: 100)
                            .stroke(Color("Primary"), lineWidth: 2)
                            .fill(Color("Primary"))
                    )
                
            }
            .padding()
            
            // Infotext
            Text("Noch kein Benutzerkonto vorhanden?")
                .multilineTextAlignment(.center)
            
            // Zum Registrierungsvorgang Button
            Button(action: {isSignUpActive = true} ) {
                
                Text("Neues Benutzerkonto erstellen →")
                    .foregroundColor(Color("Primary"))
            }
            .navigationDestination(
                isPresented: $isSignUpActive) {
                    SignUpView()
                    
                }
            
            Spacer()
            
        }
        
        
        
    }
}

#Preview {
    SignInView()
}
