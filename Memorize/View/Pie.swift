//
//  Pie.swift
//  Memorize
//
//  Created by Brian Alldred on 01/09/2020.
//  Copyright © 2020 Brian Alldred. All rights reserved.
//

import SwiftUI

// Shapes assumed to be able to do animation
struct Pie: Shape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool = false
    
    // delegate - only entry point
    var animatableData: AnimatablePair<Double, Double> {
        get {
            AnimatablePair(startAngle.radians, endAngle.radians)
        }
        set {
            startAngle = Angle.radians(newValue.first)
            endAngle = Angle.radians(newValue.second)
        }
    }
    
    func path(in rect: CGRect) -> Path {
        let radius = min(rect.height, rect.width) / 2
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let start = CGPoint(x: center.x + radius * cos(CGFloat(startAngle.radians)),
                            y: center.y + radius * sin(CGFloat(startAngle.radians)))
        
        var p = Path()
        p.move(to: center)
        p.addLine(to: start)
        p.addArc(center: center,
                 radius: radius,
                 startAngle: startAngle,
                 endAngle: endAngle,
                 clockwise: clockwise)
        p.addLine(to: center)
        
        return p
    }
}
