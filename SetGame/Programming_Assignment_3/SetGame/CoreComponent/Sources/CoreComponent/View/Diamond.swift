//
//  Diamond.swift
//
//
//  Created by Jill Chang on 2024/6/26.
//

import SwiftUI

public struct Diamond: Shape {
    public init() {}
    
    public func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let width = rect.width * 0.5
        let height = rect.height * 0.5

        // top point
        path.move(to: CGPoint(x: center.x, y: center.y - height))
        // right point
        path.addLine(to: CGPoint(x: center.x + width, y: center.y))
        // bottom point
        path.addLine(to: CGPoint(x: center.x, y: center.y + height))
        // left point
        path.addLine(to: CGPoint(x: center.x - width, y: center.y))
        path.closeSubpath()

        return path
    }
}
