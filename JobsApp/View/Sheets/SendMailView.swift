//
//  SendMailView.swift
//  JobsApp
//
//  Created by Artur Lauer on 18.03.24.
//

import SwiftUI

// Das SendMailView dient nur zu Demonstrationszwecken, da es
// nicht möglich ist mit dem Simulator E-mails zu versenden.

struct SendMailView: View {
    
    @State var mailSubject: String = ""
    @State var mailBody: String = ""
    @State var mailTo: String = ""
    
    var body: some View {
            
        Form {
            TextField("Betreff:", text: $mailSubject)
            TextField("An:", text: $mailTo)
            
            VStack {
                TextField("", text: $mailBody)
                    .frame(height: 400)
                    .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                    
            }

            Section {
                Button {
                    MailHelper.shared.sendEmail(
                        subject: mailSubject,
                        body: mailBody,
                        to: mailTo
                    )
                }label: {
                    Text("Senden")
                }
                .foregroundStyle(Color("Primary"))
            }
        }
        
    }
}

#Preview {
    SendMailView()
}
