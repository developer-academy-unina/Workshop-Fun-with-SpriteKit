//
//  Constants.swift
//  ArcadeGameTemplate
//
//  Created by Tiago Pereira on 07/03/22.
//

import Foundation
import SwiftUI

enum GameState {
    case mainScreen
    case playing
    case gameOver
}

typealias Instruction = (icon: String, title: String, description: String)

struct MainScreenProperties {
    static let gameTitle: String = "Game Title"
    static let gameInstructions: [Instruction] = [
        (icon: "hand.raised", title: "Kill enemies", description: "Kill all the enemies."),
        (icon: "hand.tap", title: "Tap to kill", description: "Tap the enemies to kill them."),
        (icon: "hand.draw", title: "Swipe to win", description: "If you swipe you win."),
        (icon: "hands.sparkles", title: "Make points", description: "More points the better!")
    ]
    
    static let accentColor: Color = Color.accentColor
}

struct GameScreenProperties {
    // ...
}

struct GameOverScreenProperties {
    // ...
}
