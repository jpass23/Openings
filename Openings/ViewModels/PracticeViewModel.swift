//
//  PracticeViewModel.swift
//  Openings
//
//  Created by Jaden Passero on 12/13/23.
//

import Foundation

class PracticeViewModel: ObservableObject {
    @Published var successfullyComplete: Bool?
    @Published var opening: Opening?
    var board: Board
    var moveList = [Move]()
    var selectedPiece: String?
    var startCellName: String?

    init(board: Board) {
        self.board = board
    }
    
    func cellClick(cellName: String) {
        var move: Move?
        self.board.deselectAll()
        
        if let startCellName = startCellName, self.board.squares[cellName]!.hasPiece() {
            // deal with castling
            move = Move(startCellName, cellName, capturedPiece: self.board.squares[cellName]!.piece, castled: false)
            if self.board.squares[cellName]!.piece == "wrook", self.selectedPiece == "wking" {
                move = Move(startCellName, cellName, castled: true)
            }
            if self.board.squares[cellName]!.piece == "brook", self.selectedPiece == "bking" {
                move = Move(startCellName, cellName, castled: true)
            }
            if startCellName == cellName {
                move = nil
            }
            self.board.deselectAll()
            self.selectedPiece = nil
            self.startCellName = nil
        } else if let startCellName = startCellName {
            move = Move(startCellName, cellName, castled: false)
            self.board.deselectAll()
            self.selectedPiece = nil
            self.startCellName = nil
        } else if self.board.squares[cellName]!.hasPiece() {
            self.board.squares[cellName]!.select()
            self.selectedPiece = self.board.squares[cellName]!.piece
            self.startCellName = cellName
        } else {
            self.board.squares[cellName]!.select()
        }
        if let move = move {
            self.moveList.append(move)
            self.makeMove(move: move)
            print(move)
        }
        self.successfullyComplete = self.successfullyCompleted()
    }
    
    func successfullyCompleted() -> Bool? {
        let length = self.moveList.count
        if Array(self.opening!.sequence[0 ..< length]) == self.moveList {
            if self.opening!.sequence.count == length {
                return true
            }
            return nil
        } else {
            return false
        }
    }
    
    func makeMove(move: Move?) {
        if let move = move {
            let piece = self.board.squares[move.startSquare]!.piece!
            if move.castled {
                if move.endSquare == "H1" { // Kinside white
                    self.makeMove(move: Move("H1", "F1"))
                    self.makeMove(move: Move("E1", "G1"))
                } else if move.endSquare == "A1" { // Queenside white
                    self.makeMove(move: Move("A1", "D1"))
                    self.makeMove(move: Move("E1", "C1"))
                } else if move.endSquare == "H8" { // Kingside black
                    self.makeMove(move: Move("H8", "F8"))
                    self.makeMove(move: Move("E8", "G8"))
                } else if move.endSquare == "A8" { // Queenside black
                    self.makeMove(move: Move("A8", "D8"))
                    self.makeMove(move: Move("E8", "C8"))
                }
            } else {
                self.board.squares[move.startSquare]!.piece = nil
                self.board.squares[move.endSquare]!.piece = piece
            }
        }
    }
}
