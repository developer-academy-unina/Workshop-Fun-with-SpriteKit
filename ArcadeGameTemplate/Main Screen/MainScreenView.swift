//
//  MainScreen.swift
//  ArcadeGameTemplate
//

import SwiftUI

/**
 * # MainScreenView
 *
 *   This view is responsible for presenting the game name, the game intructions and to start the game.
 *  - Customize it as much as you want.
 *  - Experiment with colors and effects on the interface
 *  - Adapt the "Insert a Coin Button" to the visual identity of your game
 **/

struct MainScreenView: View {
    
    // The game state is used to transition between the different states of the game
    @Binding var currentGameState: GameState
    
    // Change it on the Constants.swift file
    var gameTitle: String = MainScreenProperties.gameTitle
    
    // Change it on the Constants.swift file
    var gameInstructions: [Instruction] = MainScreenProperties.gameInstructions
    
    // Change it on the Constants.swift file
    let accentColor: Color = MainScreenProperties.accentColor
    
    var body: some View {
        VStack(alignment: .center, spacing: 16.0) {
            Spacer()
            
            /** **TIP:** The game title can be customized to represent the visual identity of the game **/
            Text("\(self.gameTitle)")
                .font(.title)
                .fontWeight(.black)
            
            Spacer()
            
            /** To customize the instructions, change it on the **Constants.swift** file **/
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
            
            /** Customize the appearance of the **Insert a Coin** button to match the visual identity of your game **/
            Button {
                withAnimation { self.startGame() }
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
        .statusBar(hidden: true)
    }
    
    private func startGame() {
        print("- Starting the game...")
        self.currentGameState = .playing
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView(currentGameState: .constant(GameState.mainScreen))
    }
}
