//
//  LandingPageView.swift
//  Openings
//
//  Created by Jaden Passero on 2/17/23.
//

import SwiftUI

struct LandingPageView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("Openings").font(.largerTitle).fontWeight(.bold)
            Spacer()
            Image(systemName: "checkerboard.rectangle").resizable().frame(width: UIScreen.screenWidth/2, height: UIScreen.screenWidth/2.5)
            Spacer()
            Group {
                NavigationLink("Learn") {
                    LearnView()
                }
                Spacer()
                NavigationLink("Practice") {
                    PracticeView()
                }
            }.buttonStyle(.bordered)
                .controlSize(.large)
            Spacer()
        }.toolbar {
            ToolbarItem {
                NavigationLink {
                    SettingsView()
                } label: {
                    Image(systemName: "gear")
                }
            }
        }
    }
}

struct LandingPageView_Previews: PreviewProvider {
    static var previews: some View {
        LandingPageView()
    }
}
