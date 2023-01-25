//
//  Model.swift
//  Openings
//
//  Created by Jaden Passero on 1/24/23.
//

import Foundation

class Model: ObservableObject {
    // Holds state of app. Enjected into the environment in ContentView
    @Published var board = Board()
}
