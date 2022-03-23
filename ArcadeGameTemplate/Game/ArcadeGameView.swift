//
//  GameView.swift
//  ArcadeGameTemplate
//

import SwiftUI
import SpriteKit

struct ArcadeGameView: View {
    
    @StateObject var gameLogic: ArcadeGameLogic =  ArcadeGameLogic.shared

    @Binding var currentGameState: GameState
    
    private var screenWidth: CGFloat { UIScreen.main.bounds.size.width }
    private var screenHeight: CGFloat { UIScreen.main.bounds.size.height }
    
    var arcadeGameScene: ArcadeGameScene {
        let scene = ArcadeGameScene()
        
        scene.size = CGSize(width: screenWidth, height: screenHeight)
        scene.scaleMode = .fill
        
        return scene
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            
            SpriteView(scene: self.arcadeGameScene)
                .frame(width: screenWidth, height: screenHeight)
                .statusBar(hidden: true)
            
            HStack(alignment: .center) {
                GameScoreView(score: $gameLogic.currentScore)
                AsteroidCounterView(numberOfMissedAsteroids: $gameLogic.numberOfMissedAsteroids)
            }
            .frame(width: 200)
            .padding()
            .padding(.top, 24)
        }
        .onChange(of: gameLogic.isGameOver) { _ in
            if gameLogic.isGameOver {
                withAnimation {
                    self.presentGameOverScreen()
                }
            }
        }
        .onAppear {
            gameLogic.restartGame()
        }
    }
    
    private func presentMainScreen() {
        self.currentGameState = .mainScreen
    }
    
    private func presentGameOverScreen() {
        self.currentGameState = .gameOver
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        ArcadeGameView(currentGameState: .constant(GameState.playing))
    }
}
