//
//  ContentView.swift
//  TetrisGame
//
//  Created by Andrey Shulmin on 04.07.2023.
//

import SwiftUI

struct ContentView: View {    
    var body: some View {
        GameView().background(Color.stone)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
