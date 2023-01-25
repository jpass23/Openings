//
//  ContentView.swift
//  Openings
//
//  Created by Jaden Passero on 1/23/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var model = Model()
    var body: some View {
        Group {
            ChessView()
        }.environmentObject(model)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// MARK: Extensions
extension UIScreen {
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
}
