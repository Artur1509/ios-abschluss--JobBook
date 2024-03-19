//
//  JobsApiRepository.swift
//  JobsApp
//
//  Created by Artur Lauer on 31.01.24.
//
import Foundation

class JobsApiRepository {
    
    private static var apiKey = "c003a37f-024f-462a-b36d-b001be4cd24a"
    
    static func fetchJobs(what: String? = nil, where: String? = nil, berufsfeld: String? = nil, page: Int? = nil, arbeitgeber: String? = nil, zeitarbeit: Bool? = nil, size: Int? = nil, veroeffentlichtseit: Int? = nil, pav: Bool? = nil, angebotsart: Int? = nil, befristung: String? = nil, behinderung: Bool? = nil, corona: Bool? = nil, umkreis: Int? = nil, arbeitszeit: String? = nil) async throws -> [Job] {
        
        var urlComponents = URLComponents(string: "https://rest.arbeitsagentur.de/jobboerse/jobsuche-service/pc/v4/jobs")!
        
        var queryItems = [URLQueryItem]()
        if let what = what { queryItems.append(URLQueryItem(name: "was", value: what)) }
        if let `where` = `where` { queryItems.append(URLQueryItem(name: "wo", value: `where`)) }
        if let berufsfeld = berufsfeld { queryItems.append(URLQueryItem(name: "berufsfeld", value: berufsfeld)) }
        if let page = page { queryItems.append(URLQueryItem(name: "page", value: String(page))) }
        if let arbeitgeber = arbeitgeber { queryItems.append(URLQueryItem(name: "arbeitgeber", value: arbeitgeber)) }
        if let zeitarbeit = zeitarbeit { queryItems.append(URLQueryItem(name: "zeitarbeit", value: String(zeitarbeit))) }
        if let size = size { queryItems.append(URLQueryItem(name: "size", value: String(size))) }
        if let veroeffentlichtseit = veroeffentlichtseit { queryItems.append(URLQueryItem(name: "veroeffentlichtseit", value: String(veroeffentlichtseit))) }
        if let pav = pav { queryItems.append(URLQueryItem(name: "pav", value: String(pav))) }
        if let angebotsart = angebotsart { queryItems.append(URLQueryItem(name: "angebotsart", value: String(angebotsart))) }
        if let befristung = befristung { queryItems.append(URLQueryItem(name: "befristung", value: befristung)) }
        if let behinderung = behinderung { queryItems.append(URLQueryItem(name: "behinderung", value: String(behinderung))) }
        if let corona = corona { queryItems.append(URLQueryItem(name: "corona", value: String(corona))) }
        if let umkreis = umkreis { queryItems.append(URLQueryItem(name: "umkreis", value: String(umkreis))) }
        if let arbeitszeit = arbeitszeit { queryItems.append(URLQueryItem(name: "arbeitszeit", value: arbeitszeit)) }
        
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
