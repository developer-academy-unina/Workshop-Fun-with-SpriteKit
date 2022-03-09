//
//  ContentView.swift
//  ArcadeGameTemplate
//
//  Created by Tiago Pereira on 07/03/22.
//

import SwiftUI

struct ContentView: View {
    
    // TODO: Add comment here
    @State var currentGameState: GameState = .mainScreen
    
    // TODO: Add comment here
    @StateObject var gameLogic: ArcadeGameLogic = ArcadeGameLogic()
    
    var body: some View {
        
        switch currentGameState {
        case .mainScreen:
            MainScreenView(currentGameState: $currentGameState)
                .environmentObject(gameLogic)
        
        case .playing:
            ArcadeGameView(currentGameState: $currentGameState)
                .environmentObject(gameLogic)
        
        case .gameOver:
            GameOverView(currentGameState: $currentGameState)
                .environmentObject(gameLogic)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
