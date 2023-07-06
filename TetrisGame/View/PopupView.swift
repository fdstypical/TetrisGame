//
//  PopupView.swift
//  TetrisGame
//
//  Created by Andrey Shulmin on 06.07.2023.
//

import SwiftUI

struct PopupView: View {
    var title: String
    var message: String
    var buttonText: String
    
    var onAction: () -> Void
    
    @Binding var show: Bool
    
    var body: some View {
        ZStack {
            if show {
                Color.black.opacity(show ? 0.3 : 0).edgesIgnoringSafeArea(.all)

                VStack(alignment: .center, spacing: 0) {
                    Text(title)
                        .frame(maxWidth: .infinity)
                        .frame(height: 45, alignment: .center)
                        .font(Font.system(size: 23, weight: .bold))
                        .foregroundColor(Color.white)
                        .background(Color(red: 0.62, green: 0.11, blue: 0.25))
                    
                    Text(message)
                        .multilineTextAlignment(.center)
                        .font(Font.system(size: 16, weight: .semibold))
                        .padding(EdgeInsets(top: 20, leading: 25, bottom: 20, trailing: 25))
                        .foregroundColor(Color.white)
                    
                    Button(action: {
                        withAnimation(.linear(duration: 0.3)) {
                            show = false
                            onAction()
                        }
                    }, label: {
                        Text(buttonText)
                            .frame(maxWidth: .infinity)
                            .frame(height: 54, alignment: .center)
                            .foregroundColor(Color.white)
                            .background(Color(red: 0.62, green: 0.11, blue: 0.25))
                            .font(Font.system(size: 23, weight: .semibold))
                    })
                    .buttonStyle(PlainButtonStyle())
                }
                .frame(maxWidth: 300)
                .background(Color.redShadow)
                .cornerRadius(20)
            }
        }
    }
}
