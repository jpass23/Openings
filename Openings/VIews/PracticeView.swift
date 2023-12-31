//
//  PracticeView.swift
//  Openings
//
//  Created by Jaden Passero on 3/12/23.
//

import SwiftUI

struct PracticeView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var model: Model
    @StateObject var board: Board
    @StateObject var vm: PracticeViewModel
    @State var playingColor = "White"
    @State var showMenu = true

    init() {
        let board = Board()
        _board = StateObject(wrappedValue: board)
        _vm = StateObject(wrappedValue: PracticeViewModel(board: board))
    }

    var body: some View {
        ZStack{
            VStack {
                Button {
                    showMenu.toggle()
                } label: {
                    HStack {
                        if let opening = vm.opening {
                            Text(opening.name).font(.largeTitle).fontWeight(.bold)
                        } else {
                            Text("Select Opening").font(.title).fontWeight(.bold)
                        }
                        Image(systemName: "chevron.down")
                    }.foregroundColor(.primary)
                }
                Spacer()
                Text("Play as:").font(.title)
                HStack {
                    Spacer()
                    Picker("I play as...", selection: $playingColor) {
                        Text("White").tag("White")
                        Text("Black").tag("Black")
                    }.pickerStyle(.segmented)
                    Spacer()
                }
                Spacer()
                BoardView(board: board, playingColor: $playingColor, onClick: vm.cellClick, clickable: true)
                    .offset(x: vm.shake ? 10 : 0)
                    .disabled({
                        if let _ = vm.successfullyComplete {
                            return true
                        } else if vm.opening == nil {
                            return true
                        }
                        return false
                    }())
                Spacer()
                Spacer()
                Spacer()
            }.sheet(isPresented: $showMenu) {} content: {
                OpeningListView(opening: $vm.opening, showMenu: $showMenu)
            }.onChange(of: vm.opening) { _ in
                self.board.resetBoard()
            }.onChange(of: vm.successfullyComplete) { _ in
                if let success = vm.successfullyComplete{
                    if !success{
                        model.wrongGuessSound()
                        model.wrongGuessHaptics()
                    }
                }
            }
            VStack{
                Spacer()
                if let success = vm.successfullyComplete{
                    if success{
                        Button{
                            
                        }label: {
                            buttonLabel(title: "Yay!")
                        }
                    }else{
                        HStack (spacing: 40){
                            Button{
                                vm.undoMove()
                            } label: {
                                buttonLabel(title: "Undo")
                            }
                            Button{
                                vm.resetBoard()
                            } label: {
                                buttonLabel(title: "Reset")
                            }
                        }
                    }
                }
            }.padding(30)
        }
    }
    
    func buttonLabel(title: String) -> some View {
        let gradient = LinearGradient(colors: [.primary, model.darkSquareColor],
                                      startPoint: .topLeading,
                                      endPoint: .bottomTrailing)
        return Text(title)
            .font(.title)
            .fontWeight(.bold)
            .foregroundStyle(colorScheme == .dark ? .white : .black)
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(gradient, lineWidth: 3)
                    .saturation(colorScheme == .dark ? 1 : 3)
            }
    }
}

struct PracticeView_Previews: PreviewProvider {
    static var previews: some View {
        PracticeView()
    }
}
