//
//  Diamond.swift
//  Animated Set
//
//  Created by user206692 on 12/9/21.
//

import SwiftUI

struct Diamond: Shape {
    var ratio: CGFloat = 2 / 1
    var scale: CGFloat = 1
    
    func path(in rect: CGRect) -> Path {
        let top = CGPoint(x: rect.midX, y: rect.midY + scale * rect.height / 2)
        let bottom = CGPoint(x: rect.midX, y: rect.midY - scale * rect.height / 2)
        let left = CGPoint(x: rect.midX - scale * rect.width / 2, y: rect.midY)
        let right = CGPoint(x: rect.midX + scale * rect.width / 2, y: rect.midY)
        var p = Path()
        p.move(to: top)
        p.addLine(to: left)
        p.addLine(to: bottom)
        p.addLine(to: right)
        p.addLine(to: top)
        return p
    }
}
