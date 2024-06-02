//
//  Cardify.swift
//  Memorize
//
//  Created by Jill Chang on 2024/6/2.
//

import SwiftUI

struct Cardify: ViewModifier {
    let isFaceUp: Bool
    func body(content: Content) -> some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: Constants.cornerRadius)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: Constants.lineWidth)
                content
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill()
                .opacity(isFaceUp ? 0 : 1)
        }
    }

    private struct Constants {
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 2
    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        modifier(Cardify(isFaceUp: isFaceUp))
    }
}

struct Cardify_Previews: PreviewProvider {
    struct ContentView: View {
        var body: some View {
            VStack {
                HStack {
                    Text("🐱")
                        .cardify(isFaceUp: false)
                        .foregroundStyle(.orange)
                    Text("🐱")
                        .cardify(isFaceUp: true)
                        .foregroundStyle(.orange)
                }
                HStack {
                    Text("🐰")
                        .cardify(isFaceUp: false)
                        .foregroundStyle(.gray)
                    Text("🐰")
                        .cardify(isFaceUp: true)
                        .foregroundStyle(.gray)
                }
            }
            .padding()
        }
    }

    static var previews: some View {
        ContentView()
    }
}
