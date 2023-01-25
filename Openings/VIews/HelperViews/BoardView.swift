//
//  BoardView.swift
//  Openings
//
//  Created by Jaden Passero on 1/24/23.
//

import SwiftUI

struct BoardView: View {
    @EnvironmentObject var model: Model
    var body: some View {
        Grid(horizontalSpacing: 0, verticalSpacing: 0){
            ForEach(0..<8){ row in
                GridRow{
                    ForEach(0..<8){ column in
                        CellView(row: row, column: column)
                    }
                }
            }
        }.border(.green)
    }
}

struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        BoardView()
    }
}
