//
//  GameLogic.swift
//  ArcadeGameTemplate
//

import Foundation

class ArcadeGameLogic: ObservableObject {
    
    static let shared: ArcadeGameLogic = ArcadeGameLogic()
    
    func setUpGame() {
        self.currentScore = 0
        self.sessionDuration = 0
        self.numberOfMissedAsteroids = 0
        
        self.isGameOver = false
    }
    
    @Published var currentScore: Int = 0
    
    func score(points: Int) {
        self.currentScore = self.currentScore + points
    }
    
    @Published var sessionDuration: TimeInterval = 0
    
    func increaseSessionTime(by timeIncrement: TimeInterval) {
        self.sessionDuration = self.sessionDuration + timeIncrement
    }
    
    func restartGame() {
        self.setUpGame()
    }
    
    @Published var isGameOver: Bool = false
    
    func finishTheGame() {
        if self.isGameOver == false {
            self.isGameOver = true
        }
    }
    
    @Published var numberOfMissedAsteroids = 0
    
    func addMissedAsteroid() {
        self.numberOfMissedAsteroids += 1
    }
    
    var asteroidsSpawnRate: TimeInterval = 3.0
    
    var shouldIncreaseDifficulty: Bool {
        return (currentScore % 10 == 0)
    }
    
    func increaseDifficulty() {
        asteroidsSpawnRate = asteroidsSpawnRate - (asteroidsSpawnRate * 0.05)
    }
    
}
