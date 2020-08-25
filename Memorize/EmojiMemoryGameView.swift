//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Brian Alldred on 17/08/2020.
//  Copyright © 2020 Brian Alldred. All rights reserved.
//

// MARK: - THE VIEW

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            Text(viewModel.theme.name)
                .bold()
                .font(.title)
            Text("Score: \(viewModel.score)")
            Divider()
            Grid(viewModel.cards) { card in
                CardView(card: card).onTapGesture { // gets the tapped card
                    self.viewModel.choose(card: card)
                }
                .padding()
                .aspectRatio(2/3, contentMode: .fit)
            }
            .padding(5)
            .foregroundColor(viewModel.theme.color)
            Button("New Game") {
                self.viewModel.newGame()
            }
            .foregroundColor(.black)
            .font(.headline)
        }

    }
}

struct CardView: View {
    var card : MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader{ (geometry) in
            self.body(for: geometry.size)
        }
    }
    
    func body(for size: CGSize) -> some View {
        ZStack {
            if self.card.isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(lineWidth: edgeLineWidth)
                Text(self.card.content)
            } else {
                if !card.isMatched {
                    RoundedRectangle(cornerRadius: cornerRadius).fill()
                }
            }
        }
        .font(Font.system(size: fontSize(for: size)))
    }
    
    let cornerRadius : CGFloat = 10.0
    let edgeLineWidth : CGFloat = 3
    func fontSize(for size: CGSize) -> CGFloat {
        return min(size.width, size.height) * 0.75
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
