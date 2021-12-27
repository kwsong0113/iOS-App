//
//  ColorExtensions.swift
//  Memorize_Final
//
//  Created by user211007 on 12/27/21.
//

import SwiftUI

struct RGBAColor: Codable, Equatable, Hashable {
    let red: Double
    let green: Double
    let blue: Double
    let alpha: Double
}

extension Color {
    init(rgbaColor rgba: RGBAColor) {
        self.init(.sRGB, red: rgba.red, green: rgba.green, blue: rgba.blue, opacity: rgba.alpha)
    }
}

extension RGBAColor {
    init(color: Color) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        if let cgColor = color.cgColor {
            UIColor(cgColor: cgColor).getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        }
        self.init(red: Double(red), green: Double(green), blue: Double(blue), alpha: Double(alpha))
    }
}

extension Theme {
    var color: Color {
        set {
            rgbaColor = RGBAColor(color: newValue)
        }
        get {
            Color(rgbaColor: rgbaColor)
        }
    }
}
