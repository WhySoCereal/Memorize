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
    private(set) var cards: Array<Card> // Setting this is private but reading it is not
    var score = 0
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        // gets from the cards array, the one face up card, will set to nil if two cards are face up
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
                    score += 2
                } else {
                    if cards[chosenIndex].wasFlipped {
                        score -= 1
                    } else {
                        cards[chosenIndex].wasFlipped = true
                    }
                    if cards[potentialMatchIndex].wasFlipped {
                        score -= 1
                    } else {
                        cards[potentialMatchIndex].wasFlipped = true
                    }
                }
                cards[chosenIndex].isFaceUp = true
            // The card is the first card to be flipped
            } else {
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
        var isFaceUp: Bool = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        
        var isMatched: Bool = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        var wasFlipped: Bool = false
        var content: CardContent // could be a String for emojis or an image, or text
        // we don't care so we make it a generic
        
        
        // MARK: - Bonus Time

        // this could give matching bonus points
        // if the user matches the card
        // before a certain amount of time passes during which the card is face up

        // can be zero which means "no bonus availiable" for this card
        var bonusTimeLimit: TimeInterval = 6
        
        // how long this card has been face up
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        
        // the last time this card was turned face up (and is still face up)
        var lastFaceUpDate: Date?
        // the accumulated time this card has been face up in the past
        // (i.e. not including the current time it's been face up if it is currently so)
        var pastFaceUpTime: TimeInterval = 0
        
        // how much time left before the bonus opportunity runs out
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        
        // percentage of bonus time remaining
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
        }
        
        // whether the card was matched during the bonus time period
        var hasEarnedBonus: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        // whether we are currently face up, unmatched and have not yet used up the bonus window
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        // called when the card transitions to face up state
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        // called when the card goes back face down (or gets matched)
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }
    }
    
}




