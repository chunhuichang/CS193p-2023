//
//  ContentView.swift
//  Memorize
//
//  Created by Jill Chang on 2024/5/6.
//

import SwiftUI

struct ContentView: View {
    let emojis = ["😈", "👹", "👻", "💀", "👺", "🎃", "🧛🏻‍♂️", "🧟‍♂️", "🕷️", "🦹"]
    @State var cardCount = 4

    var body: some View {
        VStack {
            HStack {
                ForEach(0 ..< cardCount, id: \.self) { index in
                    CardView(content: emojis[index], isFaceUp: true)
                }
            }
            .foregroundStyle(.orange)

            HStack {
                Button(action: {
                    if cardCount > 1 {
                        cardCount -= 1
                    }
                }, label: {
                    Image(systemName: "minus.circle.fill")
                })
                Spacer()
                Button(action: {
                    if cardCount < emojis.count {
                        cardCount += 1
                    }
                }, label: {
                    Image(systemName: "plus.circle.fill")
                })
            }
            .imageScale(.large)
            .font(.largeTitle)
        }
        .padding()
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp = false

    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12.0)
            if isFaceUp {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2.0)
                Text(content)
                    .font(.largeTitle)
            } else {
                base.fill()
            }
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
