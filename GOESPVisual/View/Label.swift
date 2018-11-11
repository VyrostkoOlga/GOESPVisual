//
//  Label.swift
//  GOESPVisual
//
//  Created by Olga Vyrostko on 11/11/2018.
//  Copyright © 2018 olgavyrostko. All rights reserved.
//

import Cocoa

func makeLabel(mark: Int) -> NSTextField {
    let textField = NSTextField(string: "\(mark)")
    textField.isBezeled = false
    textField.drawsBackground = false
    textField.isEditable = false
    textField.isSelectable = false
    textField.textColor = .black
    textField.backgroundColor = .white
    return textField
}
