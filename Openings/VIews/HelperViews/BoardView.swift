//
//  BoardView.swift
//  Openings
//
//  Created by Jaden Passero on 1/24/23.
//

import SwiftUI

struct BoardView: View {
    @ObservedObject var board: Board
    @EnvironmentObject var model: Model
    @Binding var playingColor: String
    var onClick: ((String) -> Void)?
    let clickable: Bool

    var body: some View {
        Grid(horizontalSpacing: 0, verticalSpacing: 0) {
            ForEach(1..<9) { number in
                GridRow {
                    ForEach(0..<8) { letterIndex in
                        cell(cellName: cellName(number: number, letterIndex: letterIndex))
                    }
                }
            }
        }
        .padding(5)
        .border(model.darkSquareColor, width: 5)
    }

    @ViewBuilder
    func cell(cellName: String) -> some View {
        if self.clickable {
            Button {
//                if (playingColor == "White" && board.squares[cellName]?.piece?[0] == "b") || (playingColor == "Black" && board.squares[cellName]?.piece?[0] == "w"){
//                    return
//                }
                onClick!(cellName)
            } label: {
                CellView(cell: self.board.squares[cellName]!)
            }
        } else {
            CellView(cell: self.board.squares[cellName]!)
        }
    }

    func cellName(number: Int, letterIndex: Int) -> String {
        let index = 7-letterIndex
        let indexNumber = 9-number
        var cellName = ""
        if self.playingColor == "Black" {
            cellName = self.board.letterList[index]+String(number)
        } else {
            cellName = self.board.letterList[letterIndex]+String(indexNumber)
        }
        return cellName
    }
}

// struct BoardView_Previews: PreviewProvider {
//    static var previews: some View {
//        BoardView()
//    }
// }
