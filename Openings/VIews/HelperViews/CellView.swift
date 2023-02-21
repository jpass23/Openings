//
//  CellView.swift
//  Openings
//
//  Created by Jaden Passero on 1/25/23.
//

import SwiftUI

struct CellView: View {
    @EnvironmentObject var model: Model
    // let cellName: String
    @ObservedObject var cell: Cell
    var cellColor: Color {
        if cell.isDarkSquare{
            return model.darkSquareColor
        }
        return model.lightSquareColor
    }

    var body: some View {
        ZStack {
            Rectangle().frame(width: UIScreen.screenWidth/9, height: UIScreen.screenWidth/9).foregroundColor(cellColor)
            if let piece = cell.piece {
                Image(piece).resizable().frame(width: UIScreen.screenWidth/10, height: UIScreen.screenWidth/10)
            }
        }
    }
}

// struct CellView_Previews: PreviewProvider {
//    static var previews: some View {
//        CellView(cellName: "A1", cell: Cell(color: Color.green, piece: "wknight"))
//    }
// }
