//
//  MemoryGame.swift
//  Memorize
//
//  Created by Brian Alldred on 17/08/2020.
//  Copyright © 2020 Brian Alldred. All rights reserved.
//

// MARK: - MODEL

import Foundation // All basic types

struct MemoryGame<CardContent> {
    var cards: Array<Card>
    
    func choose(card: Card) {
        print("card chosen: \(card)")
    }
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>() // Creates an empty array of cards
        
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(id: pairIndex*2, content: content))
            cards.append(Card(id: pairIndex*2+1, content: content))
        }
    }
    
    // A namespace thing
    struct Card : Identifiable {
        var id: Int
        var isFaceUp: Bool = true
        var isMatched: Bool = true
        var content: CardContent // could be a String for emojis or an image, or text
        // we don't care so we make it a generic
    }
    
}
