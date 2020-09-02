//
//  Cardify.swift
//  Memorize
//
//  Created by Brian Alldred on 01/09/2020.
//  Copyright © 2020 Brian Alldred. All rights reserved.
//

import SwiftUI

struct Cardify: ViewModifier {
    var isFaceUp: Bool
    
    // Content is a generic that we get from the ViewModifier protocol
    func body(content: Content) -> some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(lineWidth: edgeLineWidth)
                content
            } else {
                RoundedRectangle(cornerRadius: cornerRadius)
            }
        }
    }
    
    
    private let cornerRadius : CGFloat = 10.0
    private let edgeLineWidth : CGFloat = 3

}
