//
//  Structs.swift
//  Openings
//
//  Created by Jaden Passero on 1/24/23.
//

import Foundation
import SwiftUI

class Cell: ObservableObject{
    let color: Color
    @Published var piece: String?
    
    init(color: Color, piece: String? = nil) {
        self.color = color
        self.piece = piece
    }
    
    func setPiece (piece: String){
        self.piece = piece
    }
    
    func removePiece(){
        self.piece = nil
    }
}

class Board: ObservableObject{
    @Published var squares = [String:Cell]()
    let letterList = ["A", "B", "C", "D", "E", "F", "G", "H"]
    
    init() {
        for index in 0..<8 {
            for number in 1..<9{
                squares[letterList[index] + String(number)] = Cell(color: (index%2 + number%2)%2 == 0 ? Color.white : Color.green)
            }
        }
        initializeBoard()
    }
    
    func initializeBoard(){
        for number in 1..<9 {
            for letter in letterList{
                let cell = squares[letter + String(number)]!
                if number == 1{
                    if letter == "A" || letter == "H"{
                        cell.piece = "wrook"
                    }else if letter == "B" || letter == "G"{
                        cell.piece = "wknight"
                    }else if letter == "C" || letter == "F"{
                        cell.piece = "wbishop"
                    }else if letter == "D"{
                        cell.piece = "wqueen"
                    }else if letter == "E"{
                        cell.piece = "wking"
                    }
                }else if number == 2{
                    cell.piece = "wpawn"
                }else if number == 7{
                    cell.piece = "bpawn"
                }else if number == 8{
                    if letter == "A" || letter == "H"{
                        cell.piece = "brook"
                    }else if letter == "B" || letter == "G"{
                        cell.piece = "bknight"
                    }else if letter == "C" || letter == "F"{
                        cell.piece = "bbishop"
                    }else if letter == "D"{
                        cell.piece = "bqueen"
                    }else if letter == "E"{
                        cell.piece = "bking"
                    }
                }
            }
        }
    }
}
