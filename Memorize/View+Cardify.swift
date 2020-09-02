//
//  View+Cardify.swift
//  Memorize
//
//  Created by Brian Alldred on 01/09/2020.
//  Copyright © 2020 Brian Alldred. All rights reserved.
//

import SwiftUI

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        return self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
