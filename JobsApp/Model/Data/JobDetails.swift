//
//  JobDetails.swift
//  JobsApp
//
//  Created by Artur Lauer on 16.02.24.
//

import Foundation

struct JobDetails: Codable {
    
    let aktuelleVeroeffentlichungsdatum: String?
    let angebotsart: String?
    let arbeitgeber: String?
    let branchengruppe: String?
    let branche: String?
    let arbeitgeberHashId: String?
    let arbeitsorte: [Arbeitsort]?
    let arbeitszeitmodelle: [String]?
    let befristung: String?
    let uebernahme: Bool?
    let betriebsgroesse: String?
    let eintrittsdatum: String?
    let ersteVeroeffentlichungsdatum: String?
    let allianzpartner: String?
    let allianzpartnerUrl: String?
    let titel: String?
    let hashId: String?
    let beruf: String?
    let modifikationsTimestamp: String?
    let stellenbeschreibung: String?
    let refnr: String?
    let fuerFluechtlingeGeeignet: Bool?
    let nurFuerSchwerbehinderte: Bool?
    let anzahlOffeneStellen: Int?
    let arbeitgeberAdresse: ArbeitgeberAdresse?
    let fertigkeiten: [Fertigkeit]?
    let mobilitaet: Mobilitaet?
    let fuehrungskompetenzen: Fuehrungskompetenzen?
    let verguetung: String?
    let arbeitgeberdarstellungUrl: String?
    let arbeitgeberdarstellung: String?
    let hauptDkz: String?
    let istBetreut: Bool?
    let istGoogleJobsRelevant: Bool?
    let anzeigeAnonym: Bool?
}

struct Arbeitsort: Codable {
    let land: String?
    let region: String?
    let plz: String?
    let ort: String?
    let strasse: String?
    let strasseHausnummer: String?
    let koordinaten: Koordinaten?
}

struct Koordinaten: Codable {
    let lat: Double?
    let lon: Double?
}

struct ArbeitgeberAdresse: Codable {
    let land: String?
    let region: String?
    let plz: String?
    let ort: String?
    let strasse: String?
    let strasseHausnummer: String?
}

struct Fertigkeit: Codable {
    let hierarchieName: String?
    //let auspraegungen: [String: String]?
}

struct Mobilitaet: Codable {
    let reisebereitschaft: String?
}

struct Fuehrungskompetenzen: Codable {
    let hatVollmacht: Bool?
    let hatBudgetverantwortung: Bool?
}
