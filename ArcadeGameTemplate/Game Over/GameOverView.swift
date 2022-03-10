//
//  GameOverView.swift
//  ArcadeGameTemplate
//

import SwiftUI

/**
 * # GameOverView
 *   This view is responsible for...
 **/

struct GameOverView: View {
    @Binding var currentGameState: GameState
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            VStack(alignment: .center) {
                Spacer()
                
                Button {
                    withAnimation { self.backToMainScreen() }
                } label: {
                    Image(systemName: "arrow.backward")
                        .foregroundColor(.black)
                        .font(.title)
                }
                .background(Circle().foregroundColor(Color(uiColor: UIColor.systemGray6)).frame(width: 100, height: 100, alignment: .center))
                .shadow(radius: 10)
                
                Spacer()
                
                Button {
                    withAnimation { self.restartGame() }
                } label: {
                    Image(systemName: "arrow.clockwise")
                        .foregroundColor(.black)
                        .font(.title)
                }
                .background(Circle().foregroundColor(Color(uiColor: UIColor.systemGray6)).frame(width: 100, height: 100, alignment: .center))
                .shadow(radius: 10)
                
                Spacer()
            }
        }
        .statusBar(hidden: true)
    }
    
    private func backToMainScreen() {
        self.currentGameState = .mainScreen
    }
    
    private func restartGame() {
        self.currentGameState = .playing
    }
}

struct GameOverView_Previews: PreviewProvider {
    static var previews: some View {
        GameOverView(currentGameState: .constant(GameState.gameOver))
    }
}
