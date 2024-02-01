//
//  Job.swift
//  JobsApp
//
//  Created by Artur Lauer on 31.01.24.
//

import Foundation

struct Joblist: Codable {
    var stellenangebote: [Job]
}

struct Job: Codable {
    
    struct Location: Codable {
        var plz: String?
        var ort: String?
        var region: String?
        var land: String?
        var koordinaten: Coordinates
        
        struct Coordinates: Codable {
            var lat: Double?
            var lon: Double?
        }
    }
    
    var beruf: String?
    var titel: String?
    var refnr: String?
    var arbeitsort: Location?
    var arbeitgeber: String?
    var aktuelleVeroeffentlichungsdatum: String?
    var modifikationsTimestamp: String?
    var eintrittsdatum: String?
    var hashId: String?
    
}
