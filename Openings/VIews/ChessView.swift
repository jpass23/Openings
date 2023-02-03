//
//  ChessView.swift
//  Openings
//
//  Created by Jaden Passero on 1/25/23.
//

import SwiftUI

struct ChessView: View {
    @EnvironmentObject var model: Model
    @StateObject var board = Board()
    
    @State var playingColor = "White"
    @State var opening: Opening?
    @State var showMenu = false
    @State var currentMove = 0
    
    var body: some View {
        //NavigationStack {
            VStack{
                Spacer()
                Text("I play as:").font(.title)
                HStack{
                    Spacer()
                    Picker("I play as...", selection: $playingColor) {
                        Text("White").tag("White")
                        Text("Black").tag("Black")
                    }.pickerStyle(.segmented)
                    Spacer()
                }
                Spacer()
                BoardView(board: board, playingColor: $playingColor)
                Spacer()
//                HStack {
//                    Text("Moves: ")
//                    Spacer()
//                }.padding()
                HStack{
                    Button{
                        if opening != nil {
                            cycleMoves("backward")
                        }
                    }label: {
                        ZStack{
                            Rectangle().foregroundColor(.clear).frame(width: UIScreen.screenWidth/2, height: UIScreen.screenWidth/3)
                            Image(systemName: "chevron.left")
                        }
                    }
                    
                    Button{
                        if opening != nil {
                            cycleMoves("forward")
                        }
                    }label: {
                        ZStack{
                            Rectangle().foregroundColor(.clear).frame(width: UIScreen.screenWidth/2, height: UIScreen.screenWidth/3)
                            Image(systemName: "chevron.right")
                        }
                    }
                }
            }.toolbar{
                ToolbarItem (placement: .navigationBarLeading){
                    Button{
                        showMenu.toggle()
                    }label: {
                        if let opening = opening{
                            Text(opening.name).font(.largeTitle).fontWeight(.bold).foregroundColor(.primary)
                        }else{
                            Text("Click to choose opening...").font(.title).fontWeight(.bold).foregroundColor(.primary)
                        }
                        //Text(opening?.name ?? "Choose an opening...").font(.largeTitle).fontWeight(.bold).foregroundColor(.primary)
                    }
                }
            }.sheet(isPresented: $showMenu) {} content: {
                OpeningListView(opening: $opening, showMenu: $showMenu)
            }.environmentObject(board)
            .onChange(of: self.opening) { newValue in
                self.playingColor = "White"
                self.showMenu = false
                self.currentMove = 0
            }
        //} //NavigationStack
    }
    
    func cycleMoves(_ direction: String){
        if direction == "forward"{
            if (currentMove < opening?.sequence.count ?? 0){
                makeMove(move: opening?.sequence[currentMove], backwards: false)
                currentMove += 1
            }
        }else{
            if currentMove >= 1{
                currentMove -= 1
                makeMove(move: opening?.sequence[currentMove], backwards: true)
//                let startSqare = (opening?.sequence[currentMove].endSquare)!
//                let endSquare = (opening?.sequence[currentMove].startSquare)!
//                if let capturedPiece = opening?.sequence[currentMove].capturedPiece{
//                    makeMove(move: Move(startSqare, endSquare, capturedPiece: capturedPiece), backwards: true)
//                }else{
//                    makeMove(move: Move(startSqare, endSquare), backwards: true)
//                }
            }
            // Do other things
        }
    }
    
    func makeMove(move: Move?, backwards: Bool){
        if let move = move{
            if backwards{
                let piece = board.squares[move.endSquare]!.piece!
                board.squares[move.endSquare]!.piece = nil
                board.squares[move.startSquare]!.piece = piece
                if move.capturedPiece != nil {
                    board.squares[move.endSquare]!.piece = move.capturedPiece
                }
            }else{
                let piece = board.squares[move.startSquare]!.piece!
                board.squares[move.startSquare]!.piece = nil
                board.squares[move.endSquare]!.piece = piece
            }
        }
    }
}

struct ChessView_Previews: PreviewProvider {
    static var previews: some View {
        ChessView()
    }
}
