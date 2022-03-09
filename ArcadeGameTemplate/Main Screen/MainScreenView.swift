//
//  MainScreen.swift
//  ArcadeGameTemplate
//
//  Created by Tiago Pereira on 07/03/22.
//

import SwiftUI

struct MainScreenView: View {
    
    @Binding var currentGameState: GameState
    
    // TODO: Add comment here
    var gameTitle: String = MainScreenProperties.gameTitle
    
    // TODO: Add comment here
    var gameInstructions: [Instruction] = MainScreenProperties.gameInstructions
    
    // TODO: Add comment here
    let accentColor: Color = MainScreenProperties.accentColor
    
    var body: some View {
        VStack(alignment: .center, spacing: 16.0) {
            
            Text("\(self.gameTitle)")
                .font(.title)
                .fontWeight(.black)
            
            Spacer()
            
            ForEach(self.gameInstructions, id: \.title) { instruction in
                GroupBox(label: Label("\(instruction.title)", systemImage: "\(instruction.icon)").foregroundColor(self.accentColor)) {
                    HStack {
                        Text("\(instruction.description)")
                            .font(.callout)
                        Spacer()
                    }
                }
            }
            
            Spacer()
            
            Button {
                withAnimation {
                    self.startGame()
                }
            } label: {
                Text("Insert a coin")
                    .padding()
                    .frame(maxWidth: .infinity)
            }
            .foregroundColor(.white)
            .background(self.accentColor)
            .cornerRadius(10.0)
            
        }
        .padding()
    }
    
    private func startGame() {
        print("- 👾 Starting the game...")
        self.currentGameState = .playing
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView(currentGameState: .constant(GameState.mainScreen))
    }
}
