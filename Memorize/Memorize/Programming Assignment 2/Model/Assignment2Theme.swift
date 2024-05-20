//
//  Assignment2Theme.swift
//  Memorize
//
//  Created by Jill Chang on 2024/5/19.
//

import Foundation

enum Assignment2Theme: CaseIterable {
    case vehicle
    case sport
    case animal
    case food
    case heart
    case weather

    var icon: String {
        switch self {
        case .vehicle:
            "car"
        case .sport:
            "basketball"
        case .animal:
            "pawprint.fill"
        case .food:
            "fork.knife"
        case .heart:
            "suit.heart.fill"
        case .weather:
            "sun.max.fill"
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
        case .food:
            "Food"
        case .heart:
            "Heart"
        case .weather:
            "Weather"
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
        case .food:
            ["🍔", "🥐", "🍕", "🥗", "🍣", "🍝", "🥙", "🍤", "🥞", "🍦", "🍛", "🍗"]
        case .heart:
            ["🖤", "🩶", "🤎", "🧡", "💛", "💚", "💙", "💜", "❤️", "🩷"]
        case .weather:
            ["☀️", "🌤️", "☁️", "⛈️", "🌬️", "☔️", "❄️"]
        }
    }

    func randomCards(_ numberOfPairsOfCards: Int? = nil) -> [String] {
        let numOfPairs = numberOfPairsOfCards.map { min($0, cards.count) } ?? Int.random(in: 4 ... min(8, cards.count))
        return Array(cards.shuffled().prefix(numOfPairs))
    }
}
