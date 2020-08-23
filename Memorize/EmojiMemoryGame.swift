//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Brian Alldred on 17/08/2020.
//  Copyright © 2020 Brian Alldred. All rights reserved.
//

// MARK: - ViewModel
// take independant model game and translate it to be displayed as a Emoji memory game
// Portals for views to access the model, a doorway

import SwiftUI

class EmojiMemoryGame : ObservableObject {
    // A class - easy to share - lives in heap, has pointers. All views can have pointers to it. Many Views can see the portal onto the model
    // Problem with many Views pointing to same model - if a changed might mess for everyone.
    // Mitigate by closing the door, marking the variables private so rogue Views can't access the variables and write to them
    // Or use private(set) - a glass door, everyone can see through, but nobody can set
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    // Published wrapper calls objectWillChange.send() whenever there is a change to the variable
    
    
    // Cannot use any functions on our class until all of the variables are initilised so have to make it static
    static func createMemoryGame() -> MemoryGame<String> {
        let emojis: Array<String> = ["👻", "🎃", "🕷", "🤡", "👽"]
        let numberPairs = Int.random(in: 2...4)
        return MemoryGame<String>(numberOfPairsOfCards: numberPairs)
        { pairIndex in emojis[pairIndex] }
    }
    
    // MARK: - Access to the model
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    // MARK: - Intent(s)
    // What the user might want to do
    // Like documentation, here's all the things you can do to change the model
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
}
