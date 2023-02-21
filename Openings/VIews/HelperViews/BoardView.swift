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

    var body: some View {
        Grid(horizontalSpacing: 0, verticalSpacing: 0) {
            ForEach(1..<9) { number in
                GridRow {
                    ForEach(0..<8) { letterIndex in
                        if playingColor == "Black" {
                            let index = 7-letterIndex
                            let cellName = board.letterList[index]+String(number)
                            CellView(cell: board.squares[cellName]!)
                        } else {
                            let indexNumber = 9-number
                            let cellName = board.letterList[letterIndex]+String(indexNumber)
                            CellView(cell: board.squares[cellName]!)
                        }
                    }
                }
            }
        }.border(model.darkSquareColor)
    }
}

// struct BoardView_Previews: PreviewProvider {
//    static var previews: some View {
//        BoardView()
//    }
// }
