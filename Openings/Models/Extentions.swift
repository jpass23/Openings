//
//  Extentions.swift
//  Openings
//
//  Created by Jaden Passero on 3/7/24.
//

import Foundation
import SwiftUI

extension String {

    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }

        return String(data: data, encoding: .utf8)
    }

    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }

}

extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}

extension Color {
    static let deepGreen = Color(red: 47/255, green: 109/255, blue: 64/255)
    static let royalPurple = Color(red: 113/255, green: 91/255, blue: 192/255)
    func darken() -> Color {
        if let components = cgColor?.components {
            let r = components[0]
            let g = components[1]
            let b = components[2]
            return Color(red: r-0.2, green: g-0.2, blue: b-0.2)
        } else {
            return Color(red: 0.7, green: 0.7, blue: 0.7)
        }
    }
    
    func toHex() -> Int {
        var hexVal = 0x000000
        if let components = cgColor?.components {
            let r = Int(components[0] * 255)
            let g = Int(components[1] * 255)
            let b = Int(components[2] * 255)
            
            let hexR = ((r<<16) & 0xFF0000)
            let hexG = ((g<<8) & 0x00FF00)
            let hexB = (b & 0x0000FF)
            hexVal = hexR | hexG | hexB
        }
        return hexVal
    }
    
    init(hex: Int, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 08) & 0xFF) / 255,
            blue: Double((hex >> 00) & 0xFF) / 255,
            opacity: alpha
        )
    }
}

extension String {
    func isSameColor(as pieceName: String) -> Bool {
        return self[0] == pieceName[0]
    }
}
