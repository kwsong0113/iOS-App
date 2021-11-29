//
//  SetApp.swift
//  Set
//
//  Created by user206692 on 11/26/21.
//

import SwiftUI

@main
struct SetApp: App {
    private let viewModel = SetGameViewModel()
    
    var body: some Scene {
        WindowGroup {
            SetGameView(viewModel: viewModel)
        }
    }
}
