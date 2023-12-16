//
//  ChessView.swift
//  Openings
//
//  Created by Jaden Passero on 1/25/23.
//

import SwiftUI

struct LearnView: View {
    @EnvironmentObject var model: Model
    @StateObject var board = Board()
    @State var playingColor = "White"
    @State var opening: Opening?
    @State var showMenu = true
    @State var currentMove = 0
    @State var completed: Bool?

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
            BoardView(board: board, playingColor: $playingColor, clickable: false)
            Spacer()
            HStack {
                Button {
                    if opening != nil {
                        cycleMoves("backward")
                    }
                } label: {
                    ZStack {
                        Rectangle().foregroundColor(.clear).frame(width: UIScreen.screenWidth/2, height: UIScreen.screenWidth/3)
                        Image(systemName: "chevron.left")
                    }
                }

                Button {
                    if opening != nil {
                        cycleMoves("forward")
                    }
                } label: {
                    ZStack {
                        Rectangle().foregroundColor(.clear).frame(width: UIScreen.screenWidth/2, height: UIScreen.screenWidth/3)
                        Image(systemName: "chevron.right")
                    }
                }
            }
        }.sheet(isPresented: $showMenu) {} content: {
            OpeningListView(opening: $opening, showMenu: $showMenu)
        }.onChange(of: self.opening) { _ in
            self.currentMove = 0
            self.board.resetBoard()
        }
    }

    func cycleMoves(_ direction: String) {
        self.model.moveSounds()
        self.model.moveHaptics()
        if direction == "forward" {
            if currentMove < opening?.sequence.count ?? 0 {
                makeMove(move: opening?.sequence[currentMove], backwards: false)
                currentMove += 1
            }
        } else {
            if currentMove >= 1 {
                currentMove -= 1
                makeMove(move: opening?.sequence[currentMove], backwards: true)
            }
        }
    }

    func makeMove(move: Move?, backwards: Bool) {
        if let move = move {
            if backwards {
                let piece = board.squares[move.endSquare]!.piece!
                board.squares[move.endSquare]!.piece = nil
                board.squares[move.startSquare]!.piece = piece
                if move.capturedPiece != nil {
                    board.squares[move.endSquare]!.piece = move.capturedPiece
                }
                if move.castled {
                    if move.endSquare == "G1" { // Kinside white
                        makeMove(move: Move("H1", "F1"), backwards: true)
                    } else if move.endSquare == "C1" { // Queenside white
                        makeMove(move: Move("A1", "D1"), backwards: true)
                    } else if move.endSquare == "G8" { // Kingside black
                        makeMove(move: Move("H8", "F8"), backwards: true)
                    } else if move.endSquare == "C8" { // Queenside black
                        makeMove(move: Move("A8", "D8"), backwards: true)
                    }
                }
            } else { // forward
                let piece = board.squares[move.startSquare]!.piece!
                board.squares[move.startSquare]!.piece = nil
                board.squares[move.endSquare]!.piece = piece
                if move.castled {
                    if move.endSquare == "G1" { // Kinside white
                        makeMove(move: Move("H1", "F1"), backwards: false)
                    } else if move.endSquare == "C1" { // Queenside white
                        makeMove(move: Move("A1", "D1"), backwards: false)
                    } else if move.endSquare == "G8" { // Kingside black
                        makeMove(move: Move("H8", "F8"), backwards: false)
                    } else if move.endSquare == "C8" { // Queenside black
                        makeMove(move: Move("A8", "D8"), backwards: false)
                    }
                }
            }
        }
    }
}

struct ChessView_Previews: PreviewProvider {
    static var previews: some View {
        LearnView()
    }
}
