//
//  ChessView.swift
//  Openings
//
//  Created by Jaden Passero on 1/25/23.
//

import SwiftUI

struct ChessView: View {
    @EnvironmentObject var model: Model
    @State var playerColor = false
    var body: some View {
        VStack{
            Text("Opening Name").font(.largeTitle).fontWeight(.bold)
            Text("I play...")
            HStack{
                Spacer()
                Text("White")
                Toggle(isOn: $playerColor){}.tint(.black)
                Text("Black")
                Spacer()
            }
            BoardView()
        }.onChange(of: playerColor) { _ in
            model.board.flipBoard()
        }
    }
}

struct ChessView_Previews: PreviewProvider {
    static var previews: some View {
        ChessView()
    }
}
