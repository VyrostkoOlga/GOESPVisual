//
//  GOESPView.swift
//  GOESPVisual
//
//  Created by Olga Vyrostko on 11/11/2018.
//  Copyright © 2018 olgavyrostko. All rights reserved.
//

import Foundation

protocol GOESPView {
    func configure(grammar: GOESP)
    func didSelect(level: Int, symbol: Int)
    func didAdd(level: Int, symbol: Int, sign: Int)
}
