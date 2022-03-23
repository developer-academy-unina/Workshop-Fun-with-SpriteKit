//
//  GameScoreView.swift
//  ArcadeGameTemplate
//

import SwiftUI

/**
 * # GameScoreView
 * Custom UI to present how many points the player has scored.
 *
 * Customize it to match the visual identity of your game.
 */

struct GameScoreView: View {
    @Binding var score: Int
    
    var body: some View {
        
        HStack {
            Image(systemName: "target")
                .font(.headline)
            Spacer()
            Text("\(score)")
                .font(.headline)
        }
        .frame(minWidth: 100)
        .padding(24)
        .background(Color(UIColor.systemGray6))
        .cornerRadius(10)
    }
}

struct GameScoreView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GameScoreView(score: .constant(100))
                .preferredColorScheme(.light)
            .previewLayout(.fixed(width: 300, height: 100))
            
            GameScoreView(score: .constant(100))
                .preferredColorScheme(.dark)
                .previewLayout(.fixed(width: 300, height: 100))
        }
    }
}
