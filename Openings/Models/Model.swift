//
//  Model.swift
//  Openings
//
//  Created by Jaden Passero on 2/1/23.
//

import Foundation

struct Opening {
    let name: String
    let variation: String?
    let sequence: [Move]
}

struct Move {
    let startSquare: String
    let endSquare: String
}

class Model: ObservableObject {
    //let sicilian: [Move] =
    let openingsList = ["Sicilian"] //: [Opening] = [Opening(name: "Sicilian", sequance: )]
}
