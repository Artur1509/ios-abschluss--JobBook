//
//  JobsApiRepository.swift
//  JobsApp
//
//  Created by Artur Lauer on 31.01.24.
//

import Foundation

class JobsApiRepository {
    
    private static var apiKey = "c003a37f-024f-462a-b36d-b001be4cd24a"
    
    static func fetchJobs() async throws -> [Job] {
        
        let headers = [
            "X-API-Key": apiKey
        ]
        
        guard let url = URL(string: "https://rest.arbeitsagentur.de/jobboerse/jobsuche-service/pc/v4/jobs") else {
            throw HTTPError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        // Zuerst das JSON in das Joblist-Objekt decodieren
        let joblist = try JSONDecoder().decode(Joblist.self, from: data)
        
        // Dann das Array von Jobs aus dem stellenangebote-Feld extrahieren
        return joblist.stellenangebote
    }
}
