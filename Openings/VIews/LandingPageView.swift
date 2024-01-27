//
//  LandingPageView.swift
//  Openings
//
//  Created by Jaden Passero on 2/17/23.
//

import SwiftUI

struct LandingPageView: View {
    @EnvironmentObject var model: Model
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack {
            Spacer()
            Text("Openings").font(.largerTitle).fontWeight(.bold)
            Spacer()
            Image(systemName: "checkerboard.rectangle").resizable().frame(width: UIScreen.screenWidth/2, height: UIScreen.screenWidth/2.5)
            Spacer()
            NavigationButton(title: "Learn").padding()
            NavigationButton(title: "Practice").padding()
            Spacer()
        }.toolbar {
            ToolbarItem (placement: .topBarTrailing){
                NavigationLink {
                    SettingsView()
                } label: {
                    Image(systemName: "gear")
                        .foregroundStyle(colorScheme == .dark ? .white : .black)
                }
            }
        }
    }

    func NavigationButton(title: String) -> some View {
        let gradient = LinearGradient(colors: [.primary, model.darkSquareColor],
                                      startPoint: .topLeading,
                                      endPoint: .bottomTrailing)
        return NavigationLink {
            if title == "Learn" {
                LearnView()
            } else {
                PracticeView()
            }
        } label: {
            Text(title)
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
}

//struct LandingPageView_Previews: PreviewProvider {
//    static var previews: some View {
//        LandingPageView()
//    }
//}
