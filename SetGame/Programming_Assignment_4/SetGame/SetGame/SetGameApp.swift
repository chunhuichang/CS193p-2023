//
//  SetGameApp.swift
//  SetGame
//
//  Created by Jill Chang on 2024/7/8.
//

import SwiftUI

@main
struct SetGameApp: App {
    @StateObject
    var game = SetGameViewModel()

    var body: some Scene {
        WindowGroup {
            SetGameView(viewModel: game)
        }
    }
}
