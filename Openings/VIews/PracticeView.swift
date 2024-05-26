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
    @State var showPopover = false
    @State var showDialog = false

    init() {
        let board = Board()
        _board = StateObject(wrappedValue: board)
        _vm = StateObject(wrappedValue: PracticeViewModel(board: board))
    }

    var body: some View {
        ZStack {
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
                        .onTapGesture {
                            if vm.gameStarted{
                                showDialog.toggle()
                            }else{
                                playingColor = (playingColor == "White") ? "Black" : "White"
                            }
                        }
                        .confirmationDialog("Color change confirmation", isPresented: $showDialog) {
                            Button("Yes") {
                                playingColor = (playingColor == "White") ? "Black" : "White"
                                vm.resetRound()
                            }
                        } message: {
                            Text("Changing this will reset the round. Are you sure?")
                        }
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
                        } else if (!vm.gameStarted && self.playingColor == "Black"){
                            return true
                        }
                        return false
                    }())
                Spacer()
                Spacer()
                Spacer()
            }
            VStack {
                Spacer()
                if let success = vm.successfullyComplete {
                    if success {
                        Text("Well Done!")
                            .font(.title)
                            .bold()
                            .padding(.bottom, -5)
                        Button {
                            self.vm.resetRound()
                            self.showMenu.toggle()
                        } label: {
                            buttonLabel(title: "Play again?")
                        }
                    } else {
                        PairedTrapazoidButtons(title1: "Undo", title2: "Reset", func1: vm.undoMove, func2: vm.resetRound)
                    }
                }else if (!vm.gameStarted && self.playingColor == "Black"){
                    Button{
                        vm.startGame(for: self.playingColor)
                    } label: {
                        buttonLabel(title: "Start!")
                    }
                }
            }.padding(.vertical,30)
        }.sheet(isPresented: $showMenu) {} content: {
            OpeningListView(opening: $vm.opening, showMenu: $showMenu)
        }.onChange(of: vm.opening) { _ in
            self.board.resetBoard()
        }.onChange(of: vm.successfullyComplete) { _ in
            if let success = vm.successfullyComplete {
                if !success {
                    model.wrongGuessSound()
                    model.wrongGuessHaptics()
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showPopover.toggle()
                } label: {
                    Image(systemName: "info.circle")
                }
                .popover(isPresented: $showPopover, content: {
                    if #available(iOS 16.4, *) {
                        PracticeInfoView()
                            .presentationCompactAdaptation(.popover)
                            .frame(width: 300, height: 370)
                    } else {
                        PracticeInfoView()
                    }
                })
            }
        }
        .onAppear {
            vm.setup(model: self.model)
        }
    }
    
    @ViewBuilder
    func buttonLabel(title: String) -> some View {
        let gradient = LinearGradient(colors: [model.darkSquareColor.darken(),model.darkSquareColor],
                                      startPoint: .topLeading,
                                      endPoint: .bottomTrailing)
        ZStack{
            Parallelogram()
                .fill(gradient)
                .shadow(color: Color(hex: 0x666666), radius: 10, x: 5, y: 10)
                .frame(width: UIScreen.screenWidth/2,height: 80)
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .padding()
        }
    }
}

//struct PracticeView_Previews: PreviewProvider {
//    static var previews: some View {
//        PracticeView()
//    }
//}
