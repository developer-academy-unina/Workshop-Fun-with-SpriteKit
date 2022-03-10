//
//  GameView.swift
//  ArcadeGameTemplate
//

import SwiftUI
import SpriteKit

/**
 * # ArcadeGameView
 *   This view is responsible for presenting the game and the game UI.
 *  In here you can add and customize:
 *  - UI elements
 *  - Different effects for transitions in and out of the game scene
 **/

struct ArcadeGameView: View {
    
    /**
     * # The Game Logic
     *     The game logic keeps track of the game variables
     *   you can use it to display information on the SwiftUI view,
     *   for example, and comunicate with the Game Scene.
     **/
    @StateObject var gameLogic: ArcadeGameLogic =  ArcadeGameLogic.shared
    
    // The game state is used to transition between the different states of the game
    @Binding var currentGameState: GameState
    
    private var screenWidth: CGFloat { UIScreen.main.bounds.size.width }
    private var screenHeight: CGFloat { UIScreen.main.bounds.size.height }
    
    /**
     * # The Game Scene
     *   If you need to do any configurations on your game scene, like changing it's size
     *   for example, do it here.
     **/
    var arcadeGameScene: ArcadeGameScene {
        let scene = ArcadeGameScene()
        
        scene.size = CGSize(width: screenWidth, height: screenHeight)
        scene.scaleMode = .fill
        
        return scene
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            // View that presents the game scene
            SpriteView(scene: self.arcadeGameScene)
                .frame(width: screenWidth, height: screenHeight)
                .statusBar(hidden: true)
            
            HStack() {
                // Shows the duration of the game session
                GameDurationView(time: $gameLogic.sessionDuration)
                Spacer()
                // Presents the score of the player
                GameScoreView(score: $gameLogic.currentScore)
            }
            .padding()
            .padding(.top, 24)
        }
        .onChange(of: gameLogic.isGameOver) { _ in
            if gameLogic.isGameOver {
                
                //TIP: You can add other types of animations here before presenting the game over screen.
                
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
