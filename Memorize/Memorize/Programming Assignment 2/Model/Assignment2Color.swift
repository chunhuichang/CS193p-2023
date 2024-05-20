//
//  Assignment2Color.swift
//  Memorize
//
//  Created by Jill Chang on 2024/5/19.
//

import SwiftUI

enum Assignment2Color {
    static var genGradient: Gradient {
        let startColor = randomColor
        let endColor = Bool.random() ? startColor : randomColor
        return .init(colors: [startColor, endColor])
    }

    static var randomColor: Color {
        // use 256 to get full range from 0.0 to 1.0
        let hue = CGFloat(arc4random() % 256) / 256

        // from 0.5 to 1.0 to stay away from white
        let saturation = CGFloat(arc4random() % 128) / 256 + 0.5

        // from 0.5 to 1.0 to stay away from black
        let brightness = CGFloat(arc4random() % 128) / 256 + 0.5

        return Color(hue: hue, saturation: saturation, brightness: brightness, opacity: 1)
    }
}
