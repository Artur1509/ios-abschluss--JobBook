//
//  HomeView.swift
//  JobsApp
//
//  Created by Artur Lauer on 24.01.24.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var jobsViewModel = JobsViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach(jobsViewModel.stellenangebote, id: \.refnr) { job in
                    JobListItemView(job: job)
                }
            }
            .navigationTitle("Stellenanzeigen")
            .onAppear {
                jobsViewModel.fetchData()
            }
        }
    }
    
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(JobsViewModel())
    }
}


