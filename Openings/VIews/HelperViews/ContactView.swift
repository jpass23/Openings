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
    @State var loading = false
    @State var showSuccess = false
    @State var showFailed = false
    var body: some View {
        NavigationStack{
            ZStack{
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
                        loading.toggle()
                        Task{
                            let result = await vm.sendMessage(name: name, email: email, subject: subject, message: message)
                            if result{
                                withAnimation {
                                    showSuccess.toggle()
                                }
                                resetView()
                            }else{
                                withAnimation {
                                    showFailed.toggle()
                                }
                            }
                            loading.toggle()
                        }
                    }label: {
                        HStack{
                            Spacer()
                            Text("Send").fontWeight(.bold)
                            Spacer()
                        }
                    }.disabled(fieldsFilled)
                }.navigationTitle("Message me!")
                    .opacity((loading || showSuccess || showFailed) ? 0.2 : 1)
                if loading {
                    ProgressView()
                }
                VStack{
                    Spacer()
                    if showSuccess{
                        successDialog
                    }
                    if showFailed{
                        failedDialog
                    }
                }
            }
        }
    }
    
    private func resetView(){
        self.name = ""
        self.email = ""
        self.subject = ""
        self.message = "Message"
    }
    private var fieldsFilled: Bool {
        name == "" || email == "" || subject == "" || message == "Message"
    }
    private var successDialog: some View {
        HStack {
            Image(systemName: "checkmark")
            Text("Your response has been sent. Thank you!")
                .font(.subheadline)
        }
        .padding()
        .frame(width: UIScreen.screenWidth - 20)
        .background(.green.opacity(0.15))
        .foregroundColor(.green)
        .cornerRadius(14)
        .padding(.bottom)
        .onAppear {
            withAnimation(.easeOut(duration: 0.5).delay(3)) {
                showSuccess = false
            }
        }
    }
    
    private var failedDialog: some View {
        HStack {
            Image(systemName: "x.circle")
            Text("Please try again")
                .font(.subheadline)
        }
        .padding()
        .frame(width: UIScreen.screenWidth - 20)
        .background(.red.opacity(0.15))
        .foregroundColor(.red)
        .cornerRadius(14)
        .padding(.bottom)
        .onAppear {
            withAnimation(.easeOut(duration: 0.5).delay(3)){
                showFailed = false
            }
        }
    }
}

struct ContactView_Previews: PreviewProvider {
    static var previews: some View {
        ContactView()
    }
}
