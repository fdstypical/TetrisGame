//
//  KeyboardHandler.swift
//  TetrisGame
//
//  Created by Andrey Shulmin on 05.07.2023.
//

import SwiftUI

struct KeyboardHandler : NSViewRepresentable {
    var gameModel: TetrisGameModel
    
    class KeyView: NSView {
        override var acceptsFirstResponder: Bool { true }
        
        override func keyDown(with event: NSEvent) {
            print(">> key \(event.keyCode)")
            
            if event.keyCode == 49 {
                // todo: rotate
            }
            
            if event.keyCode == 123 {
                
            }
            
            if event.keyCode == 124 {
                // todo: right
            }
            
            if event.keyCode == 126 {
                // todo: dtop
            }
            
            
        }
    }

    func makeNSView(context: Context) -> NSView {
        let view = KeyView()
        
        DispatchQueue.main.async {
            view.window?.makeFirstResponder(view)
        }
        
        return view
    }

    func updateNSView(_ nsView: NSView, context: Context) { }
}
