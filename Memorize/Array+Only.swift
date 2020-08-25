//
//  Array+Only.swift
//  Memorize
//
//  Created by Brian Alldred on 24/08/2020.
//  Copyright © 2020 Brian Alldred. All rights reserved.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
