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
            CardView()
            CardView()
            CardView()
            CardView()
        }
        .foregroundStyle(.orange)
        .padding()
    }
}

struct CardView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12.0)
                .foregroundStyle(.white)
            RoundedRectangle(cornerRadius: 12.0)
                .strokeBorder(lineWidth: 2.0)
            Text("🤪")
                .font(.largeTitle)
        }
    }
}

#Preview {
    ContentView()
}
