//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Jill Chang on 2024/5/6.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject
    var game = EmojiMemoryGame()

    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
