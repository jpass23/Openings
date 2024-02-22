//
//  Model.swift
//  Openings
//
//  Created by Jaden Passero on 2/1/23.
// https://www.mark-weeks.com/aboutcom/aa05l17.htm

import Foundation
import SwiftUI
import AVKit

class Model: ObservableObject {
    @Published var lightSquareColor = Color.white
    @Published var darkSquareColor = Color.deepGreen
    private var defaultsSet = UserDefaults.standard.bool(forKey: "defaultsSet")
    var sounds = true
    var haptics = true
    @Published var cpuDelay = 0.8
    let audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "move", ofType: "mp3")!))
    
    let sicilianClassic: [Move] = [Move("E2", "E4"), Move("C7", "C5"), Move("G1", "F3"), Move("D7", "D6"), Move("D2", "D4"), Move("C5", "D4", capturedPiece: "wpawn"), Move("F3", "D4", capturedPiece: "bpawn"), Move("G8", "F6"), Move("B1", "C3"), Move("B8", "C6")]
    let sicilianNajdorf: [Move] = [Move("E2", "E4"), Move("C7", "C5"), Move("G1", "F3"), Move("D7", "D6"), Move("D2", "D4"), Move("C5", "D4", capturedPiece: "wpawn"), Move("F3", "D4", capturedPiece: "bpawn"), Move("G8", "F6"), Move("B1", "C3"), Move("A7", "A6")]
    let ruyLopez: [Move] = [Move("E2", "E4"), Move("E7", "E5"), Move("G1", "F3"), Move("B8", "C6"), Move("F1", "B5"), Move("A7", "A6"), Move("B5", "A4"), Move("G8", "F6"), Move("E1", "H1", castled: true)]
    let italianGameTwoKnights: [Move] = [Move("E2", "E4"), Move("E7", "E5"), Move("G1", "F3"), Move("B8", "C6"), Move("F1", "C4"), Move("G8", "F6")]
    let frenchDefense: [Move] = [Move("E2", "E4"), Move("E7", "E6"), Move("D2", "D4"), Move("D7", "D5")]
    //English
    //Reti
    //Caro-kann
    //Kings Gambit
    //Queens Gambit
    //Pirc Defense
    
    var openingsList: [String: Opening] = .init()
    
    init() {
        if !defaultsSet {
            setDefualts()
        }
        sounds = UserDefaults.standard.bool(forKey: "sounds")
        haptics = UserDefaults.standard.bool(forKey: "haptics")
        cpuDelay = UserDefaults.standard.double(forKey: "delay")
        darkSquareColor = Color(hex: UserDefaults.standard.integer(forKey: "darkSquareColor"))
        self.createList()
    }
    
    func setDefualts() {
        //only runs the VERY FIRST time the app is loaded. It sets the default values if there is nothing in userDefaults
        UserDefaults.standard.set(true, forKey: "sounds")
        UserDefaults.standard.set(true, forKey: "haptics")
        UserDefaults.standard.set(0.8, forKey: "delay")
        UserDefaults.standard.set(true, forKey: "defaultsSet")
        UserDefaults.standard.set(Color.deepGreen.toHex(), forKey: "darkSquareColor")
    }
    
    func updateUserDefaults() {
        UserDefaults.standard.set(sounds, forKey: "sounds")
        UserDefaults.standard.set(haptics, forKey: "haptics")
        UserDefaults.standard.set(cpuDelay, forKey: "delay")
        UserDefaults.standard.set(darkSquareColor.toHex(), forKey: "darkSquareColor")
    }
    
    func createList() {
        // Key is displayed in list while opening.name is desplayed as title
        self.openingsList["Sicilian: Classical"] = Opening(name: "Sicilian", variation: "Classical", sequence: self.sicilianClassic)
        self.openingsList["Sicilian: Najdorf"] = Opening(name: "Sicilian", variation: "Najdorf", sequence: self.sicilianNajdorf)
        self.openingsList["Ruy Lopez"] = Opening(name: "Ruy Lopez", sequence: self.ruyLopez)
        self.openingsList["Italian Game: Two Knights' Defence"] = Opening(name: "Italian Game", variation: "Two Knights' Defense", sequence: self.italianGameTwoKnights)
        self.openingsList["French Defense"] = Opening(name: "French Defense", sequence: self.frenchDefense)
    }
    
    func reset(){
        sounds = true
        haptics = true
        cpuDelay = 0.8
        darkSquareColor = Color.deepGreen
        createList()
    }
    
    func clearData(){
        //Clear from userDefualts
        setDefualts()
        self.reset()
    }
    
    func moveSounds(){
        if self.sounds{
            self.audioPlayer.currentTime = 0
            self.audioPlayer.play()
        }
    }
    
    func moveHaptics(){
        if self.haptics{
            let impactMed = UIImpactFeedbackGenerator(style: .rigid)
                impactMed.impactOccurred()
        }
    }
    
    func wrongGuessHaptics(){
        if self.haptics{
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
        }
    }
    
    func wrongGuessSound(){
        
    }
    
    func correctGuessHaptics(){
        
    }
    
    func correctGuessSounds(){
        
    }
}
