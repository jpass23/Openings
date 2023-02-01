//
//  BoardView.swift
//  Openings
//
//  Created by Jaden Passero on 1/24/23.
//

import SwiftUI

struct BoardView: View {
    @StateObject var board = Board()
    @Binding var playingBlack: Bool

    var body: some View {
        Grid(horizontalSpacing: 0, verticalSpacing: 0){
            ForEach(1..<9){ number in
                GridRow{
                    ForEach(0..<8){ letterIndex in
                        if playingBlack{
                            CellView(cellName: board.letterList[7-letterIndex]+String(number))
                        }else{
                            CellView(cellName: board.letterList[letterIndex]+String(9-number))
                        }
                    }
                }
            }
        }.border(.green)
            .environmentObject(board)
    }
}

//struct BoardView_Previews: PreviewProvider {
//    static var previews: some View {
//        BoardView()
//    }
//}
