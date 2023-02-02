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
    
    init(name: String, variation: String? = nil, sequence: [Move]) {
        self.name = name
        self.variation = variation
        self.sequence = sequence
    }
}

extension Opening: Comparable {
    static func < (lhs: Opening, rhs: Opening) -> Bool {
        if lhs.name < rhs.name{
            return true
        }else{
            return false
        }
    }
    
    static func == (lhs: Opening, rhs: Opening) -> Bool {
        if lhs.name == rhs.name && lhs.variation == rhs.variation{
            return true
        }else{
            return false
        }
    }
    
    
}

struct Move {
    let startSquare: String
    let endSquare: String
    var capturedPiece: String?
    
    init(_ startSquare: String, _ endSquare: String, capturedPiece: String? = nil) {
        self.startSquare = startSquare
        self.endSquare = endSquare
        self.capturedPiece = capturedPiece
    }
}

class Model: ObservableObject {
    let sicilian: [Move] = [Move("E2", "E4"), Move("C7", "C5"), Move("G1", "F3"), Move("D7", "D6"), Move("D2", "D4"), Move("C5", "D4"), Move("F3","D4"), Move("G8", "F6"), Move("B1", "C3")]
    
    var openingsList: [String: Opening] = [String: Opening]()
    
    init() {
        createList()
    }
    
    func createList(){
        self.openingsList["Sicilian"] = Opening(name: "Sicilian", sequence: sicilian)
    }
}
