//
//  GameOverView.swift
//  ArcadeGameTemplate
//
//  Created by Tiago Pereira on 07/03/22.
//

import SwiftUI

struct GameOverView: View {
    @Binding var currentGameState: GameState
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            VStack(alignment: .center) {
                Spacer()
                
                Button {
                    print("- Back to menu.!")
                    withAnimation {
                        self.backToMainScreen()
                    }
                } label: {
                    Image(systemName: "arrow.backward")
                        .foregroundColor(.black)
                        .font(.title)
                }
                .background(Circle().foregroundColor(Color(uiColor: UIColor.systemGray6)).frame(width: 100, height: 100, alignment: .center))
                .shadow(radius: 10)
                
                Spacer()
                
                Button {
                    print("- Restarting game.")
                    withAnimation {
                        self.restartGame()
                    }
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
    }
    
    private func restartGame() {
        self.currentGameState = .playing
    }
    
    private func backToMainScreen() {
        self.currentGameState = .mainScreen
    }
}

struct GameOverView_Previews: PreviewProvider {
    static var previews: some View {
        GameOverView(currentGameState: .constant(GameState.gameOver))
    }
}
