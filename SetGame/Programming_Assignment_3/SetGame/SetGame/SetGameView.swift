//
//  SetGameView.swift
//  SetGame
//
//  Created by Jill Chang on 2024/6/24.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject
    var viewModel: SetGameViewModel

    @State private var isGameOver = true

    var body: some View {
        VStack {
            Text("Score: \(viewModel.score)")
                .font(.headline)
            cards
            HStack {
                Button("New Game") {
                    viewModel.newGame()
                }
                .buttonStyle(BorderedButtonStyle())
                Spacer()
                Button("Deal 3 More Cards") {
                    viewModel.dealThreeMoreCards()
                }
                .buttonStyle(BorderedProminentButtonStyle())
                .disabled(viewModel.deckIsEmpty)
            }
            .padding(.vertical)
        }
        .padding()
        .alert(isPresented: $viewModel.isGameOver) {
            Alert(
                title: Text("Game Over"),
                message: Text("You scored \(viewModel.score) points!"),
                dismissButton: .default(Text("OK"), action: {
                    viewModel.newGame()
                })
            )
        }
    }
}

// MARK: - Cards

private extension SetGameView {
    private var cards: some View {
        AspectVGrid(viewModel.cards, Constants.aspectRatio) { card in
            CardView(card: card)
                .padding(Constants.spacing)
                .onTapGesture {
                    viewModel.selectCard(card)
                }
        }
    }

    private struct Constants {
        static let aspectRatio: CGFloat = 2 / 3
        static let spacing: CGFloat = 4
    }
}

#Preview {
    SetGameView(viewModel: SetGameViewModel())
}
