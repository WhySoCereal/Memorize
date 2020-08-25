//
//  MemoryGame.swift
//  Memorize
//
//  Created by Brian Alldred on 17/08/2020.
//  Copyright © 2020 Brian Alldred. All rights reserved.
//

// MARK: - MODEL

import Foundation // All basic types

// Equatable makes sure the CardContent generic has an == operator implementation
struct MemoryGame<CardContent> where CardContent: Equatable {
    var cards: Array<Card>
    var score = 0
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        // gets from the cards array, the one face up card
        get {
            // making a new array by filtering out elements from the initial array
            cards.indices.filter { cards[$0].isFaceUp }.only
        }
        // if someone sets the the face up card, we turn all the other cards down
        set {
            for index in cards.indices {
                // newValue is the value the user set to the computed property
                // if true else false can be shortened to this
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    // , is a sequential && used a lot with the if let
    mutating func choose(card: Card) {
        if let chosenIndex = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
            
            // The card is the second card to be flipped
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    cards[chosenIndex].isFaceUp = true
                    score += 2
                } else {
                    cards[chosenIndex].isFaceUp = true
                    if cards[chosenIndex].wasFlipped {
                        score -= 1
                    } else {
                        cards[chosenIndex].wasFlipped = true
                    }
                }
            // The card is the first card to be flipped
            } else {
                cards[chosenIndex].wasFlipped = true
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            

        }
    }
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>() // Creates an empty array of cards
        
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(id: pairIndex*2, content: content))
            cards.append(Card(id: pairIndex*2+1, content: content))
        }
        
        cards.shuffle()
    }
    
    // A namespace thing
    struct Card : Identifiable {
        var id: Int
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var wasFlipped: Bool = false
        var content: CardContent // could be a String for emojis or an image, or text
        // we don't care so we make it a generic
    }
    
}
