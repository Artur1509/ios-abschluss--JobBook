//
//  JobDetailView.swift
//  JobsApp
//
//  Created by Artur Lauer on 15.02.24.
//

import SwiftUI

struct JobDetailView: View {
    
    @StateObject private var jobsViewModel = JobsViewModel()
    @State private var jobDetails: JobDetails?
    let encodedHashId: String
    @State private var isFavorited = false
    
    var body: some View {
        VStack {
            ZStack {
                VStack {
                    
                    Button(action: {
                        toggleFavorite()
                    }) {
                        Image(systemName: isFavorited ? "heart.fill" : "heart")
                            .foregroundColor(isFavorited ? Color("Primary") : Color("Secondary"))
                            .font(.title2)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    
                    if let details = jobDetails {
                        Text(details.arbeitgeber ?? "")
                            .font(.title)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text(details.titel ?? "")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack {
                            HStack {
                                Image(systemName: "mappin.circle")
                                    .foregroundColor(Color("Primary"))
                                    .frame(alignment: .leading)
                                    .padding(.horizontal, 8)
                                    .padding(.trailing, -8)
                                
                                Text("\(details.arbeitgeberAdresse?.plz ?? ""), \(details.arbeitgeberAdresse?.ort ?? "Keine Angabe")")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .padding(.top, 8)
                            HStack {
                                Image(systemName: "play.circle")
                                    .foregroundColor(Color("Primary"))
                                    .frame(alignment: .leading)
                                    .padding(.horizontal, 8)
                                    .padding(.trailing, -8)
                                
                                Text(details.eintrittsdatum?.formatDate2() ?? "")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        
                        Spacer()
                        
                        Button(action: {print("Test")}) {
                            Text("Bewerben")
                            Image(systemName: "square.and.pencil")
                                .foregroundColor(Color("Primary"))
                        }
                        .foregroundStyle(Color("Primary"))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .font(.headline)
                        
                    } else {
                        ProgressView()
                    }
                }
                .padding()
            }
            .frame(maxWidth: .infinity)
            .frame(height: 200)
            .background(Color(.white))
            .shadow(color: Color(.gray), radius: 10)
            .onAppear {
                jobsViewModel.fetchJobDetails(encodedHashId: encodedHashId) { result in
                    switch result {
                    case .success(let details):
                        self.jobDetails = details
                        updateFavoriteStatus()
                    case .failure(let error):
                        print("Fehler beim Laden der Jobdetails: \(error)")
                    }
                }
            }
            
            Spacer()
            
            ScrollView {
                VStack {
                    Text("Stellenbeschreibung")
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, -10)
                    
                    if let details = jobDetails {
                        Text(details.stellenbeschreibung ?? "")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top)
                    } else {
                        ProgressView()
                    }
                }
                .padding()
                
                Spacer()
            }
        }
    }
    
    private func toggleFavorite() {
        isFavorited.toggle()
        if isFavorited {
            FirebaseViewModel.shared.addFavorite(job: jobDetails!)
        } else {
            guard let jobRefnr = jobDetails?.refnr else { return }
                FirebaseViewModel.shared.removeFavorite(jobRefnr: jobRefnr)
        }
    }
    
    private func updateFavoriteStatus() {
        guard let jobRefnr = jobDetails?.refnr else { return }
        FirebaseViewModel.shared.isFavorite(jobRefnr: jobRefnr) { isFavorite in
            self.isFavorited = isFavorite
        }
    }
}




#Preview {
    JobDetailView(encodedHashId: "MTgwNzQtVFE5U0wwTzU5RERRWjgyTy1T")
}

