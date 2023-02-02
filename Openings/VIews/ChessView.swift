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
    
    @State var playingBlack = false
    @State var opening: Opening?
    @State var showMenu = false
    @State var currentMove = 0
    
    var body: some View {
        NavigationStack {
            VStack{
                Text("I play...")
                HStack{
                    Spacer()
                    Text("White")
                    Toggle(isOn: $playingBlack){}.tint(.black)
                    Text("Black")
                    Spacer()
                }
                BoardView(board: board, playingBlack: $playingBlack)
                Spacer()
                HStack {
                    Text("Moves: ")
                    Spacer()
                }
                HStack{
                    Button{

                    }label: {
                        ZStack{
                            Rectangle().foregroundColor(.clear).frame(width: UIScreen.screenWidth/2, height: UIScreen.screenWidth/3)
                            Image(systemName: "chevron.left")
                        }
                    }
                    
                    Button{
                        cycleMoves("forward")
                    }label: {
                        ZStack{
                            Rectangle().foregroundColor(.clear).frame(width: UIScreen.screenWidth/2, height: UIScreen.screenWidth/3)
                            Image(systemName: "chevron.right")
                        }
                    }
                }
            }.navigationTitle(opening?.name ?? "No Opening")
            .toolbar{
                ToolbarItem{
                    Button{
                        showMenu.toggle()
                    }label: {
                        Image(systemName: "line.3.horizontal")
                    }
                }
            }.sheet(isPresented: $showMenu) {} content: {
                OpeningListView(opening: $opening, showMenu: $showMenu)
            }
        }.environmentObject(board)
    }
    
    func cycleMoves(_ direction: String){
        if direction == "forward"{
            if (currentMove < opening?.sequence.count ?? 0){
                makeMove(move: opening?.sequence[currentMove])
            }
            currentMove += 1
        }else{
            // Do other things
        }
    }
    
    func makeMove(move: Move?){
        if let localMove = move{
            let startCell = board.squares[localMove.startSquare]!
            let endCell = board.squares[localMove.endSquare]!
            let piece = startCell.piece!
            board.squares[localMove.startSquare]!.piece = nil
            
            if endCell.piece == nil{
                board.squares[localMove.endSquare]!.piece = piece
            }else{
                //localMove.capturedPiece = piece
                //set captured piece to piece
                board.squares[localMove.endSquare]!.piece = piece
            }
        }
    }
}

struct ChessView_Previews: PreviewProvider {
    static var previews: some View {
        ChessView()
    }
}
