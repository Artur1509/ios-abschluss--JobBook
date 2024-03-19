//
//  SendMailView.swift
//  JobsApp
//
//  Created by Artur Lauer on 18.03.24.
//

import SwiftUI

struct SendMailView: View {
    @State var mailSubject: String = ""
    @State var mailBody: String = ""
    @State var mailTo: String = ""
    
    var body: some View {
            
        Form {
            TextField("Betreff:", text: $mailSubject)
            TextField("An:", text: $mailTo)
            TextField("", text: $mailBody)
                .frame(minHeight: 400)
            
            Section {
                Button {
                    MailHelper.shared.sendEmail(
                        subject: mailSubject,
                        body: mailBody,
                        to: mailTo
                    )
                }label: {
                    Text("Email senden")
                }
            }
        }
        
    }
}

#Preview {
    SendMailView()
}
