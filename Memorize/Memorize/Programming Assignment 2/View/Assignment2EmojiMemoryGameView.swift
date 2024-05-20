//
//  Assignment2EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Jill Chang on 2024/5/13.
//

import SwiftUI

struct Assignment2EmojiMemoryGameView: View {
    @ObservedObject
    var viewModel: Assignment2EmojiMemoryGame

    var body: some View {
        VStack {
            title
            cardsWithScroll
            newGameButton
        }
        .padding()
        .foregroundStyle(viewModel.color)
        .onAppear {
            viewModel.startGame()
        }
        .alert(isPresented: $viewModel.isFinishedGame) {
            Alert(
                title: Text("Game Over"),
                message: Text("Your score is \(viewModel.scores)"),
                dismissButton: .default(Text("OK")) {
                    viewModel.startGame()
                }
            )
        }
    }
}

// MARK: - View

private extension Assignment2EmojiMemoryGameView {
    var title: some View {
        VStack {
            HStack {
                Image(systemName: viewModel.theme.icon)
                    .imageScale(.small)
                Text(viewModel.theme.title)
                    .font(.largeTitle)
                Image(systemName: viewModel.theme.icon)
                    .imageScale(.small)
            }
            Text("Score:\(viewModel.scores)")
                .font(.title)
                .foregroundStyle(.black)
                .opacity(viewModel.isFinishedGame ? 0 : 1)
        }
    }

    var cardsWithScroll: some View {
        ScrollView {
            cards.animation(.default, value: viewModel.cards)
        }
    }

    var newGameButton: some View {
        Button(action: {
            viewModel.startGame()
        }, label: {
            Image(systemName: "gamecontroller.fill")
            Text("New Game")
        })
        .buttonStyle(.bordered)
    }

    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
            ForEach(viewModel.cards) { card in
                Assignment2EmojiMemoryGameView.CardView(card)
                    .aspectRatio(2 / 3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
        }
    }

    struct CardView: View {
        let card: Assignment2MemorizeGame<String>.Card

        init(_ card: Assignment2MemorizeGame<String>.Card) {
            self.card = card
        }

        var body: some View {
            ZStack {
                let base = RoundedRectangle(cornerRadius: 12.0)
                Group {
                    base.fill(.white)
                    base.strokeBorder(lineWidth: 2.0)
                    Text(card.content)
                        .font(.system(size: 200))
                        .minimumScaleFactor(0.01)
                        .aspectRatio(1, contentMode: .fit)
                }
                .opacity(card.isFaceUp ? 1 : 0)
                base.fill().opacity(card.isFaceUp ? 0 : 1)
            }
            .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
        }
    }
}

#Preview {
    Assignment2EmojiMemoryGameView(viewModel: .init())
}
