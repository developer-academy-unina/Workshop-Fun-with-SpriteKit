//
//  ArcadeGameScene.swift
//  ArcadeGameTemplate
//
//  Created by Tiago Pereira on 07/03/22.
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
        
        // TODO: Add comment here
        if self.lastUpdate == 0 {
            self.lastUpdate = currentTime
        }
        
        // TODO: Add comment here
        let timeElapsedSinceLastUpdate = currentTime - self.lastUpdate
        self.gameLogic.increaseSessionTime(by: timeElapsedSinceLastUpdate)
        self.lastUpdate = currentTime
    }
    
}

// MARK: - Game Scene set up
extension ArcadeGameScene {
    
    private func setUpGame() {
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
        
        self.finishGame()
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
    
    // TODO: Add comment here
    // time over, lives ended, enemies missed, screen is full...
    var isGameOver: Bool {
        return false
    }
    
    private func finishGame() {
        gameLogic.isGameOver = true
    }
    
}

// MARK: - Register Score
extension ArcadeGameScene {
    // TODO: Add comment here
    private func registerScore() {
        
        // ...
        
    }
    
}
