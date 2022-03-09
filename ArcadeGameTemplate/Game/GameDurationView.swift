//
//  GameDurationView.swift
//  ArcadeGameTemplate
//
//  Created by Tiago Pereira on 08/03/22.
//

import SwiftUI

struct GameDurationView: View {
    @Binding var time: TimeInterval
    
    var body: some View {
        HStack {
            Image(systemName: "clock")
                .font(.headline)
            Spacer()
            Text("\(Int(time))")
                .font(.headline)
        }
        .frame(minWidth: 100)
        .padding(24)
        .foregroundColor(.black)
        .background(Color(UIColor.systemGray6))
        .cornerRadius(10)
    }
}

struct GameDurationView_Previews: PreviewProvider {
    static var previews: some View {
        GameDurationView(time: .constant(1000))
            .previewLayout(.fixed(width: 300, height: 100))
    }
}
