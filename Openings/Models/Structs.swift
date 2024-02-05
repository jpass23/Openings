//
//  Structs.swift
//  Openings
//
//  Created by Jaden Passero on 1/24/23.
//

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

class Cell: ObservableObject {
    let isDarkSquare: Bool
    @Published var piece: String?
    @Published var selected = false
    
    init(isDarkSquare: Bool, piece: String? = nil) {
        self.isDarkSquare = isDarkSquare
        self.piece = piece
    }
    
    func setPiece(piece: String) {
        self.piece = piece
    }
    
    func removePiece() {
        piece = nil
    }
    
    func hasPiece() -> Bool {
        if piece != nil {
            return true
        }
        return false
    }
    
    func select() {
        selected = true
    }
    
    func deselect() {
        selected = false
    }
}

extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}

extension Color {
    static let deepGreen = Color(red: 47/255, green: 109/255, blue: 64/255)
    static let royalPurple = Color(red: 113/255, green: 91/255, blue: 192/255)
    func darken() -> Color {
        if let components = cgColor?.components {
            let r = components[0]
            let g = components[1]
            let b = components[2]
            return Color(red: r-0.2, green: g-0.2, blue: b-0.2)
        } else {
            return Color(red: 0.7, green: 0.7, blue: 0.7)
        }
    }
}

extension String {
    func isSameColor(as pieceName: String) -> Bool {
        return self[0] == pieceName[0]
    }
}

class Board: ObservableObject {
    @Published var squares = [String: Cell]()
//    @Published var lightSquareColor = Color.white
//    @Published var darkSquareColor = Color.royalPurple
    let letterList = ["A", "B", "C", "D", "E", "F", "G", "H"]
    
    // Take parameter here to pass to initializeBoard(). This will allow the board to be initialized in different ways based on that information passed in. It will be passed in from BoardView which will have access to the model
    init() {
        for index in 0..<8 {
            for number in 1..<9 {
                squares[letterList[index] + String(number)] = Cell(isDarkSquare: (index%2 + number%2)%2 != 0)
            }
        }
        initializeBoard()
    }
    
    func initializeBoard() {
        for number in 1..<9 {
            for letter in letterList {
                let cell = squares[letter + String(number)]!
                if number == 1 {
                    if letter == "A" || letter == "H" {
                        cell.piece = "wrook"
                    } else if letter == "B" || letter == "G" {
                        cell.piece = "wknight"
                    } else if letter == "C" || letter == "F" {
                        cell.piece = "wbishop"
                    } else if letter == "D" {
                        cell.piece = "wqueen"
                    } else if letter == "E" {
                        cell.piece = "wking"
                    }
                } else if number == 2 {
                    cell.piece = "wpawn"
                } else if number == 7 {
                    cell.piece = "bpawn"
                } else if number == 8 {
                    if letter == "A" || letter == "H" {
                        cell.piece = "brook"
                    } else if letter == "B" || letter == "G" {
                        cell.piece = "bknight"
                    } else if letter == "C" || letter == "F" {
                        cell.piece = "bbishop"
                    } else if letter == "D" {
                        cell.piece = "bqueen"
                    } else if letter == "E" {
                        cell.piece = "bking"
                    }
                }
            }
        }
    }
    
    func resetBoard() {
        for item in squares {
            let number = item.key[1]
            let letter = item.key[0]
            
            if number == "1" {
                if letter == "A" || letter == "H" {
                    item.value.piece = "wrook"
                } else if letter == "B" || letter == "G" {
                    item.value.piece = "wknight"
                } else if letter == "C" || letter == "F" {
                    item.value.piece = "wbishop"
                } else if letter == "D" {
                    item.value.piece = "wqueen"
                } else if letter == "E" {
                    item.value.piece = "wking"
                }
            } else if number == "2" {
                item.value.piece = "wpawn"
            } else if number == "7" {
                item.value.piece = "bpawn"
            } else if number == "8" {
                if letter == "A" || letter == "H" {
                    item.value.piece = "brook"
                } else if letter == "B" || letter == "G" {
                    item.value.piece = "bknight"
                } else if letter == "C" || letter == "F" {
                    item.value.piece = "bbishop"
                } else if letter == "D" {
                    item.value.piece = "bqueen"
                } else if letter == "E" {
                    item.value.piece = "bking"
                }
            } else {
                item.value.piece = nil
            }
        }
        self.deselectAll()
    }
    
    func deselectAll() {
        for index in 0..<8 {
            for number in 1..<9 {
                squares[letterList[index] + String(number)]!.deselect()
            }
        }
    }
}
