//
//  SettingsViewModel.swift
//  Openings
//
//  Created by Jaden Passero on 11/26/23.
//

import Foundation

class ContactViewModel: ObservableObject {
    
    func sendMessage(name: String, email: String, subject: String, message: String) async -> Bool{
        guard let url = URL(string: "https://openings-1-m8943455.deta.app/add/?name=\(name)&email=\(email)&subject=\(subject)&message=\(message)") else { fatalError() }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        do {
            let (data,_) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            let result = try decoder.decode(Bool.self, from: data)
            return result
        } catch {
            print(error)
        }
        return false
    }
    
    func getMessages() async -> [Message] {
        var messages = [Message]()
        guard let url = URL(string: "https://openings-1-m8943455.deta.app/get-messages") else { fatalError() }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        do {
            let (data,_) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            let result = try decoder.decode(Result.self, from: data)
            messages = result.messages
        } catch {
            print(error)
        }
        return messages
    }
}
