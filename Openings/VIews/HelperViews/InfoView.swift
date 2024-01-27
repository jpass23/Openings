//
//  InfoView.swift
//  Openings
//
//  Created by Jaden Passero on 1/3/24.
//

import SwiftUI

struct LearnInfoView: View {
    var body: some View {
        Form{
            HStack{
                Text("\u{2022}")
                Text("Start by choosing an opening when prompted, or click on the opening's name to switch the opening")
            }
            HStack{
                Text("\u{2022}")
                Text("Then, choose the side you want to view the board from, black or white")
            }
            HStack{
                Text("\u{2022}")
                Text("Use the forward and backward arrows to cycle through the moves of the given opening to memorize them")
            }
        }
    }
}

struct PracticeInfoView: View {
    var body: some View {
        Form{
            HStack{
                Text("\u{2022}")
                Text("Start by choosing an opening when prompted, or click on the opening's name to switch the opening")
            }
            HStack{
                Text("\u{2022}")
                Text("Then, choose the side you want to view the board from, black or white")
            }
            HStack{
                Text("\u{2022}")
                Text("Play the moves for the color you chose. Undo or restart if you got it wrong and get one step closer to mastery when you complete it.")
            }
        }
    }
}

#Preview {
    LearnInfoView()
}
