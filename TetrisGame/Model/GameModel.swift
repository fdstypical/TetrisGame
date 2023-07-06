//
//  TetrisGameModel.swift
//  TetrisGame
//
//  Created by Andrey Shulmin on 04.07.2023.
//

import SwiftUI

class GameModel : ObservableObject {
    let rows: Int
    let columns: Int
    
    var timer: Timer?
    var speed: Double
    
    @Published var score: Int = 0
    @Published var isGameOver: Bool = false
    
    @Published var board: [[GameBlock?]]
    @Published var tetromino: Tetromino?
    
    var isPlaying: Bool {
        guard let isPlaying = timer?.isValid else {
            return false
        }
        
        return isPlaying
    }
    
    var shadow: Tetromino? {
        guard var lastShadow = tetromino else { return nil }
        var testShadow = lastShadow
        
        while(isValidTetromino(tetromino: testShadow)) {
            lastShadow = testShadow
            testShadow = lastShadow.moveBy(row: -1, column: 0)
        }
        
        return lastShadow
    }
    
    
    init(rows: Int = 25, columns: Int = 14) {
        self.rows = rows
        self.columns = columns
        self.speed = 0.4
        
        board = Array(repeating: Array(repeating: nil, count: columns), count: rows)
        resumeGame()
    }
    
    func resumeGame() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: speed, repeats: true, block: runEngine)
    }
    
    func endGame() {
        timer?.invalidate()
        self.isGameOver = true
    }
    
    func togglePlayPause() {
        if isPlaying {
            timer?.invalidate()
        } else {
            timer = Timer.scheduledTimer(withTimeInterval: speed, repeats: true, block: runEngine)
        }
    }
    
    func restartGame() {
        timer?.invalidate()
        
        score = 0
        board = Array(repeating: Array(repeating: nil, count: columns), count: rows)
        tetromino = nil
        isGameOver = false
        
        resumeGame()
    }
    
    func runEngine(timer: Timer) {
        if (clearLine()) { return }
        
        guard tetromino != nil else {
            tetromino = Tetromino.createTetromino(rows: rows, columns: columns)
            
            if !isValidTetromino(tetromino: tetromino!) {
                endGame()
            }
            
            return
        }
        
        if moveTetrominoDown() {
            return
        }
        
        placeTetromino()
    }
    
    func moveTetromino(rowOffset: Int, columnOffset: Int) -> Bool {
        guard let currentTetromino = tetromino else { return false }
        
        let newTetromino = currentTetromino.moveBy(row: rowOffset, column: columnOffset)
        
        if isValidTetromino(tetromino: newTetromino) {
            tetromino = newTetromino
            return true
        }
        
        return false
    }
    
    func moveTetrominoDown() -> Bool {
        return moveTetromino(rowOffset: -1, columnOffset: 0)
    }
    
    func moveTetrominoRight() -> Bool {
        return moveTetromino(rowOffset: 0, columnOffset: 1)
    }
    
    func moveTetrominoLeft() -> Bool {
        return moveTetromino(rowOffset: 0, columnOffset: -1)
    }
    
    func dropTetromiono() {
        while (moveTetrominoDown()) { }
    }
    
    func rotateTetromino(clockwise: Bool) {
        guard let currentTetromino = tetromino else { return }
        
        let newTetrominoBase = currentTetromino.rotate(clockwise: clockwise)
        let kicks = currentTetromino.getKicks(clockwise: clockwise)
        
        for kick in kicks {
            let newTetromino = newTetrominoBase.moveBy(row: kick.row, column: kick.column)
            
            if isValidTetromino(tetromino: newTetromino) {
                tetromino = newTetromino
                return
            }
        }
    }
    
    func isValidTetromino(tetromino: Tetromino) -> Bool {
        for block in tetromino.blocks {
            let row = tetromino.origin.row + block.row
            if row < 0 || row >= rows { return false }
            
            let column = tetromino.origin.column + block.column
            if column < 0 || column >= columns {return false }
            
            if board[row][column] != nil { return false }
        }
        
        return true
    }
    
    func placeTetromino() {
        guard let currentTetromino = tetromino else {
            return
        }
        
        for block in currentTetromino.blocks {
            let row = currentTetromino.origin.row + block.row
            if row < 0 || row >= rows { continue }
            
            let column = currentTetromino.origin.column + block.column
            if column < 0 || column >= columns { continue }
            
            board[row][column] = GameBlock(type: currentTetromino.type)
        }
        
        tetromino = nil
    }
    
    func clearLine() -> Bool {
        var newBoard: [[GameBlock?]] = Array(repeating: Array(repeating: nil, count: columns), count: rows)
        var boardUpdated = false
        var nextRowToCopy = 0
        var countOfClearedLines = 0
        
        for row in 0...rows - 1 {
            var clearLine = true
            
            for column in 0...columns - 1 {
                clearLine = clearLine && board[row][column] != nil
            }
            
            if !clearLine {
                for column in 0...columns - 1 {
                    newBoard[nextRowToCopy][column] = board[row][column]
                }
                
                nextRowToCopy += 1
            } else {
                countOfClearedLines += 1
            }
            
            boardUpdated = boardUpdated || clearLine
        }
        
        if boardUpdated {
            board = newBoard
            score += rows - nextRowToCopy
        }
        
        return boardUpdated
    }
}
