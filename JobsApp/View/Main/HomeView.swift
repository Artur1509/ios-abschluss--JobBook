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
    @State private var locationText: String = ""
    
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
                        
                        SearchBar(text: $searchText, placeholder: "Was?", onCommit: {
                            searchJobs()
                        }, searchImageName: "magnifyingglass")
                        
                        SearchBar(text: $locationText, placeholder: "Wo?", onCommit: {
                            searchJobs()
                        }, searchImageName: "mappin.circle")
                        .padding(.top, 8)
                        
                        
                        Spacer()
                    }
                    .frame(height: 180)
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
            fetchData()
        }
        .onChange(of: searchText) { newValue in
            searchJobs()
        }
        .onChange(of: locationText) { newValue in
            searchJobs()
        }
        
    }
    
    private func fetchData() {
        jobsViewModel.fetchData()
    }
    
    private func searchJobs() {
        jobsViewModel.query.name = searchText
        jobsViewModel.query.location = locationText
        jobsViewModel.searchJobs()
    }
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(JobsViewModel())
    }
}


