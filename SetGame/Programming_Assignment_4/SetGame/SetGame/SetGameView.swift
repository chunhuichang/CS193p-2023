//
//  SetGameView.swift
//  SetGameView
//
//  Created by Jill Chang on 2024/7/8.
//

import CoreComponent
import SwiftUI

struct SetGameView: View {
    typealias Card = SetGame.Card
    @ObservedObject
    var viewModel: SetGameViewModel
    @State
    private var isGameOver = true
    @State
    private var hint: Set<Card> = []

    var body: some View {
        VStack {
            top.padding(.vertical)
            cards
            bottom.padding(.vertical)
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
            CardView(card, isHint: hint.contains(card))
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

// MARK: - Top

private extension SetGameView {
    var top: some View {
        HStack(spacing: 8) {
            Button {
                viewModel.newGame()
            } label: {
                Text("New Game")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(BorderedButtonStyle())
            Spacer()
            Text("Score: \(viewModel.score)")
                .font(.headline)
            Spacer()
            Button {
                hint = viewModel.hint()
            } label: {
                Text("Hint")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(BorderedButtonStyle())
        }
    }
}

// MARK: - Bottom

private extension SetGameView {
    var bottom: some View {
        HStack(spacing: 8) {
            Button {
                viewModel.dealThreeMoreCards()
            } label: {
                Text("Deck")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(BorderedProminentButtonStyle())
            .disabled(viewModel.deckIsEmpty)
            Spacer()
            Button {
                viewModel.shuffleDeckCard()
            } label: {
                Text("Shuffle")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(BorderedButtonStyle())
            Spacer()
            Button {} label: {
                Text("Discard pile")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(BorderedButtonStyle())
        }
    }
}

#Preview {
    SetGameView(viewModel: SetGameViewModel())
}
