//
//  Constants.swift
//  ArcadeGameTemplate
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
        (icon: "hand.raised", title: "Instruction 1", description: "Instruction description."),
        (icon: "hand.tap", title: "Instruction 2", description: "Instruction description."),
        (icon: "hand.draw", title: "Instruction 3", description: "Instruction description."),
        (icon: "hand.tap", title: "Instruction 4", description: "Instruction description."),
        (icon: "hand.raise", title: "Instruction 5", description: "Instruction description."),
        (icon: "hands.sparkles", title: "Instruction 6", description: "Instruction description."),
    ]
    
    static let accentColor: Color = Color.accentColor
}
