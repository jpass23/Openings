//
//  BoardViewModel.swift
//  Openings
//
//  Created by Jaden Passero on 3/12/23.
//

import Foundation

class BoardViewModel: ObservableObject {
    @Published var board: Board
    var moveList = [Move]()
    var selectedPiece: String?
    var cellIsSelected: Bool = false
    
    init(board: Board){
        self.board = board
    }
    
    func cellClick(cellName: String){
        if cellIsSelected {
            //TODO: add functionality
            cellIsSelected = false
        }else{
            cellIsSelected = true
        }
        let cell = self.board.squares[cellName]!
        if let selectedPiece = self.selectedPiece{
            cell.piece = selectedPiece
            //let move = Move(<#T##startSquare: String##String#>, <#T##endSquare: String##String#>, capturedPiece: <#T##String?#>, castled: <#T##Bool#>)
            //moveList.append(move)
        }
    }
}
