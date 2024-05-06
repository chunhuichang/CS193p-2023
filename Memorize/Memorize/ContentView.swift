//
//  ContentView.swift
//  Memorize
//
//  Created by Jill Chang on 2024/5/6.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            CardView(isFaceUp: true)
            CardView()
            CardView(isFaceUp: true)
            CardView()
        }
        .foregroundStyle(.orange)
        .padding()
    }
}

struct CardView: View {
    var isFaceUp: Bool = false

    var body: some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: 12.0)
                    .foregroundStyle(.white)
                RoundedRectangle(cornerRadius: 12.0)
                    .strokeBorder(lineWidth: 2.0)
                Text("🤪")
                    .font(.largeTitle)
            } else {
                RoundedRectangle(cornerRadius: 12.0)
            }
        }
    }
}

#Preview {
    ContentView()
}
