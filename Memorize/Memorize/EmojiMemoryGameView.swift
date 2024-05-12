//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Jill Chang on 2024/5/6.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    let emojis = ["😈", "👹", "👻", "💀", "👺", "🎃", "🧛🏻‍♂️", "🧟‍♂️", "🕷️", "🦹"]

    var body: some View {
        ScrollView {
            cards
        }
        .padding()
    }

    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
            ForEach(emojis.indices, id: \.self) { index in
                CardView(content: emojis[index], isFaceUp: true)
                    .aspectRatio(2 / 3, contentMode: .fit)
            }
        }
        .foregroundStyle(.orange)
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp = false

    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12.0)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2.0)
                Text(content)
                    .font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    EmojiMemoryGameView()
}
