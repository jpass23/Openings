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
            HStack{
                BannerButton(title: "Learn")
                    .frame(width: 300, height: 100)
                    .padding(.vertical)
                Spacer()
            }
            HStack{
                Spacer()
                BannerButton(title: "Practice")
                    .frame(width: 300, height: 100)
                    .padding(.vertical)
            }
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
    
    func bannerButtonLabel(direction: String, title: String) -> some View {
        let gradient = LinearGradient(colors: [model.darkSquareColor.darken(),model.darkSquareColor],
                                      startPoint: .topLeading,
                                      endPoint: .bottomTrailing)
        return ZStack {
//            Banner()
//                .rotation(.degrees(direction == "left" ? 0 : 180))
//                .foregroundStyle(.black)
//                .opacity(0.5)
//                .offset(x:direction == "left" ? 5 : -5,y:10)
            Banner()
                .rotation(.degrees(direction == "left" ? 0 : 180))
                .fill(gradient)
                .shadow(color: Color(hex: 0x666666), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: direction == "left" ? 5 : -5, y: 10)
            HStack{
                if direction == "right"{
                    Spacer()
                    Image(systemName: "alternatingcurrent")
                        .resizable()
                        .frame(width: 75, height: 25)
                }
                Text(title)
                    .font(.title)
                    .bold()
                    .padding(direction == "left" ? .leading : .trailing)
                    
                if direction == "left" {
                    Image(systemName: "alternatingcurrent")
                        .resizable()
                        .frame(width: 75, height: 25)
                    Spacer()
                }
            }.foregroundStyle(.white)
        }
    }
    
    func BannerButton(title: String) -> some View {
        return NavigationLink {
            if title == "Learn" {
                LearnView()
            } else {
                PracticeView()
            }
        } label: {
            bannerButtonLabel(direction: title == "Learn" ? "left" : "right", title: title)
        }
    }
}

//struct LandingPageView_Previews: PreviewProvider {
//    static var previews: some View {
//        LandingPageView()
//    }
//}
