//
//  CellView.swift
//  Openings
//
//  Created by Jaden Passero on 1/25/23.
//

import SwiftUI

struct CellView: View{
    @EnvironmentObject var board: Board
    let cellName: String
    //let cell: Cell
    
    var body: some View {
        ZStack {
            Rectangle().frame(width: UIScreen.screenWidth/9, height: UIScreen.screenWidth/9).foregroundColor(board.squares[cellName]!.color)
            if let piece = board.squares[cellName]!.piece {
                Image(piece).resizable().frame(width: UIScreen.screenWidth/10, height: UIScreen.screenWidth/10)
            }
        }
    }
}

//struct CellView_Previews: PreviewProvider {
//    static var previews: some View {
//        CellView(cellName: "A1", cell: Cell(color: Color.green, piece: "wknight"))
//    }
//}
