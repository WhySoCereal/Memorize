//
//  Cardify.swift
//  Memorize
//
//  Created by Brian Alldred on 01/09/2020.
//  Copyright © 2020 Brian Alldred. All rights reserved.
//

import SwiftUI

// AnimatableModifier = Animatable and ViewModifier
struct Cardify: AnimatableModifier {
    var rotation: Double
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    var isFaceUp: Bool {
        rotation < 90
    }
    
    var animatableData: Double {
        get { return rotation }
        set { rotation = newValue }
    }
    
    // Content is a generic that we get from the ViewModifier protocol
    func body(content: Content) -> some View {
        ZStack {
            Group {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(lineWidth: edgeLineWidth)
                content
                
            }
            .opacity(isFaceUp ? 1 : 0) // Use opacity to hide things and make animation of views coming and going
            // Either can do transitions or opacity
            RoundedRectangle(cornerRadius: cornerRadius)
                .opacity(isFaceUp ? 0 : 1)
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0,1,0))
    }
    
    
    private let cornerRadius : CGFloat = 10.0
    private let edgeLineWidth : CGFloat = 3

}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        return self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
