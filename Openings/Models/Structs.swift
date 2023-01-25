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
    let sequence: [String]
}

struct Piece {
    let name: String
    var color: Color
    
    mutating func flipColor(){
        if color == Color.white{
            print("White piece")
            self.color = Color.black
        }else if color == Color.black{
            self.color = Color.white
            print("Black piece")
        }
    }
}

class Cell {
    let color: Color
    var piece: Piece?
    
    init(color: Color, piece: Piece? = nil) {
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
    
    init() {
        for i in 0..<8 {
            var subArray = [Cell]()
            for j in 0..<8{
                subArray.append(Cell(color: (i%2 + j%2)%2 == 0 ? Color.white : Color.green))
            }
            cells.append(subArray)
        }
        createBoard()
    }
    
    func createBoard(){
        for i in 0..<8{
            for j in 0..<8{
                if i == 1{
                    cells[i][j].setPiece(piece: Piece(name: "bpawn", color: Color.white))
                }else if i == 6{
                    cells[i][j].setPiece(piece: Piece(name: "wpawn", color: Color.black))
                }else if i == 0 {
                    if j == 0 || j == 7{
                        cells[i][j].setPiece(piece: Piece(name: "brook", color: Color.white))
                    }else if j == 1 || j == 6{
                        cells[i][j].setPiece(piece: Piece(name: "bknight", color: Color.white))
                    }else if j == 2 || j == 5{
                        cells[i][j].setPiece(piece: Piece(name: "bbishop", color: Color.white))
                    }else if j == 3{
                        cells[i][j].setPiece(piece: Piece(name: "bqueen", color: Color.white))
                    }else{
                        cells[i][j].setPiece(piece: Piece(name: "bking", color: Color.white))
                    }
                }else if i == 7{
                    if j == 0 || j == 7{
                        cells[i][j].setPiece(piece: Piece(name: "wrook", color: Color.black))
                    }else if j == 1 || j == 6{
                        cells[i][j].setPiece(piece: Piece(name: "wknight", color: Color.black))
                    }else if j == 2 || j == 5{
                        cells[i][j].setPiece(piece: Piece(name: "wbishop", color: Color.black))
                    }else if j == 3{
                        cells[i][j].setPiece(piece: Piece(name: "wqueen", color: Color.black))
                    }else{
                        cells[i][j].setPiece(piece: Piece(name: "wking", color: Color.black))
                    }
                }
            }
        }
    }
    
    func flipBoard(){
        for i in 0..<8{
            for j in 0..<8{
                cells[i][j].piece?.flipColor()
            }
        }
        
    }
}
