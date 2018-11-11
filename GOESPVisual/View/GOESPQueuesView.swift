//
//  GOESPQueuesView.swift
//  GOESPVisual
//
//  Created by Olga Vyrostko on 11/11/2018.
//  Copyright © 2018 olgavyrostko. All rights reserved.
//

import Cocoa

final class GOESPQueuesView: NSView, GOESPView {

    private var labels = [[NSTextField]]()

    func didSelect(level: Int, symbol: Int) {
        //NSAnimationContext.current.duration = 0.5
        NSAnimationContext.runAnimationGroup({ [weak self] (ctx) in
            guard let sself = self else { return }
            sself.labels.forEach { $0.forEach { $0.textColor = .black } }
            sself.labels[level][symbol].textColor = .blue
        })
    }

    func didAdd(level: Int, symbol: Int, sign: Int) {

    }

    func configure(grammar: GOESP) {
        labels = grammar.queues.map {
            return $0.map { makeLabel(mark: $0) }
        }
        var prevView: NSView?
        for idx in 0..<labels.count {
            let layer = labels[idx]
            let view = NSView()
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
            let bottomConstraint: NSLayoutConstraint
            if let prevView = prevView {
                bottomConstraint = view.bottomAnchor.constraint(equalTo: prevView.topAnchor)
            } else {
                bottomConstraint = view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            }
            NSLayoutConstraint.activate([
                bottomConstraint,
                view.leadingAnchor.constraint(equalTo: leadingAnchor),
                view.trailingAnchor.constraint(equalTo: trailingAnchor)
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
                prevView.topAnchor.constraint(lessThanOrEqualTo: topAnchor)
            ])
        }
    }
}
