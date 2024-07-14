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
    @Namespace
    private var dealingNamespace

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
        AspectVGrid(viewModel.tableCards, Constants.aspectRatio) { card in
            cardAinimationView(card)
                .padding(Constants.spacing)
                .onTapGesture {
                    withAnimation {
                        viewModel.selectCard(card)
                    }
                }
        }
    }
}

// MARK: - Constants

private extension SetGameView {
    private struct Constants {
        static let aspectRatio: CGFloat = 2 / 3
        static let cornerRadius: CGFloat = 12
        static let spacing: CGFloat = 4
        static let deckWidth: CGFloat = 50
    }
}

// MARK: - Top

private extension SetGameView {
    var top: some View {
        HStack(spacing: 8) {
            Button {
                withAnimation {
                    viewModel.newGame()
                }
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
            deck
            Spacer()
            shuffleButton
            Spacer()
            discardPile
        }
    }
}

// MARK: - Shuffle button

private extension SetGameView {
    var shuffleButton: some View {
        Button {
            withAnimation {
                viewModel.shuffleDeckCard()
            }
        } label: {
            Text("Shuffle")
        }
        .buttonStyle(BorderedButtonStyle())
    }
}

// MARK: - Dealing to Discard pile

private extension SetGameView {
    var discardPile: some View {
        ZStack {
            ForEach(viewModel.discardCards) { card in
                cardAinimationView(card, needHint: false)
            }
        }
        .frame(width: Constants.deckWidth, height: Constants.deckWidth / Constants.aspectRatio)
    }
}

// MARK: - Dealing from a Deck

private extension SetGameView {
    var deck: some View {
        ZStack {
            ForEach(viewModel.deckCards) { card in
                RoundedRectangle(cornerRadius: Constants.cornerRadius)
                    .fill(viewModel.deckCardColor)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(AsymmetricTransition(insertion: .identity, removal: .identity))
            }
        }
        .frame(width: Constants.deckWidth, height: Constants.deckWidth / Constants.aspectRatio)
        .onTapGesture {
            withAnimation {
                viewModel.dealMoreCards()
            }
        }
    }

    func cardAinimationView(_ card: Card, needHint: Bool = true) -> some View {
        CardView(card, isHint: needHint ? hint.contains(card) : false)
            .matchedGeometryEffect(id: card.id, in: dealingNamespace)
            .transition(AsymmetricTransition(insertion: .identity, removal: .identity))
    }
}

#Preview {
    SetGameView(viewModel: SetGameViewModel())
}
