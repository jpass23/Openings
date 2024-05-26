//
//  Parallelogram.swift
//  Openings
//
//  Created by Jaden Passero on 5/25/24.
//

import SwiftUI

struct Parallelogram: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.maxX/6, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX/1.2, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.maxX/6, y: rect.minY))
        }
    }
}

#Preview {
    Parallelogram().frame(width: 200,height: 100)
}
