//
//  GameBlock.swift
//  TetrisGame
//
//  Created by Andrey Shulmin on 05.07.2023.
//

import SwiftUI

struct GameBlock {
    let type: BlockType
}

struct GameSquare {
    var color: Color
}

enum BlockType : CaseIterable {
     case I, J, L, O, S, T, Z
}

