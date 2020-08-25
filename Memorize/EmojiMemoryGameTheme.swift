//
//  EmojiMemoryGameTheme.swift
//  Memorize
//
//  Created by Brian Alldred on 24/08/2020.
//  Copyright © 2020 Brian Alldred. All rights reserved.
//

import SwiftUI

/*
    A theme consists of a name for
    the theme, a set of emoji to use, a number of cards to show (which, for at least one,
    but not all themes, should be random), and an appropriate color to use to draw (e.g.
    orange would be appropriate for a Halloween theme).
 */
enum EmojiMemoryGameTheme : CaseIterable {
    case halloween
    case travel
    case animal
    case sport
    case food
    case flag
    
    var emojis: Array<String> {
        switch self {
        case .halloween:
            return ["👻", "🎃", "🕷", "🤡", "👽"]
        case .travel:
            return ["🚗", "🚙", "🚛", "🚌", "🚑"]
        case .animal:
            return ["🐶", "🐨", "🐮", "🐸", "🐼"]
        case .sport:
            return ["⚽️", "🏈", "🏀", "🏐", "🏉"]
        case .food:
            return ["🍙", "🌮", "🍗", "🍓", "🥦"]
        case .flag:
            return ["🇦🇺", "🏳️‍🌈", "🇨🇳", "🇨🇦", "🇬🇧"]
        }
    }
    
    var color: Color {
        switch self {
        case .halloween:
            return Color.orange
        case .travel:
            return Color.blue
        case .animal:
            return Color.green
        case .sport:
            return Color.black
        case .food:
            return Color.purple
        case .flag:
            return Color.red
        }
    }
    
    var name: String {
        switch self {
        case .halloween:
            return "Halloween"
        case .travel:
            return "Travel"
        case .animal:
            return "Animal"
        case .sport:
            return "Sport"
        case .food:
            return "Food"
        case .flag:
            return "Flag"
        }
    }
    
    static func randomCase() -> EmojiMemoryGameTheme {
        EmojiMemoryGameTheme.allCases.randomElement()!
    }
}

