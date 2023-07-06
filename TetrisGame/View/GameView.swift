//
//  TetrisGameView.swift
//  TetrisGame
//
//  Created by Andrey Shulmin on 04.07.2023.
//

import SwiftUI

struct GameView : View {
    @ObservedObject var game = GameViewModel()
    @State var showPopUp: Bool = false

    var body: some View {
        ZStack {
            VStack {
                GeometryReader { (geometry: GeometryProxy) in
                    self.draw(boundingRect: geometry.size)
                }
                .gesture(game.getMoveGesture())
                .gesture(game.getRotateGusture())
                
                FooterView(
                    score: game.score,
                    onRestart: game.gameModel.restartGame,
                    onTogglePause: game.gameModel.togglePlayPause
                )
                .padding(.top, 5)
                .padding(.bottom, 20)
            }
            
            PopupView(
                title: "Game Over",
                message: "Your score is: \(self.game.gameModel.score)",
                buttonText: "Restart",
                onAction: self.game.gameModel.restartGame,
                show: Binding(get: { game.isGameOver }, set: { show in showPopUp = false })
            )
        }
    }
     
    func draw(boundingRect: CGSize) -> some View {
        let columns = self.game.columns
        let rows = self.game.rows

        let blockSize = min(boundingRect.width / CGFloat(columns), boundingRect.height / CGFloat(rows))
        
        let xoffset = (boundingRect.width - blockSize * CGFloat(columns)) / 2
        let yoffset = (boundingRect.height - blockSize * CGFloat(rows)) / 2
        
        let board = self.game.board
        
        return ForEach(0...rows - 1, id:\.self) { (row: Int) in
            ForEach(0...columns - 1, id:\.self) { (column: Int) in
                Path { path in
                    let x = xoffset + blockSize * CGFloat(column)
                    let y = boundingRect.height - yoffset - blockSize * CGFloat(row + 1)
                    
                    let rect = CGRect(x: x, y: y, width: blockSize, height: blockSize)
                    path.addRect(rect)
                }
                .fill(board[row][column].color)
            }
        }
    }
}

struct GameView_previews : PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
