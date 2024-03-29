//
//  PracticeViewModel.swift
//  Openings
//
//  Created by Jaden Passero on 12/13/23.
//

import Foundation
import SwiftUI

class PracticeViewModel: ObservableObject {
    @Published var successfullyComplete: Bool?
    @Published var opening: Opening?
    @Published var shake = false
    var board: Board
    var model: Model?
    var moveList = [Move]()
    var selectedPiece: String?
    var startCellName: String?
    @Published var gameStarted = false

    init(board: Board) {
        self.board = board
    }
    
    func setup(model: Model){
        self.model = model
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
            if board.squares[move.startSquare]!.piece!.isSameColor(as: board.squares[move.endSquare]!.piece ?? " ") {
                return
            }
            self.moveList.append(move)
            self.makeMove(move: move)
            if self.successfullyCompleted() == nil{
                DispatchQueue.main.asyncAfter(deadline: .now() + model!.cpuDelay){
                    self.autoMove()
                }
            }
        }
        if let success = self.successfullyCompleted(){
            if !success{
                shake = true
                withAnimation(Animation.spring(response: 0.17, dampingFraction: 0.17, blendDuration: 0)) {
                    shake = false
                }
            }
        }
    }
    
    private func successfullyCompleted() -> Bool? {
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
    
    private func autoMove() {
        let move = self.opening!.sequence[self.moveList.count]
        self.moveList.append(move)
        self.makeMove(move: move)
    }
    
    func startGame(for color: String){
        self.gameStarted = true
        if color == "Black"{
            self.autoMove()
        }
    }
    
    func resetRound(){
        self.board.resetBoard()
        self.successfullyComplete = nil
        self.moveList = [Move]()
        self.selectedPiece = nil
        self.startCellName = nil
        self.gameStarted = false
    }
    
    func undoMove(){
        self.makeMove(move: self.moveList.last, backwards: true)
        self.moveList.removeLast()
        self.successfullyComplete = nil
    }
    
//    func makeMove(move: Move?) {
//        if let move = move {
//            let piece = self.board.squares[move.startSquare]!.piece!
//            if move.castled {
//                if move.endSquare == "H1" { // Kinside white
//                    self.makeMove(move: Move("H1", "F1"))
//                    self.makeMove(move: Move("E1", "G1"))
//                } else if move.endSquare == "A1" { // Queenside white
//                    self.makeMove(move: Move("A1", "D1"))
//                    self.makeMove(move: Move("E1", "C1"))
//                } else if move.endSquare == "H8" { // Kingside black
//                    self.makeMove(move: Move("H8", "F8"))
//                    self.makeMove(move: Move("E8", "G8"))
//                } else if move.endSquare == "A8" { // Queenside black
//                    self.makeMove(move: Move("A8", "D8"))
//                    self.makeMove(move: Move("E8", "C8"))
//                }
//            } else {
//                self.board.squares[move.startSquare]!.piece = nil
//                self.board.squares[move.endSquare]!.piece = piece
//            }
//        }
//    }
    
    func makeMove(move: Move?, backwards: Bool = false) {
        self.gameStarted = true
        self.model!.moveSounds()
        self.model!.moveHaptics()
        if let move = move {
            if backwards {
                if move.castled {
                    if move.endSquare == "H1" { // Kinside white
                        makeMove(move: Move("H1", "F1"), backwards: true)
                        makeMove(move: Move("E1", "G1"), backwards: true)
                    } else if move.endSquare == "A1" { // Queenside white
                        makeMove(move: Move("A1", "D1"), backwards: true)
                        makeMove(move: Move("E1", "C1"), backwards: true)
                    } else if move.endSquare == "G8" { // Kingside black
                        makeMove(move: Move("H8", "F8"), backwards: true)
                        makeMove(move: Move("E8", "G8"), backwards: true)
                    } else if move.endSquare == "C8" { // Queenside black
                        makeMove(move: Move("A8", "D8"), backwards: true)
                        makeMove(move: Move("E8", "C8"), backwards: true)
                    }
                }else{
                    let piece = board.squares[move.endSquare]!.piece!
                    board.squares[move.endSquare]!.piece = nil
                    board.squares[move.startSquare]!.piece = piece
                    if move.capturedPiece != nil {
                        board.squares[move.endSquare]!.piece = move.capturedPiece
                    }
                }
            } else { // forward
                if move.castled {
                    if move.endSquare == "H1" { // Kinside white
                        makeMove(move: Move("H1", "F1"))
                        self.makeMove(move: Move("E1", "G1"))
                    } else if move.endSquare == "A1" { // Queenside white
                        makeMove(move: Move("A1", "D1"))
                        self.makeMove(move: Move("E1", "C1"))
                    } else if move.endSquare == "G8" { // Kingside black
                        makeMove(move: Move("H8", "F8"))
                        self.makeMove(move: Move("E8", "G8"))
                    } else if move.endSquare == "C8" { // Queenside black
                        makeMove(move: Move("A8", "D8"))
                        self.makeMove(move: Move("E8", "C8"))
                    }
                }else{
                    let piece = board.squares[move.startSquare]!.piece!
                    board.squares[move.startSquare]!.piece = nil
                    board.squares[move.endSquare]!.piece = piece
                }
            }
        }
        self.successfullyComplete = self.successfullyCompleted()
    }
}
