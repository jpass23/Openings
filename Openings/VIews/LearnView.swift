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
    @State var showPopover = false

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
            Text("View as:").font(.title)
            HStack {
                Spacer()
                Picker("View as", selection: $playingColor) {
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
                    cycleMoves("backward")
                } label: {
                    ZStack {
                        Rectangle().foregroundColor(.clear).frame(width: UIScreen.screenWidth/2, height: UIScreen.screenWidth/3)
                        Image(systemName: bkdDisabled ? "arrowshape.backward" : "arrowshape.backward.fill")
                            .resizable()
                            .frame(width: UIScreen.screenWidth/6,height: UIScreen.screenWidth/8)
                            .foregroundColor(.primary)
                    }
                }.disabled(bkdDisabled)

                Button {
                    cycleMoves("forward")
                } label: {
                    ZStack {
                        Rectangle().foregroundColor(.clear).frame(width: UIScreen.screenWidth/2, height: UIScreen.screenWidth/3)
                        Image(systemName: fwdDisabled ? "arrowshape.forward": "arrowshape.forward.fill")
                            .resizable()
                            .frame(width: UIScreen.screenWidth/6,height: UIScreen.screenWidth/8)
                            .foregroundColor(.primary)
                    }
                }.disabled(fwdDisabled)
            }
        }.sheet(isPresented: $showMenu) {} content: {
            OpeningListView(opening: $opening, showMenu: $showMenu)
        }.onChange(of: self.opening) { _ in
            self.currentMove = 0
            self.board.resetBoard()
        }.toolbar{
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showPopover.toggle()
                }label: {
                    Image(systemName: "info.circle")
                }
                .popover(isPresented: $showPopover, content: {
                    if #available(iOS 16.4, *) {
                        LearnInfoView()
                            .presentationCompactAdaptation(.popover)
                            .frame(width: 300, height: 370)
                    } else {
                        LearnInfoView()
                    }
                })
            }
        }
    }
    
    var fwdDisabled: Bool{
        if let opening = opening{
            if currentMove < opening.sequence.count{
                return false
            }
        }
        return true
    }
    var bkdDisabled: Bool{
        if let _ = opening{
            if currentMove > 0{
                return false
            }
        }
        return true
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

    func makeMove(move: Move?, backwards: Bool = false) {
        if let move = move {
            if backwards {
                if move.castled {
                    if move.endSquare == "H1" { // Kinside white
                        makeMove(move: Move("H1", "F1"), backwards: true)
                        makeMove(move: Move("E1", "G1"), backwards: true)
                    } else if move.endSquare == "A1" { // Queenside white
                        makeMove(move: Move("A1", "D1"), backwards: true)
                        makeMove(move: Move("E1", "C1"), backwards: true)
                    } else if move.endSquare == "G8" { // Kingside black
                        makeMove(move: Move("H8", "F8"), backwards: true)
                        makeMove(move: Move("E8", "G8"), backwards: true)
                    } else if move.endSquare == "C8" { // Queenside black
                        makeMove(move: Move("A8", "D8"), backwards: true)
                        makeMove(move: Move("E8", "C8"), backwards: true)
                    }
                }else{
                    let piece = board.squares[move.endSquare]!.piece!
                    board.squares[move.endSquare]!.piece = nil
                    board.squares[move.startSquare]!.piece = piece
                    if move.capturedPiece != nil {
                        board.squares[move.endSquare]!.piece = move.capturedPiece
                    }
                }
            } else { // forward
                if move.castled {
                    if move.endSquare == "H1" { // Kinside white
                        makeMove(move: Move("H1", "F1"))
                        self.makeMove(move: Move("E1", "G1"))
                    } else if move.endSquare == "A1" { // Queenside white
                        makeMove(move: Move("A1", "D1"))
                        self.makeMove(move: Move("E1", "C1"))
                    } else if move.endSquare == "G8" { // Kingside black
                        makeMove(move: Move("H8", "F8"))
                        self.makeMove(move: Move("E8", "G8"))
                    } else if move.endSquare == "C8" { // Queenside black
                        makeMove(move: Move("A8", "D8"))
                        self.makeMove(move: Move("E8", "C8"))
                    }
                }else{
                    let piece = board.squares[move.startSquare]!.piece!
                    board.squares[move.startSquare]!.piece = nil
                    board.squares[move.endSquare]!.piece = piece
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
