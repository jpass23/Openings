//
//  PracticeView.swift
//  Openings
//
//  Created by Jaden Passero on 3/12/23.
//

import SwiftUI

struct PracticeView: View {
    @StateObject var board = Board()
    @State var playingColor = "White"
    
    var body: some View {
        BoardView(board: board, playingColor: $playingColor, clickable: true)
    }
}

struct PracticeView_Previews: PreviewProvider {
    static var previews: some View {
        PracticeView()
    }
}
