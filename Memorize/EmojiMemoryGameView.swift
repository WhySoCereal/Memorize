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
                    withAnimation(.linear(duration: 0.75)) {
                        self.viewModel.choose(card: card)
                    }
                    
                }
                .padding()
            }
            .padding(5)
            .foregroundColor(viewModel.theme.color)
            // "New Game" not ideal - look into localised string key
            Button("New Game") {
                withAnimation(.easeInOut(duration: 0.75)){
                    self.viewModel.newGame()
                }
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
    
    @ViewBuilder
    // If there is a list of views it combines them to one,
    // if there are no views the EmptyView is used
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(110-90), clockwise: true)
                    .padding(5)
                    .opacity(0.7)
                // Implicit animation - self contained, always applies, not coordinated with other animations
                Text(self.card.content)
                    .font(Font.system(size: fontSize(for: size)))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360:0))
                    .animation(card.isMatched ? Animation.linear(duration: 0.75).repeatForever(autoreverses: false) : .default)
            }.cardify(isFaceUp: card.isFaceUp)
                .transition(AnyTransition.scale)
                
        }
    }
    
    private func fontSize(for size: CGSize) -> CGFloat {
        return min(size.width, size.height) * 0.7
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[0])
        return EmojiMemoryGameView(viewModel: game)
    }
}
