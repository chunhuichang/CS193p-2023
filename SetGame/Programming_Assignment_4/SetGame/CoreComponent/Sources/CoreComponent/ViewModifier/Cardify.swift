//
//  Cardify.swift
//
//
//  Created by Jill Chang on 2024/6/26.
//

import SwiftUI

struct Cardify: ViewModifier {
    let isSelected: Bool
    let isHint: Bool

    func body(content: Content) -> some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: Constants.cornerRadius)
            base
                .strokeBorder(lineWidth: Constants.lineWidth)
                .stroke(isSelected ? Constants.selectedColor : Constants.unselectedColor, lineWidth: Constants.lineWidth)
                .stroke(isHint ? Constants.hintColor : Constants.unselectedColor, lineWidth: Constants.lineWidth)
                .background(base.fill(.white))
                .overlay(content)
        }
    }

    private struct Constants {
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 3
        static let selectedColor: Color = .purple
        static let unselectedColor: Color = .clear
        static let hintColor: Color = .yellow
    }
}
