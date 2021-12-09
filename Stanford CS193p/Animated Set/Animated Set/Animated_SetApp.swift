//
//  Animated_SetApp.swift
//  Animated Set
//
//  Created by user206692 on 12/7/21.
//

import SwiftUI

@main
struct Animated_SetApp: App {
    private let viewModel = SetGameViewModel()
    
    var body: some Scene {
        WindowGroup {
            SetGameView(viewModel: viewModel)
        }
    }
}
