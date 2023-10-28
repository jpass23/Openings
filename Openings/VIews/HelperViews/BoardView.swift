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
    @StateObject var vm = BoardViewModel()
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
        }.border(model.darkSquareColor)
    }
    
    @ViewBuilder
    func cell(cellName: String) -> some View {
        if clickable{
            Button{
                vm.cellClick(cell: board.squares[cellName]!)
            }label: {
                CellView(cell: board.squares[cellName]!)
            }
        }else{
            CellView(cell: board.squares[cellName]!)
        }
    }
    
    func cellName(number: Int, letterIndex: Int) -> String {
        let index = 7-letterIndex
        let indexNumber = 9-number
        var cellName = ""
        if playingColor == "Black" {
            cellName = board.letterList[index]+String(number)
        } else {
            cellName = board.letterList[letterIndex]+String(indexNumber)
        }
        return cellName
    }
}

// struct BoardView_Previews: PreviewProvider {
//    static var previews: some View {
//        BoardView()
//    }
// }
