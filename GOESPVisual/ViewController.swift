//
//  ViewController.swift
//  GOESPVisual
//
//  Created by Olga Vyrostko on 10/11/2018.
//  Copyright © 2018 olgavyrostko. All rights reserved.
//

import Cocoa

final class ViewController: NSViewController {

    enum Mode {
        case build
        case search
    }

    private let grammar = GOESP.build(str: "AAACA")
    private var labels = [[NSTextField]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        labels = grammar.queues.map {
            return $0.map { makeLabel(mark: $0) }
        }
        var prevView: NSView?
        for idx in 0..<labels.count {
            let layer = labels[idx]
            let view = NSView()
            view.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(view)
            let bottomConstraint: NSLayoutConstraint
            if let prevView = prevView {
                bottomConstraint = view.bottomAnchor.constraint(equalTo: prevView.topAnchor)
            } else {
                bottomConstraint = view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            }
            NSLayoutConstraint.activate([
                bottomConstraint,
                view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
                //view.heightAnchor.constraint(equalToConstant: 4.0)
            ])
            prevView = view

            var prevLabel: NSTextField?
            layer.forEach {
                view.addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
                let leadingConstraint: NSLayoutConstraint
                if let prevLabel = prevLabel {
                    leadingConstraint = $0.leadingAnchor.constraint(equalTo: prevLabel.trailingAnchor)
                } else {
                    leadingConstraint = $0.leadingAnchor.constraint(equalTo: view.leadingAnchor)
                }
                NSLayoutConstraint.activate([
                    leadingConstraint,
                    $0.topAnchor.constraint(equalTo: view.topAnchor),
                    $0.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                ])
                prevLabel = $0
            }
            if let prevLabel = prevLabel {
                prevLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor).isActive = true
            }
        }
        if let prevView = prevView {
            NSLayoutConstraint.activate([
                prevView.topAnchor.constraint(lessThanOrEqualTo: view.topAnchor)
            ])
        }
    }

    private func makeLabel(mark: Int) -> NSTextField {
        let textField = NSTextField(string: "\(mark)")
        textField.isBezeled = false
        textField.drawsBackground = false
        textField.isEditable = false
        textField.isSelectable = false
        textField.textColor = .black
        textField.backgroundColor = .white
        return textField
    }
}

