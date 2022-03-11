//
//  ArcadeGameScene.swift
//  ArcadeGameTemplate
//

import SpriteKit
import SwiftUI

class ArcadeGameScene: SKScene {
    /**
     * # The Game Logic
     *     The game logic keeps track of the game variables
     *   you can use it to display information on the SwiftUI view,
     *   for example, and comunicate with the Game Scene.
     **/
    var gameLogic: ArcadeGameLogic = ArcadeGameLogic.shared
    
    // Keeps track of when the last update happend.
    // Used to calculate how much time has passed between updates.
    var lastUpdate: TimeInterval = 0
    
    var player: SKShapeNode!
    
    var isMovingToTheRight: Bool = false
    var isMovingToTheLeft: Bool = false
    
    override func didMove(to view: SKView) {
        self.setUpGame()
        self.setUpPhysicsWorld()
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        // If the game over condition is met, the game will finish
        if self.isGameOver { self.finishGame() }
        
        // The first time the update function is called we must initialize the
        // lastUpdate variable
        if self.lastUpdate == 0 { self.lastUpdate = currentTime }
        
        // Calculates how much time has passed since the last update
        let timeElapsedSinceLastUpdate = currentTime - self.lastUpdate
        // Increments the length of the game session at the game logic
        self.gameLogic.increaseSessionTime(by: timeElapsedSinceLastUpdate)
        
        self.lastUpdate = currentTime
        
        
        if isMovingToTheRight {
            self.moveRight()
        }
        
        if isMovingToTheLeft {
            self.moveLeft()
        }
        
    }
    
}

// MARK: - Game Scene Set Up
extension ArcadeGameScene {
    
    private func setUpGame() {
        self.gameLogic.setUpGame()
        self.backgroundColor = SKColor.white
        
        // TODO: Customize!
        
        self.createPlayer(at: CGPoint(x: self.frame.width/2, y: self.frame.height/6))
        
        self.startAsteroidsCycle()
    }
    
    private func setUpPhysicsWorld() {
        physicsWorld.gravity = CGVector(dx: 0, dy: -0.9)
        
        // 5.
        physicsWorld.contactDelegate = self
    }
    
    private func restartGame() {
        self.gameLogic.restartGame()
    }
    
    private func createPlayer(at position: CGPoint) {
        self.player = SKShapeNode(circleOfRadius: 25.0)
        self.player.name = "player"
        self.player.fillColor = SKColor.blue
        self.player.strokeColor = SKColor.black
        
        self.player.position = position
        
        player.physicsBody = SKPhysicsBody(circleOfRadius: 25.0)
        player.physicsBody?.affectedByGravity = false
        
        // 2.
        player.physicsBody?.categoryBitMask = PhysicsCategory.player
        player.physicsBody?.contactTestBitMask = PhysicsCategory.asteroid
        player.physicsBody?.collisionBitMask = PhysicsCategory.asteroid
        
        // Set up the position constraints for the player
        let xRange = SKRange(lowerLimit: 0, upperLimit: frame.width)
        let xConstraint = SKConstraint.positionX(xRange)
        self.player.constraints = [xConstraint]
        
        addChild(self.player)
    }
}


// MARK: - Handle Player Inputs
extension ArcadeGameScene {
    
    enum SideOfTheScreen {
        case right, left
    }
    
    private func sideTouched(for position: CGPoint) -> SideOfTheScreen {
        if position.x < self.frame.width / 2 {
            return .left
        } else {
            return .right
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        
        switch sideTouched(for: touchLocation) {
        case .right:
            // print("➡️ Right side of the screen touched")
            self.isMovingToTheRight = true
        case .left:
            // print("⬅️ Left side of the screen touched")
            self.isMovingToTheLeft = true
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        // TODO: Customize!
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.isMovingToTheRight = false
        self.isMovingToTheLeft = false
    }
    
}

// MARK: - Player Movement
extension ArcadeGameScene {
    
    private func moveLeft() {
        self.player.physicsBody?.applyForce(CGVector(dx: 5, dy: 0))
        print("Moving Left: \(player.physicsBody!.velocity)")
    }
    
    private func moveRight() {
        self.player.physicsBody?.applyForce(CGVector(dx: -5, dy: 0))
        print("Moving Right: \(player.physicsBody!.velocity)")
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
        // TODO: Customize!
        
        // Did you reach the time limit?
        // Are the health points depleted?
        // Did an enemy cross a position it should not have crossed?
        
        return gameLogic.isGameOver
    }
    
    private func finishGame() {
        
        // TODO: Customize!
        
        gameLogic.isGameOver = true
    }
    
}

// MARK: - Register Score
extension ArcadeGameScene {
    
    private func registerScore() {
        // TODO: Customize!
    }
    
}

// MARK: - Asteroids
extension ArcadeGameScene {
    
    private func newAsteroid(at position: CGPoint) {
        let newAsteroid = SKShapeNode(circleOfRadius: 25.0)
        newAsteroid.name = "asteroid"
        newAsteroid.fillColor = SKColor.red
        newAsteroid.strokeColor = SKColor.black
        
        newAsteroid.position = position
        
        newAsteroid.physicsBody = SKPhysicsBody(circleOfRadius: 25.0)
        
        // 3.
        newAsteroid.physicsBody?.categoryBitMask = PhysicsCategory.asteroid
        newAsteroid.physicsBody?.contactTestBitMask = PhysicsCategory.player
        newAsteroid.physicsBody?.collisionBitMask = PhysicsCategory.player
        
        addChild(newAsteroid)
        
        newAsteroid.run(SKAction.sequence([
            SKAction.wait(forDuration: 5.0),
            SKAction.removeFromParent()
        ]))
    }
    
    private func randomAsteroidPosition() -> CGPoint {
        let initialX: CGFloat = 25
        let finalX: CGFloat = self.frame.width - 25
        let positionX = CGFloat.random(in: initialX...finalX)
        let positionY = frame.height - 25
        
        return CGPoint(x: positionX, y: positionY)
    }
    
    func createAsteroid() {
        let asteroidPosition = self.randomAsteroidPosition()
        newAsteroid(at: asteroidPosition)
    }
    
    func startAsteroidsCycle() {
        let createAsteroidAction = SKAction.run(createAsteroid)
        let waitAction = SKAction.wait(forDuration: 3.0)
        
        let createAndWaitAction = SKAction.sequence([createAsteroidAction, waitAction])
        let asteroidCycleAction = SKAction.repeatForever(createAndWaitAction)
        
        run(asteroidCycleAction)
    }
    
}

// 1.
struct PhysicsCategory {
    static let none     : UInt32 = 0
    static let all      : UInt32 = UInt32.max
    static let player   : UInt32 = 0b1
    static let asteroid : UInt32 = 0b10
}

// 4.
// MARK: - Contacts and Collisions
extension ArcadeGameScene: SKPhysicsContactDelegate {

    func didBegin(_ contact: SKPhysicsContact) {
        // 6.
        let firstBody: SKPhysicsBody = contact.bodyA
        let secondBody: SKPhysicsBody = contact.bodyB
        
        if let node = firstBody.node, node.name == "asteroid" {
            node.removeFromParent()
        }
        
        if let node = secondBody.node, node.name == "asteroid" {
            node.removeFromParent()
        }
    }
    
}
