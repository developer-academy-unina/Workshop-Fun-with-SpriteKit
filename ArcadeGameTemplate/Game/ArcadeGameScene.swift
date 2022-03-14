//
//  ArcadeGameScene.swift
//  ArcadeGameTemplate
//

import SpriteKit
import SwiftUI

struct PhysicsCategory {
    static let none     : UInt32 = 0
    static let all      : UInt32 = UInt32.max
    static let player   : UInt32 = 0b1
    static let asteroid : UInt32 = 0b10
    static let smallAsteroid : UInt32 = 0b100
}

class ArcadeGameScene: SKScene {
    
    var gameLogic: ArcadeGameLogic = ArcadeGameLogic.shared
    
    var lastUpdate: TimeInterval = 0
    
    var player: SKShapeNode!
    
    var isMovingToTheRight: Bool = false
    var isMovingToTheLeft: Bool = false
    
    var isStabilizingPlayerPosition = false
    
    override func didMove(to view: SKView) {
        self.setUpGame()
        self.setUpPhysicsWorld()
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        if self.isGameOver { self.finishGame() }
        
        if self.lastUpdate == 0 { self.lastUpdate = currentTime }
        
        let timeElapsedSinceLastUpdate = currentTime - self.lastUpdate
        self.gameLogic.increaseSessionTime(by: timeElapsedSinceLastUpdate)
        
        self.lastUpdate = currentTime
        
        if isMovingToTheRight && (player.position.x > 0) {
            self.moveRight()
        }
        
        if isMovingToTheLeft && (player.position.x < frame.width) {
            self.moveLeft()
        }
        
        if (player.position.x <= 0) || (player.position.x >= frame.width) {
            self.resetPlayerVelocity()
        }
    }
    
}

// MARK: - Game Scene Set Up
extension ArcadeGameScene {
    
    private func setUpGame() {
        self.gameLogic.setUpGame()
        self.backgroundColor = SKColor.white
        
        self.createPlayer(at: CGPoint(x: self.frame.width/2, y: self.frame.height/6))
        
        self.startAsteroidsCycle()
    }
    
    private func setUpPhysicsWorld() {
        physicsWorld.gravity = CGVector(dx: 0, dy: -0.9)
        
        physicsWorld.contactDelegate = self
    }
    
    private func restartGame() {
        self.gameLogic.restartGame()
    }
    
    private func createPlayer(at position: CGPoint) {
        self.player = SKShapeNode(circleOfRadius: 10.0)
        self.player.name = "player"
        self.player.fillColor = SKColor.blue
        self.player.strokeColor = SKColor.black
        
        self.player.position = position
        
        player.physicsBody = SKPhysicsBody(circleOfRadius: 10.0)
        player.physicsBody?.affectedByGravity = false
        
        player.physicsBody?.categoryBitMask = PhysicsCategory.player
        player.physicsBody?.contactTestBitMask = PhysicsCategory.asteroid
        player.physicsBody?.collisionBitMask = PhysicsCategory.asteroid
        
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
            self.isMovingToTheRight = true
        case .left:
            self.isMovingToTheLeft = true
        }
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
    
    private func resetPlayerVelocity() {
        player.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        print("Player velocity reseted: \(player.physicsBody!.velocity)")
    }
    
    private func stabilizePlayerPosition() {
        print("- Stabilizing the player position")
        let positionY = self.frame.height / 6
        
        let moveAction = SKAction.moveTo(y: positionY, duration: 2.0)
        let finishStabilizing = SKAction.run { self.isStabilizingPlayerPosition = false }
        
        player.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        player.run(SKAction.sequence([moveAction, finishStabilizing]))
    }
}


// MARK: - Game Over Condition
extension ArcadeGameScene {
    var isGameOver: Bool {
        return gameLogic.numberOfMissedAsteroids >= 3
    }
    
    private func finishGame() {
        gameLogic.isGameOver = true
    }
    
}

// MARK: - Register Score
extension ArcadeGameScene {
    private func scorePoint() {
        self.gameLogic.score(points: 1)
        
        if gameLogic.shouldIncreaseDifficulty {
            gameLogic.increaseDifficulty()
            
            self.startAsteroidsCycle()
        }
    }
    
    private func registerScore() {
        // TODO: Customize!
    }
    
}

// MARK: - Asteroids
extension ArcadeGameScene {
    
    private func newAsteroid(at position: CGPoint) {
        let newAsteroid = SKShapeNode(circleOfRadius: 15.0)
        newAsteroid.name = "asteroid"
        newAsteroid.fillColor = SKColor.red
        newAsteroid.strokeColor = SKColor.black
        
        newAsteroid.position = position
        
        newAsteroid.physicsBody = SKPhysicsBody(circleOfRadius: 15.0)
        
        newAsteroid.physicsBody?.categoryBitMask = PhysicsCategory.asteroid
        newAsteroid.physicsBody?.contactTestBitMask = PhysicsCategory.player
        newAsteroid.physicsBody?.collisionBitMask = PhysicsCategory.player
        
        addChild(newAsteroid)
        
        newAsteroid.run(SKAction.sequence([
            SKAction.wait(forDuration: 4.0),
            SKAction.run { self.gameLogic.addMissedAsteroid() },
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
        let waitAction = SKAction.wait(forDuration: gameLogic.asteroidsSpawnRate)
        
        let createAndWaitAction = SKAction.sequence([createAsteroidAction, waitAction])
        let asteroidCycleAction = SKAction.repeatForever(createAndWaitAction)
        
        run(asteroidCycleAction, withKey: "asternoidCycle")
    }
    
    private func newSmallAsteroid(at position: CGPoint) -> SKShapeNode {
        let smallAsteroid = SKShapeNode(circleOfRadius: 5.0)
        smallAsteroid.fillColor = SKColor.red
        smallAsteroid.strokeColor = SKColor.red
        
        smallAsteroid.position = position
        
        smallAsteroid.physicsBody = SKPhysicsBody(circleOfRadius: 5.0)
        smallAsteroid.physicsBody?.affectedByGravity = true
        
        smallAsteroid.physicsBody?.categoryBitMask = PhysicsCategory.smallAsteroid
        smallAsteroid.physicsBody?.contactTestBitMask = PhysicsCategory.none
        smallAsteroid.physicsBody?.collisionBitMask = PhysicsCategory.none
        
        return smallAsteroid
    }
    
    private func destroy(asteroid: SKShapeNode) {
        let bigAsteroidPosition = asteroid.position
        
        var smallAsteroids = [SKShapeNode]()
        
        for _ in 1...8 {
            let smallAsteroid = self.newSmallAsteroid(at: bigAsteroidPosition)
            smallAsteroids.append(smallAsteroid)
        }
        
        asteroid.removeFromParent()
        
        for (index, asteroid) in smallAsteroids.enumerated() {
            addChild(asteroid)
            let randomDX = CGFloat.random(in: 0...1) * CGFloat.pi * CGFloat(index % 2 == 0 ? 1 : -1)
            let randomDY = CGFloat.random(in: 0...1) * CGFloat.pi * CGFloat(index % 2 == 0 ? 1 : -1)
            asteroid.physicsBody?.applyImpulse(CGVector(dx: randomDX, dy: randomDY))
            asteroid.run(SKAction.sequence([
                SKAction.wait(forDuration: 1.0),
                SKAction.removeFromParent()
            ]))
        }
    }
    
}

// MARK: - Contacts and Collisions
extension ArcadeGameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        // 6.
        let firstBody: SKPhysicsBody = contact.bodyA
        let secondBody: SKPhysicsBody = contact.bodyB
        
        if let node = firstBody.node as? SKShapeNode, node.name == "asteroid" {
            self.destroy(asteroid: node)
            self.scorePoint()
            
            run(SKAction.sequence([
                SKAction.wait(forDuration: 0.6),
                SKAction.run { self.stabilizePlayerPosition() }
            ]))
        }
        
        if let node = secondBody.node as? SKShapeNode, node.name == "asteroid" {
            self.destroy(asteroid: node)
            self.scorePoint()
            
            run(SKAction.sequence([
                SKAction.wait(forDuration: 0.6),
                SKAction.run { self.stabilizePlayerPosition() }
            ]))
        }
    }
    
}
