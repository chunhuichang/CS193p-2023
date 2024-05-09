//
//  Assignment1View.swift
//  Memorize
//
//  Created by Jill Chang on 2024/5/8.
//

import SwiftUI

struct Assignment1View: View {
    @State var emojis: [String] = []

    var body: some View {
        VStack {
            title
            cardsWithScroll
            themeButtons
        }
        .padding()
        .onAppear {
            changeTheme(.vehicle)
        }
    }
}

// MARK: - Views

private extension Assignment1View {
    var title: some View {
        Text("Memorize!")
            .font(.largeTitle)
    }

    var cardsWithScroll: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 90))]) {
                ForEach(emojis.indices, id: \.self) { index in
                    Assignment1View.CardView(content: emojis[index])
                        .aspectRatio(2 / 3, contentMode: .fit)
                }
            }
            .foregroundStyle(.orange)
        }
    }

    var themeButtons: some View {
        HStack {
            Spacer()
            ForEach(Theme.allCases, id: \.self) { theme in
                Button(action: {
                    changeTheme(theme)
                }, label: {
                    VStack {
                        Image(systemName: theme.icon)
                            .imageScale(.large)
                        Text(theme.title)
                            .font(.caption)
                    }
                })
                .padding()
                Spacer()
            }
        }
    }

    struct CardView: View {
        let content: String
        @State var isFaceUp = false

        var body: some View {
            ZStack {
                let base = RoundedRectangle(cornerRadius: 12.0)
                Group {
                    base.fill(.white)
                    base.strokeBorder(lineWidth: 2.0)
                    Text(content)
                        .font(.largeTitle)
                }
                .opacity(isFaceUp ? 1 : 0)
                base.fill().opacity(isFaceUp ? 0 : 1)
            }
            .onTapGesture {
                isFaceUp.toggle()
            }
        }
    }
}

// MARK: - Themes

extension Assignment1View {
    enum Theme: CaseIterable {
        case vehicle
        case sport
        case animal

        var icon: String {
            switch self {
            case .vehicle:
                "car"
            case .sport:
                "basketball"
            case .animal:
                "pawprint.fill"
            }
        }

        var title: String {
            switch self {
            case .vehicle:
                "Vehicle"
            case .sport:
                "Sport"
            case .animal:
                "Animal"
            }
        }

        var cards: [String] {
            switch self {
            case .vehicle:
                ["🚔", "🚗", "🚒", "🚚", "🚌", "🛻", "🚎", "🚂"]
            case .sport:
                ["⚽", "🏏", "🎾", "🏄", "🏓", "🏸", "🏈", "🏀", "🥏"]
            case .animal:
                ["🐯", "🐱", "🐥", "🐰", "🐶", "🐻", "🐼", "🐹", "🦊", "🐺"]
            }
        }

        var pairOfShuffledCards: [String] {
            let list = cards
            return (list + list).shuffled()
        }
    }

    private func changeTheme(_ theme: Theme) {
        emojis = theme.pairOfShuffledCards
    }
}

// MARK: - Preview

#Preview {
    Assignment1View()
}
