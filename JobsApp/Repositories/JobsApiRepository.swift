//
//  JobsApiRepository.swift
//  JobsApp
//
//  Created by Artur Lauer on 31.01.24.
//

import Foundation

class JobsApiRepository {
    private static var apiKey = "c003a37f-024f-462a-b36d-b001be4cd24a"
    
    static func fetchJobs(withQuery query: String? = nil) async throws -> [Job] {
        var urlComponents = URLComponents(string: "https://rest.arbeitsagentur.de/jobboerse/jobsuche-service/pc/v4/jobs")!
        
        var queryItems = [URLQueryItem]()
        if let query = query {
            queryItems.append(URLQueryItem(name: "was", value: query))
        }
        
        // Add other query parameters as needed
        
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            throw HTTPError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(apiKey, forHTTPHeaderField: "X-API-Key")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let joblist = try JSONDecoder().decode(Joblist.self, from: data)
        
        return joblist.stellenangebote
    }
    
    static func fetchJobDetails(encodedHashId: String, completion: @escaping (Result<JobDetails, Error>) -> Void) {
        // URL für die GET-Anfrage erstellen
        let urlString = "https://rest.arbeitsagentur.de/jobboerse/jobsuche-service/pc/v2/jobdetails/\(encodedHashId)"
        guard let url = URL(string: urlString) else {
            completion(.failure(HTTPError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(apiKey, forHTTPHeaderField: "X-API-Key")
        
        // URLSession-Anfrage senden
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? HTTPError.unknown))
                return
            }
            
            do {
                // JSON-Daten decodieren
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let jobDetails = try decoder.decode(JobDetails.self, from: data)
                completion(.success(jobDetails))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}

