//
//  JobListItemView.swift
//  JobsApp
//
//  Created by Artur Lauer on 01.02.24.
//

import SwiftUI

struct JobListItemView: View {
    
    let job: Job
    
    var body: some View {
        VStack {
            FavoriteButton()
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.top, 4)
            
            Text(job.beruf ?? "")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title2)
                .fontWeight(.bold)
                .padding(4)
                .padding(.horizontal, 4)
            
            Text(job.titel ?? "")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 4)
                .padding(4)
            
            Text(job.arbeitgeber ?? "")
                .frame(maxWidth: .infinity, alignment: .leading)
                .fontWeight(.bold)
                .padding(4)
                .padding(.horizontal, 4)
                .padding(.bottom, 8)
            
            HStack {
                
                Image(systemName: "mappin.circle")
                    .foregroundColor(Color("Primary"))
                    .frame(alignment: .leading)
                    .padding(.horizontal, 8)
                    .padding(.trailing, -8)
                
                Text("\(job.arbeitsort.plz ?? "") \(job.arbeitsort.ort ?? "Keine Angabe")")
                    .frame(maxWidth: .infinity, alignment: .leading)
                
            }
            
            HStack {
                Image(systemName: "play.circle")
                    .foregroundColor(Color("Primary"))
                    .frame(alignment: .leading)
                    .padding(.horizontal, 8)
                    .padding(.trailing, -8)
                
                Text(job.eintrittsdatum?.formatDate2() ?? "Unbekannt")
                    .frame(maxWidth: .infinity, alignment: .leading)
                
            }
            .padding(.bottom, 8)
            
            HStack {
                Text(job.aktuelleVeroeffentlichungsdatum?.formatDate() ?? "")
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(4)
                    .padding(.trailing, -8)
                
                Image(systemName: "clock")
                    .foregroundColor(Color("Secondary"))
                    .frame( alignment: .trailing)
                    .padding(.horizontal, 4)
            }
            
        }
    }
}

func encodeToBase64(inputString: String) -> String? {
    if let inputData = inputString.data(using: .utf8) {
        let base64String = inputData.base64EncodedString()
        return base64String
    } else {
        print("Die Eingabe konnte nicht in Daten umgewandelt werden.")
        return nil
    }
}

#Preview {
    JobListItemView(job: Job(beruf: "App Entwickler für Android Apps",
                             titel: "App Entwickler",
                             refnr: "12345",
                             arbeitsort: Job.Location(plz: "12345", ort: "Berlin", region: "Berlin", land: "Deutschland", koordinaten: Job.Location.Coordinates(lat: 52.5200, lon: 13.4050)),
                             arbeitgeber: "XYZ Company",
                             aktuelleVeroeffentlichungsdatum: "01.01.2024",
                             modifikationsTimestamp: "01.01.2024",
                             eintrittsdatum: "01.02.2024",
                             hashId: "abcdef123456"))
}


// Formater für Veröffentlichungsdatum

extension String {
    func formatDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = dateFormatter.date(from: self) else {
            return self // Rückgabe des ursprünglichen Strings, wenn das Datum nicht formatiert werden kann
        }
        
        let today = Date()
        let calendar = Calendar.current
        
        if calendar.isDateInToday(date) {
            return "Heute"
        } else {
            dateFormatter.locale = Locale(identifier: "de_DE")
            dateFormatter.dateFormat = "dd. MMMM yyyy"
            return dateFormatter.string(from: date)
        }
    }
}


// Formater für Eintrittsdatum

extension String {
    func formatDate2() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = dateFormatter.date(from: self) else {
            return self // Rückgabe des ursprünglichen Strings, wenn das Datum nicht formatiert werden kann
        }
        
        let today = Date()
        let calendar = Calendar.current
        
        // Prüfen, ob das Datum heute ist
        if calendar.isDateInToday(date) {
            return "ab sofort"
        }
        
        // Prüfen, ob das Datum in der Vergangenheit liegt
        if date < today {
            return "ab sofort"
        }
        
        // Wenn es weder heute noch in der Vergangenheit liegt, gib das formatierte Datum zurück
        dateFormatter.locale = Locale(identifier: "de_DE")
        dateFormatter.dateFormat = "dd. MMMM yyyy"
        return dateFormatter.string(from: date)
    }
}

