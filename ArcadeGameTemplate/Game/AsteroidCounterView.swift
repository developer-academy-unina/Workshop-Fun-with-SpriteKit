//
//  AsteroidCounterView.swift
//  ArcadeGameTemplate
//
//  Created by Tiago Pereira for the Developer Academy on 22/03/22.
//
//


import SwiftUI

struct AsteroidCounterView: View {
    
    @Binding var numberOfMissedAsteroids: Int
    
    let maxAsteroids: Int = 3
    
    var body: some View {
        HStack {
            ForEach(0..<maxAsteroids, id: \.self) { index in
                if index < numberOfMissedAsteroids {
                    Image(systemName: "circle.fill")
                } else {
                    Image(systemName: "circle")
                }
            }
        }
        .frame(minWidth: 100)
        .padding(24)
        .background(Color(UIColor.systemGray6))
        .cornerRadius(10)
    }
}

struct AsteroidCounterView_Previews: PreviewProvider {
    static var previews: some View {        
        Group{
            AsteroidCounterView(numberOfMissedAsteroids: .constant(2))
                .preferredColorScheme(.light)
                .previewLayout(.fixed(width: 300, height: 100))
            AsteroidCounterView(numberOfMissedAsteroids: .constant(2))
                .preferredColorScheme(.dark)
                .previewLayout(.fixed(width: 300, height: 100))
        }
    }
}
