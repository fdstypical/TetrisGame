//
//  Tetromino.swift
//  TetrisGame
//
//  Created by Andrey Shulmin on 05.07.2023.
//

import SwiftUI

struct Tetromino {
    var origin: BlockLocation
    var type: BlockType
    var rotation: Int
    
    var blocks: [BlockLocation] {
        return Tetromino.getBlocks(type: type, rotation: rotation)
    }
    
    func moveBy(row: Int, column: Int) -> Tetromino {
        let newOrigin = BlockLocation(row: origin.row + row, column: origin.column + column)
        return Tetromino(origin: newOrigin, type: type, rotation: rotation)
    }
    
    func rotate(clockwise: Bool) -> Tetromino {
        return Tetromino(origin: origin, type: type, rotation: rotation + (clockwise ? 1 : -1))
    }
    
    func getKicks(clockwise: Bool) -> [BlockLocation] {
        return Tetromino.getKicks(type: type, rotation: rotation, clockwise: clockwise)
    }
    
    static func getBlocks(type: BlockType, rotation: Int = 0) -> [BlockLocation] {
        let allBlocks = getAllBlocks(type: type)
        var index = rotation % allBlocks.count
        
        if index < 0 { index += allBlocks.count}
        
        return allBlocks[index]
    }
    
    static func getAllBlocks(type: BlockType) -> [[BlockLocation]] {
            switch type {
            case .I:
                return [
                        [
                            BlockLocation(row: 0, column: -1),
                            BlockLocation(row: 0, column: 0),
                            BlockLocation(row: 0, column: 1),
                            BlockLocation(row: 0, column: 2)
                        ],
                        [
                            BlockLocation(row: -1, column: 1),
                            BlockLocation(row: 0, column: 1),
                            BlockLocation(row: 1, column: 1),
                            BlockLocation(row: -2, column: 1)
                        ],
                        [
                            BlockLocation(row: -1, column: -1),
                            BlockLocation(row: -1, column: 0),
                            BlockLocation(row: -1, column: 1),
                            BlockLocation(row: -1, column: 2)
                        ],
                        [
                            BlockLocation(row: -1, column: 0),
                            BlockLocation(row: 0, column: 0),
                            BlockLocation(row: 1, column: 0),
                            BlockLocation(row: -2, column: 0)
                        ]
                ]
            case .O:
                return [
                        [
                            BlockLocation(row: 0, column: 0),
                            BlockLocation(row: 0, column: 1),
                            BlockLocation(row: 1, column: 1),
                            BlockLocation(row: 1, column: 0)
                        ]
                ]
            case .T:
                return [
                        [
                            BlockLocation(row: 0, column: -1),
                            BlockLocation(row: 0, column: 0),
                            BlockLocation(row: 0, column: 1),
                            BlockLocation(row: 1, column: 0)
                        ],
                        [
                            BlockLocation(row: -1, column: 0),
                            BlockLocation(row: 0, column: 0),
                            BlockLocation(row: 0, column: 1),
                            BlockLocation(row: 1, column: 0)
                        ],
                        [
                            BlockLocation(row: 0, column: -1),
                            BlockLocation(row: 0, column: 0),
                            BlockLocation(row: 0, column: 1),
                            BlockLocation(row: -1, column: 0)
                        ],
                        [
                            BlockLocation(row: 0, column: -1),
                            BlockLocation(row: 0, column: 0),
                            BlockLocation(row: 1, column: 0),
                            BlockLocation(row: -1, column: 0)
                        ]
                ]
            case .J:
                return [
                        [
                            BlockLocation(row: 1, column: -1),
                            BlockLocation(row: 0, column: -1),
                            BlockLocation(row: 0, column: 0),
                            BlockLocation(row: 0, column: 1)],
                        [
                            BlockLocation(row: 1, column: 0),
                            BlockLocation(row: 0, column: 0),
                            BlockLocation(row: -1, column: 0),
                            BlockLocation(row: 1, column: 1)
                        ],
                        [
                            BlockLocation(row: -1, column: 1),
                            BlockLocation(row: 0, column: -1),
                            BlockLocation(row: 0, column: 0),
                            BlockLocation(row: 0, column: 1)
                        ],
                        [
                            BlockLocation(row: 1, column: 0),
                            BlockLocation(row: 0, column: 0),
                            BlockLocation(row: -1, column: 0),
                            BlockLocation(row: -1, column: -1)
                        ]
                ]
            case .L:
                return [
                        [
                            BlockLocation(row: 0, column: -1),
                            BlockLocation(row: 0, column: 0),
                            BlockLocation(row: 0, column: 1),
                            BlockLocation(row: 1, column: 1)
                        ],
                        [
                            BlockLocation(row: 1, column: 0),
                            BlockLocation(row: 0, column: 0),
                            BlockLocation(row: -1, column: 0),
                            BlockLocation(row: -1, column: 1)
                        ],
                        [
                            BlockLocation(row: 0, column: -1),
                            BlockLocation(row: 0, column: 0),
                            BlockLocation(row: 0, column: 1),
                            BlockLocation(row: -1, column: -1)
                        ],
                        [
                            BlockLocation(row: 1, column: 0),
                            BlockLocation(row: 0, column: 0),
                            BlockLocation(row: -1, column: 0),
                            BlockLocation(row: 1, column: -1)
                        ]
                ]
            case .S:
                return [
                        [
                            BlockLocation(row: 0, column: -1),
                             BlockLocation(row: 0, column: 0),
                             BlockLocation(row: 1, column: 0),
                             BlockLocation(row: 1, column: 1)
                        ],
                        [
                            BlockLocation(row: 1, column: 0),
                            BlockLocation(row: 0, column: 0),
                            BlockLocation(row: 0, column: 1),
                            BlockLocation(row: -1, column: 1)
                        ],
                        [
                            BlockLocation(row: 0, column: 1),
                            BlockLocation(row: 0, column: 0),
                            BlockLocation(row: -1, column: 0),
                            BlockLocation(row: -1, column: -1)
                        ],
                        [
                            BlockLocation(row: 1, column: -1),
                            BlockLocation(row: 0, column: -1),
                            BlockLocation(row: 0, column: 0),
                            BlockLocation(row: -1, column: 0)
                        ]
                ]
            case .Z:
                return [
                        [
                            BlockLocation(row: 1, column: -1),
                            BlockLocation(row: 1, column: 0),
                            BlockLocation(row: 0, column: 0),
                            BlockLocation(row: 0, column: 1)
                        ],
                        [
                            BlockLocation(row: 1, column: 1),
                            BlockLocation(row: 0, column: 1),
                            BlockLocation(row: 0, column: 0),
                            BlockLocation(row: -1, column: 0)
                        ],
                        [
                            BlockLocation(row: 0, column: -1),
                            BlockLocation(row: 0, column: 0),
                            BlockLocation(row: -1, column: 0),
                            BlockLocation(row: -1, column: 1)
                        ],
                        [
                            BlockLocation(row: 1, column: 0),
                            BlockLocation(row: 0, column: 0),
                            BlockLocation(row: 0, column: -1),
                            BlockLocation(row: -1, column: -1)
                        ]
                ]
            }
        }
    
    static func createTetromino(rows: Int, columns: Int) -> Tetromino {
        let type = BlockType.allCases.randomElement()!
        var maxRow = 0
        
        for block in getBlocks(type: type) {
            maxRow = max(maxRow, block.row)
        }
        
        let origin = BlockLocation(row: rows - 1 - maxRow, column: (columns - 1) / 2)
        return Tetromino(origin: origin, type: type, rotation: 0)
    }
    
    static func getKicks(type: BlockType, rotation: Int, clockwise: Bool) -> [BlockLocation] {
        let rotationCount = getAllBlocks(type: type).count
        var index = rotation % rotationCount
        
        if index < 0 { index += rotationCount }

        var kicks = getAllKicks(type: type)[index]
        
        if !clockwise {
            var counterKicks: [BlockLocation] = []
            for kick in kicks {
                counterKicks.append(BlockLocation(row: -1 * kick.row, column: -1 * kick.column))
            }
            kicks = counterKicks
        }
        
        return kicks
    }
        
    static func getAllKicks(type: BlockType) -> [[BlockLocation]] {
        switch type {
        case .O:
            return [
                [BlockLocation(row: 0, column: 0)]
            ]
        case .I:
            return [
                    [
                        BlockLocation(row: 0, column: 0),
                        BlockLocation(row: 0, column: -2),
                        BlockLocation(row: 0, column: 1),
                        BlockLocation(row: -1, column: -2),
                        BlockLocation(row: 2, column: -1)
                    ],
                    [
                        BlockLocation(row: 0, column: 0),
                        BlockLocation(row: 0, column: -1),
                        BlockLocation(row: 0, column: 2),
                        BlockLocation(row: 2, column: -1),
                        BlockLocation(row: -1, column: 2)
                    ],
                    [
                        BlockLocation(row: 0, column: 0),
                        BlockLocation(row: 0, column: 2),
                        BlockLocation(row: 0, column: -1),
                        BlockLocation(row: 1, column: 2),
                        BlockLocation(row: -2, column: -1)
                    ],
                    [
                        BlockLocation(row: 0, column: 0),
                        BlockLocation(row: 0, column: 1),
                        BlockLocation(row: 0, column: -2),
                        BlockLocation(row: -2, column: 1),
                        BlockLocation(row: 1, column: -2)
                    ]
            ]
        case .J, .L, .S, .Z, .T:
            return [
                    [
                        BlockLocation(row: 0, column: 0),
                        BlockLocation(row: 0, column: -1),
                        BlockLocation(row: 1, column: -1),
                        BlockLocation(row: 0, column: -2),
                        BlockLocation(row: -2, column: -1)
                    ],
                    [
                        BlockLocation(row: 0, column: 0),
                        BlockLocation(row: 0, column: 1),
                        BlockLocation(row: -1, column: 1),
                        BlockLocation(row: 2, column: 0),
                        BlockLocation(row: 1, column: 2)
                    ],
                    [
                        BlockLocation(row: 0, column: 0),
                        BlockLocation(row: 0, column: 1),
                        BlockLocation(row: 1, column: 1),
                        BlockLocation(row: -2, column: 0),
                        BlockLocation(row: -2, column: 1)
                    ],
                    [
                        BlockLocation(row: 0, column: 0),
                        BlockLocation(row: 0, column: -1),
                        BlockLocation(row: -1, column: -1),
                        BlockLocation(row: 2, column: 0),
                        BlockLocation(row: 2, column: -1)
                    ]
            ]
        }
    }
}

struct BlockLocation {
    var row: Int
    var column: Int
}
