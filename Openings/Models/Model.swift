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
    var sequence: [Move]
    
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
    var startSquare: String
    var endSquare: String
    var capturedPiece: String?
    
    init(_ startSquare: String, _ endSquare: String, capturedPiece: String? = nil) {
        self.startSquare = startSquare
        self.endSquare = endSquare
        self.capturedPiece = capturedPiece
    }
    
    mutating func flipMove(){
        let localStart = self.startSquare
        self.startSquare = self.endSquare
        self.endSquare = localStart
    }
}

class Model: ObservableObject {
    let sicilian: [Move] = [Move("E2", "E4"), Move("C7", "C5"), Move("G1", "F3"), Move("D7", "D6"), Move("D2", "D4"), Move("C5", "D4",capturedPiece: "wpawn"), Move("F3","D4", capturedPiece: "bpawn"), Move("G8", "F6"), Move("B1", "C3")]
    
    var openingsList: [String: Opening] = [String: Opening]()
    
    init() {
        createList()
    }
    
    func createList(){
        self.openingsList["Sicilian"] = Opening(name: "Sicilian", sequence: sicilian)
    }
}
