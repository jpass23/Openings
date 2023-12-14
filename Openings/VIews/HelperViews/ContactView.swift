//
//  ContactView.swift
//  Openings
//
//  Created by Jaden Passero on 11/27/23.
//

import SwiftUI

struct ContactView: View {
    @StateObject var vm = ContactViewModel()
    @State var name = ""
    @State var email = ""
    @State var subject = ""
    @State var message = "Message"
    @State var textColor = Color.secondary
    var body: some View {

        Form{
            Section{
                TextField("Name", text: $name)
            }
            Section{
                TextField("Email", text: $email)
            }
            Section{
                TextField("Subject", text: $subject)
            }
            Section{
                TextEditor(text: $message)
                    .frame(height: 300)
                    .foregroundColor(textColor)
                    .onTapGesture {
                        if message == "Message"{
                            message = ""
                        textColor = Color.primary
                        }
                    }
            }
            Button{
                vm.sendEmail(name: name, email: email, subject: subject, message: message)
            }label: {
                HStack{
                    Spacer()
                    Text("Send").fontWeight(.bold)
                    Spacer()
                }
            }
        }
    }
}

struct ContactView_Previews: PreviewProvider {
    static var previews: some View {
        ContactView()
    }
}
