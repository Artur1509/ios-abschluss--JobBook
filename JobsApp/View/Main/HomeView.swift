//
//  HomeView.swift
//  JobsApp
//
//  Created by Artur Lauer on 24.01.24.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var jobsViewModel = JobsViewModel()
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                // Hintergrundfarbe festlegen
                Color.white.edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 0) {
                    VStack {
                        Text("Jobsuche")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        SearchBar(text: $searchText, placeholder: "Beruf suchen", onCommit: {
                            jobsViewModel.query.name = searchText
                            jobsViewModel.searchJobs()
                        })
                        
                        Spacer()
                        
                    }
                    .frame(height: 130)
                    .padding(.horizontal)
                    .background(Color(.white))
                    
                    List(jobsViewModel.stellenangebote, id: \.refnr) { job in
                        NavigationLink(destination: JobDetailView(encodedHashId: encodeToBase64(inputString: job.refnr!) ?? "")) {
                            JobListItemView(job: job)
                        }
                    }
                }
            }
        }
        .onAppear {
            // Rufe fetchData auf, wenn die HomeView geladen wird
            jobsViewModel.fetchData()
        }
        .onChange(of: searchText) { newValue in
            // Aktualisiere die Suchergebnisse, wenn sich der Suchtext ändert
            jobsViewModel.query.name = newValue
            jobsViewModel.searchJobs()
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(JobsViewModel())
    }
}


