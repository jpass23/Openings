//
//  CellView.swift
//  Openings
//
//  Created by Jaden Passero on 1/25/23.
//

import SwiftUI

struct CellView: View {
    @EnvironmentObject var model: Model
    let row: Int
    let column: Int
    
    var body: some View {
        ZStack {
            Rectangle().frame(width: UIScreen.screenWidth/9, height: UIScreen.screenWidth/9).foregroundColor(model.board.cells[row][column].color)
            if let imageName = model.board.cells[row][column].piece?.name{
                Image(imageName).resizable().frame(width: UIScreen.screenWidth/10, height: UIScreen.screenWidth/10)
            }
        }
    }
}

//struct CellView_Previews: PreviewProvider {
//    static var previews: some View {
//        CellView()
//    }
//}
