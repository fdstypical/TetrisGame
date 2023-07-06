//
//  TetrisGameViewModel.swift
//  TetrisGame
//
//  Created by Andrey Shulmin on 04.07.2023.
//

import SwiftUI
import Combine

class GameViewModel : ObservableObject {
    @Published var gameModel = GameModel()
    
    var subscription: AnyCancellable?
    var lastMoveLocation: CGPoint?
    
    var rows: Int { gameModel.rows }
    var columns: Int { gameModel.columns }
    var score: Int { gameModel.score }
    var isGameOver: Bool { gameModel.isGameOver }
    var isPlaying: Bool { gameModel.isPlaying }
    
    var board: [[GameSquare]] {
        var board = gameModel.board.map{ $0.map(convertToSquare) }
        
        if let shadow = gameModel.shadow {
            for blockLocation in shadow.blocks {
                board[blockLocation.row + shadow.origin.row][blockLocation.column + shadow.origin.column] = GameSquare(color: getShadowColor(type: shadow.type))
            }
        }
        
        if let tetromino = gameModel.tetromino {
            for blockLocation in tetromino.blocks {
                board[blockLocation.row + tetromino.origin.row][blockLocation.column + tetromino.origin.column] = GameSquare(color: getColor(type: tetromino.type))
            }
        }
        
        return board
    }
    
    init() {
        subscription = gameModel.objectWillChange.sink {
            self.objectWillChange.send()
        }
    }
    
    func convertToSquare(block: GameBlock?) -> GameSquare {
        return GameSquare(color: getColor(type: block?.type))
    }
    
    func getColor(type: BlockType?) -> Color {
        switch type {
        case .I:
            return .blue
        case .J:
            return .violet
        case .L:
            return .cyan
        case .O:
            return .green
        case .S:
            return .red
        case .T:
            return .violet
        case .Z:
            return .red
        case .none:
            return .stone
        }
    }
    
    func getShadowColor(type: BlockType?) -> Color {
        switch type {
        case .I:
            return .blueShadow
        case .J:
            return .violetShadow
        case .L:
            return .cyanShadow
        case .O:
            return .greenShadow
        case .S:
            return .redShadow
        case .T:
            return .violetShadow
        case .Z:
            return .redShadow
        case .none:
            return .stone
        }
    }
    
    func getRotateGusture() -> some Gesture {
        return TapGesture().onEnded({
            if self.isPlaying { self.gameModel.rotateTetromino(clockwise: true) }
        })
    }
    
    func getMoveGesture() -> some Gesture {
        return DragGesture()
            .onChanged(onMoveChange(value:))
            .onEnded(onMoveEnded(_:))
    }
    
    func onMoveChange(value: DragGesture.Value) {
        if !self.isPlaying { return }
        
        guard let start = lastMoveLocation else {
            lastMoveLocation = value.location
            return
        }
        
        let xDiff = value.location.x - start.x
        
        if xDiff > 10 {
            let _ = gameModel.moveTetrominoRight()
            lastMoveLocation = value.location
            return
        }
        
        if xDiff < -10 {
            let _ = gameModel.moveTetrominoLeft()
            lastMoveLocation = value.location
            return
        }
        
        let yDiff = value.location.y - start.y
        
        if yDiff > 10 {
            let _ = gameModel.moveTetrominoDown()
            lastMoveLocation = value.location
            return
        }
        
        if yDiff < -10 {
            gameModel.dropTetromiono()
            lastMoveLocation = value.location
            return
        }
    }
    
    func onMoveEnded(_: DragGesture.Value) {
        lastMoveLocation = nil
    }
    
    func togglePlayPause() {
        gameModel.togglePlayPause()
    }
    
    func restartGame() {
        gameModel.restartGame()
    }
}
