//
//  Diamond.swift
//  Set
//
//  Created by user206692 on 11/29/21.
//

import SwiftUI

struct Diamond: Shape {
    var ratio: CGFloat = 1 / 3
    
    func path(in rect: CGRect) -> Path {
        let top = CGPoint(x: rect.midX + rect.height * ratio / 2, y: rect.midY)
        let bottom = CGPoint(x: rect.midX - rect.height * ratio / 2, y: rect.midY)
        let left = CGPoint(x: rect.midX, y: rect.midY - rect.width / 2)
        let right = CGPoint(x: rect.midX, y: rect.midY + rect.width / 2)
        var p = Path()
        p.move(to: top)
        p.addLine(to: left)
        p.addLine(to: bottom)
        p.addLine(to: right)
        return p
    }
}
