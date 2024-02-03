//
//  JobsViewModel.swift
//  JobsApp
//
//  Created by Artur Lauer on 31.01.24.
//

import Foundation

@MainActor
class JobsViewModel: ObservableObject {
    
    // MARK: - Variables
    @Published var stellenangebote = [Job]()
    
    // MARK: - Functions
    
    func fetchData() {
        Task {
            do {
                self.stellenangebote = try await JobsApiRepository.fetchJobs()
            } catch {
                print("Request failed with error: \(error)")
            }
        }
    }
}
