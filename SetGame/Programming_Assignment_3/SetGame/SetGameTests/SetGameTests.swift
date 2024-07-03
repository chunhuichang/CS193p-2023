//
//  SetGameTests.swift
//  SetGameTests
//
//  Created by Jill Chang on 2024/6/24.
//

@testable import SetGame
import Testing

struct SetGameTests {
    @Test func setGameInit() {
        let sut = SetGame()
        #expect(sut.deck.count == 69)
        #expect(sut.cards.count == 12)
    }
}
