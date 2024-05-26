//
//  PairedTrapazoidButtons.swift
//  Openings
//
//  Created by Jaden Passero on 5/25/24.
//

import SwiftUI

struct PairedTrapazoidButtons: View {
    @EnvironmentObject var model: Model
    let title1: String
    let title2: String
    let func1: () -> Void
    let func2: () -> Void
    var body: some View {
        ZStack{
            HStack{
                Button{
                    func1()
                }label: {
                    trapazoidButtonLabel(side: "left", title: title1)
                        .padding(.vertical)
                        .frame(width: 0.53*UIScreen.screenWidth, height: 100)
                }
                Spacer()
            }
            HStack{
                Spacer()
                Button{
                    func2()
                }label: {
                    trapazoidButtonLabel(side: "right", title: title2)
                        .padding(.vertical)
                        .frame(width: 0.53*UIScreen.screenWidth, height: 100)
                }
            }
        }
    }
    
    @ViewBuilder
    func trapazoidButtonLabel(side: String, title: String) -> some View{
        let gradient = LinearGradient(colors: [model.darkSquareColor.darken(),model.darkSquareColor],
                                      startPoint: .topLeading,
                                      endPoint: .bottomTrailing)
        ZStack{
            RightTrapazoid()
                .rotation(.degrees(side == "left" ? 0 : 180))
                .fill(gradient)
                .shadow(color: Color(hex: 0x666666), radius: 10, x: side == "left" ? 5 : -5, y: 10)
            HStack{
                Spacer()
                if (side != "left"){
                    Spacer()
                }
                Text(title)
                    .font(.title)
                    .foregroundStyle(.white)
                    .bold()
                    .padding(side == "left" ? .leading : .trailing)
                if (side == "left"){
                    Spacer()
                }
                Spacer()
            }
        }
    }
}

//#Preview {
//    PairedTrapazoidButtons()
//}
