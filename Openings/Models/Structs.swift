//
//  Structs.swift
//  Openings
//
//  Created by Jaden Passero on 1/24/23.
//

import Foundation

struct Opening {
    let name: String
    let variation: String?
    let sequence: [String]
}

struct Piece {
    let name: String
    let color: String
}

class Cell {
    let color: String
    var piece: Piece?
    
    init(color: String, piece: Piece? = nil) {
        self.color = color
        self.piece = piece
    }
    
    func setPiece (piece: Piece){
        self.piece = piece
    }
    
    func removePiece(){
        self.piece = nil
    }
}

class Board {
    var cells = [[Cell]]()
    
    func createBoard(){
        for i in 0..<8{
            for j in 0..<8{
                cells[i][j] = Cell(color: (i%2 + j%2)%2 == 0 ? "black" : "white")
            }
        }
    }
}
