//
//  Constants.swift
//  ArcadeGameTemplate
//

import Foundation
import SwiftUI

/**
 * # Constants
 *
 * This file gathers contant values that are shared all around the project.
 * Modifying the values of these constants will reflect along the complete interface of the application.
 *
 **/


/**
 * # GameState
 * Defines the different states of the game.
 * Used for supporting the navigation in the project template.
 */

enum GameState {
    case mainScreen
    case playing
    case gameOver
}

typealias Instruction = (icon: String, title: String, description: String)

/**
 * # MainScreenProperties
 *
 * Keeps the information that shows up on the main screen of the game.
 *
 */

struct MainScreenProperties {
    static let gameTitle: String = "EARTH DEFENDER"
    
    static let gameInstructions: [Instruction] = [
        (icon: "hand.tap", title: "Tap to Move", description: "Tap on the left and right of the screen to activate the space ship engines."),
        (icon: "divide.circle", title: "Destroy Asteroids", description: "Destroy asteroids by colliding with them."),
        (icon: "multiply.circle", title: "Don't let them pass!", description: "If three asteroids pass you lose!")
    ]
    
    static let accentColor: Color = Color.accentColor
}
