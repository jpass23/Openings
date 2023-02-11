//
//  ContentView.swift
//  Openings
//
//  Created by Jaden Passero on 1/23/23.
//

import SwiftUI

extension Font {
    static let largerTitle = Font.system(size: UIScreen.screenWidth/7)
}

struct ContentView: View {
    @StateObject var model = Model()
    var body: some View {
        NavigationStack {
            VStack{
                Spacer()
                Text("Openings").font(.largerTitle).fontWeight(.bold)
                Spacer()
                Image(systemName: "checkerboard.rectangle").resizable().frame(width: UIScreen.screenWidth/2, height: UIScreen.screenWidth/2.5)
                Spacer()
                Group{
                    NavigationLink ("Learn"){
                        ChessView()
                    }
                    Spacer()
                    NavigationLink ("Practice"){
                        
                    }
                }.buttonStyle(.bordered)
                    .controlSize(.large)
                Spacer()
            }.toolbar{
                ToolbarItem{
                    NavigationLink{
                        //SettingsView
                    }label:{
                        Image(systemName: "gear")
                    }
                }
            }
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
