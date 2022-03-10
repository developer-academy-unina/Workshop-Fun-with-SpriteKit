//
//  ArcadeGameScene.swift
//  ArcadeGameTemplate
//

import SpriteKit
import SwiftUI

class ArcadeGameScene: SKScene {
    // TODO: Add comment
    var gameLogic: ArcadeGameLogic = ArcadeGameLogic.shared
    
    var lastUpdate: TimeInterval = 0
    
    override func didMove(to view: SKView) {
        self.setUpGame()
        self.setUpPhysicsWorld()
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        // ...
        
        // 1. If the game over condition is met, the game will finish
        if self.isGameOver {
            self.finishGame()
        }
        
        // 2. The first time, the
        if self.lastUpdate == 0 { self.lastUpdate = currentTime }
        
        // TODO: Add comment here
        let timeElapsedSinceLastUpdate = currentTime - self.lastUpdate
        self.gameLogic.increaseSessionTime(by: timeElapsedSinceLastUpdate)
        self.lastUpdate = currentTime
    }
    
}

// MARK: - Game Scene Set Up
extension ArcadeGameScene {
    
    private func setUpGame() {
        self.gameLogic.setUpGame()
        self.backgroundColor = SKColor.white
        
        // ...
    }
    
    private func setUpPhysicsWorld() {
        // ...
    }
    
    private func restartGame() {
        self.gameLogic.restartGame()
    }
}


// MARK: - Handle Player Inputs
extension ArcadeGameScene {
    
    //TODO: Add comment here
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("-- Scoring a point!")
        self.gameLogic.score(points: 1)
        self.gameLogic.finishTheGame()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        // ...
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // ...
    }
    
}


// MARK: - Game Over Condition
extension ArcadeGameScene {
    
    /**
     * Implement the Game Over condition.
     * Remember that an arcade game always ends! How will the player eventually lose?
     *
     * Some examples of game over conditions are:
     * - The time is over!
     * - The player health is depleated!
     * - The enemies have completed their goal!
     * - The screen is full!
     **/
    
    var isGameOver: Bool {
        return gameLogic.isGameOver
    }
    
    private func finishGame() {
        gameLogic.isGameOver = true
    }
    
}

// MARK: - Register Score
extension ArcadeGameScene {
    private func registerScore() {
        // TODO: Implement a way to register the score of the player after the game is over
    }
}
