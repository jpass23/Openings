//
//  Model.swift
//  Openings
//
//  Created by Jaden Passero on 2/1/23.
// https://www.mark-weeks.com/aboutcom/aa05l17.htm

import Foundation
import SwiftUI

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
        if lhs.name < rhs.name {
            return true
        } else {
            return false
        }
    }
    
    static func == (lhs: Opening, rhs: Opening) -> Bool {
        if lhs.name == rhs.name, lhs.variation == rhs.variation {
            return true
        } else {
            return false
        }
    }
}

struct Move: Equatable {
    var startSquare: String
    var endSquare: String
    var capturedPiece: String?
    var castled: Bool
    // static let QSCastleWhite: (Move,Move) = (Move("A1", "D1"), Move("E1", "C1"))
    // static let KSCastleWhite: (Move,Move) = (Move("H1", "F1"), Move("E1", "G1"))
    
    init(_ startSquare: String, _ endSquare: String, capturedPiece: String? = nil, castled: Bool = false) {
        self.startSquare = startSquare
        self.endSquare = endSquare
        self.capturedPiece = capturedPiece
        self.castled = castled
    }
    
    mutating func flipMove() {
        let localStart = self.startSquare
        self.startSquare = self.endSquare
        self.endSquare = localStart
    }
}

class Model: ObservableObject {
    @Published var lightSquareColor = Color.white
    @Published var darkSquareColor = Color.deepGreen
    
    let sicilianClassic: [Move] = [Move("E2", "E4"), Move("C7", "C5"), Move("G1", "F3"), Move("D7", "D6"), Move("D2", "D4"), Move("C5", "D4", capturedPiece: "wpawn"), Move("F3", "D4", capturedPiece: "bpawn"), Move("G8", "F6"), Move("B1", "C3"), Move("B8", "C6")]
    let sicilianNajdorf: [Move] = [Move("E2", "E4"), Move("C7", "C5"), Move("G1", "F3"), Move("D7", "D6"), Move("D2", "D4"), Move("C5", "D4", capturedPiece: "wpawn"), Move("F3", "D4", capturedPiece: "bpawn"), Move("G8", "F6"), Move("B1", "C3"), Move("A7", "A6")]
    let royLopez: [Move] = [Move("E2", "E4"), Move("E7", "E5"), Move("G1", "F3"), Move("B8", "C6"), Move("F1", "B5"), Move("A7", "A6"), Move("B5", "A4"), Move("G8", "F6"), Move("E1", "G1", castled: true)]
    
    var openingsList: [String: Opening] = .init()
    
    init() {
        self.createList()
    }
    
    func createList() {
        self.openingsList["Sicilian-Classical"] = Opening(name: "Sicilian", variation: "Classical", sequence: self.sicilianClassic) // Key is displayed in list while opening.name is desplayed as title
        self.openingsList["Sicilian-Najdorf"] = Opening(name: "Sicilian", variation: "Classical", sequence: self.sicilianNajdorf)
        self.openingsList["Roy Lopez"] = Opening(name: "Roy Lopez", sequence: self.royLopez)
    }
}
