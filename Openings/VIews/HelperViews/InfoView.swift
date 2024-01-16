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
            Section("Learn"){
                Text("Welcome to the learn view. Think about the learn section like an encyclopedia. Use it to learn the moves in an opening")
                Text("Start by choosing an opening when prompted, or click on the opening's name to switch the opening")
                Text("Then, choose the side you want to view the board from, black or white")
                Text("Use the forward and backward arrows to cycle through the moves of the given opening to memorize them")
            }
        }//.navigationTitle("Learning")
    }
}

struct PracticeInfoView: View {
    var body: some View {
        Form{
            Section("Practice"){
                Text("Feeling confident?? Try to practice one of the openings you learned in the learn section")
                Text("Again, choose an opening when prompted and choose the play color")
                Text("This time, you must play the moves for the color you chose.")
                Text("Undo or restart if you got it wrong and get one step closer to mastery when you complete it")
            }
        }//.navigationTitle("Practicing")
    }
}

#Preview {
    LearnInfoView()
}
