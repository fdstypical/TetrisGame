//
//  FooterView.swift
//  TetrisGame
//
//  Created by Andrey Shulmin on 06.07.2023.
//

import SwiftUI

struct FooterView : View {
    var score: Int
    
    var onRestart: () -> Void
    var onTogglePause: () -> Void
    
    var body: some View {
        HStack {
            Button(action: onRestart, label: {
                Text("Restart")
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
            })
            .background(Color.violetShadow)
            .foregroundColor(Color.violet)
            .clipShape(Capsule())
            
            Button(action: onTogglePause, label: {
                Text("Pause / Play")
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
            })
            .background(Color.violetShadow)
            .foregroundColor(Color.violet)
            .clipShape(Capsule())
            
            Text("Your score is: \(score)")
                .foregroundColor(Color.violet)
        }
    }
}
