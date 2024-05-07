//
//  ContentView.swift
//  Memorize
//
//  Created by Jill Chang on 2024/5/6.
//

import SwiftUI

struct ContentView: View {
    let emojis = ["😈", "👹", "👻", "💀"]

    var body: some View {
        HStack {
            ForEach(emojis.indices, id: \.self) { index in
                CardView(content: emojis[index], isFaceUp: true)
            }
        }
        .foregroundStyle(.orange)
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
