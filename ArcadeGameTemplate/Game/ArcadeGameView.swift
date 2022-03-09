//
//  GameView.swift
//  ArcadeGameTemplate
//
//  Created by Tiago Pereira on 07/03/22.
//

import SwiftUI
import SpriteKit

struct ArcadeGameView: View {
    // TODO: Add comment here
    @StateObject var gameLogic: ArcadeGameLogic =  ArcadeGameLogic.shared
    
    // TODO: Add comment here
    @Binding var currentGameState: GameState
    
    // TODO: Add comment here
    private var screenWidth: CGFloat { UIScreen.main.bounds.size.width }
    private var screenHeight: CGFloat { UIScreen.main.bounds.size.height }
    
    // TODO: Add comment here
    var arcadeGameScene: ArcadeGameScene {
        let scene = ArcadeGameScene()
        
        scene.size = CGSize(width: screenWidth, height: screenHeight)
        scene.scaleMode = .fill
        
        return scene
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            // TODO: Add comment here
            SpriteView(scene: self.arcadeGameScene)
                .frame(width: screenWidth, height: screenHeight)
                .statusBar(hidden: true)
            
            HStack() {
                // TODO: Add comment here
                GameDurationView(time: $gameLogic.sessionDuration)
                Spacer()
                // TODO: Add comment here
                GameScoreView(score: $gameLogic.currentScore)
            }
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
    
    // TODO: Add comment here
    private func presentMainScreen() {
        self.currentGameState = .mainScreen
    }
    
    // TODO: Add comment here
    private func presentGameOverScreen() {
        self.currentGameState = .gameOver
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        ArcadeGameView(currentGameState: .constant(GameState.playing))
    }
}
