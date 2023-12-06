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
    @State var opening: Opening?
    @State var showMenu = false
    
    var body: some View {
        VStack {
            Button {
                showMenu.toggle()
            } label: {
                HStack {
                    if let opening = opening {
                        Text(opening.name).font(.largeTitle).fontWeight(.bold)
                    } else {
                        Text("Select Opening").font(.title).fontWeight(.bold)
                    }
                    Image(systemName: "chevron.down")
                }.foregroundColor(.primary)
            }
            Spacer()
            Text("I play as:").font(.title)
            HStack {
                Spacer()
                Picker("I play as...", selection: $playingColor) {
                    Text("White").tag("White")
                    Text("Black").tag("Black")
                }.pickerStyle(.segmented)
                Spacer()
            }
            Spacer()
            BoardView(vm: BoardViewModel(board: board), playingColor: $playingColor, clickable: true)
            Spacer()
            Spacer()
        }.sheet(isPresented: $showMenu) {} content: {
            OpeningListView(opening: $opening, showMenu: $showMenu)
        }.onChange(of: self.opening) { _ in
            self.board.resetBoard()
        }
    }
}

struct PracticeView_Previews: PreviewProvider {
    static var previews: some View {
        PracticeView()
    }
}
