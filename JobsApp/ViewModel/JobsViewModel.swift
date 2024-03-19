//
//  JobsViewModel.swift
//  JobsApp
//
//  Created by Artur Lauer on 31.01.24.
//

import Foundation

@MainActor
class JobsViewModel: ObservableObject {
    
    @Published var favorites = [JobDetails]()
    @Published var stellenangebote = [Job]()
    @Published var query = JobSearchQuery()
    
    // Daten aus API Laden
    
    func fetchData() {
        Task {
            do {
                let fetchedJobs: [Job]
                if let queryName = query.name {
                    fetchedJobs = try await JobsApiRepository.fetchJobs(what: queryName, where: query.location) // Hinzufügen des Orts
                } else {
                    fetchedJobs = try await JobsApiRepository.fetchJobs(where: query.location) // Hinzufügen des Orts
                }
                DispatchQueue.main.async {
                    self.stellenangebote = fetchedJobs
                }
            } catch {
                print("Request failed with error: \(error)")
            }
        }
    }
    
    // Nach Jobs suchen
    
    func searchJobs() {
        Task {
            do {
                guard let queryName = query.name else {
                    print("No query name provided.")
                    return
                }
                self.stellenangebote = try await JobsApiRepository.fetchJobs(what: queryName, where: query.location)
                
            } catch {
                print("Suchanfrage fehlgeschlagen: \(error)")
            }
        }
    }
    
    // Jobdetails des ausgewählten Jobs laden
    
    func fetchJobDetails(encodedHashId: String, completion: @escaping (Result<JobDetails, Error>) -> Void) {
        JobsApiRepository.fetchJobDetails(encodedHashId: encodedHashId) { result in
            switch result {
            case .success(let jobDetails):
                completion(.success(jobDetails))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // Job.refnr in base64 encoden um details laden zu können
    func encodeToBase64(inputString: String) -> String? {
        if let inputData = inputString.data(using: .utf8) {
            let base64String = inputData.base64EncodedString()
            return base64String
        } else {
            print("Die Eingabe konnte nicht in Daten umgewandelt werden.")
            return nil
        }
    }
}
