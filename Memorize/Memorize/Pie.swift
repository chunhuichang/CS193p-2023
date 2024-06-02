//
//  Pie.swift
//  Memorize
//
//  Created by Jill Chang on 2024/5/31.
//

import CoreGraphics
import SwiftUI

struct Pie: Shape {
    let startAngle: Angle = .zero
    let endAngle: Angle
    let clockwise: Bool = true
    func path(in rect: CGRect) -> Path {
        // start from top
        let startAngle = startAngle - .degrees(90)
        let endAngle = endAngle - .degrees(90)

        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        let start = CGPoint(x: center.x + radius * cos(startAngle.radians),
                            y: center.y + radius * sin(startAngle.radians))

        var path = Path()
        path.move(to: center)
        path.addLine(to: start)
        path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: !clockwise)
        path.addLine(to: center)

        return path
    }
}

struct Pie_Previews: PreviewProvider {
    struct ContentView: View {
        var body: some View {
            Pie(endAngle: .degrees(240))
//                .stroke(lineWidth: 5)
                .fill(.blue)
                .opacity(0.5)
        }
    }

    static var previews: some View {
        ContentView()
    }
}
