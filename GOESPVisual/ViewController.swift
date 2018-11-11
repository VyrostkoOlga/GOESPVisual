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

    private let string = "AAACA"
    private lazy var grammar = GOESP.build(str: string)
    private let grammarView: (GOESPView & NSView) = {
        let view = GOESPQueuesView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let searchTextField: NSTextField = {
        let textField = NSTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var nextBtn: NSButton = {
        let btn = NSButton(title: "Next", target: self, action: #selector(nextButtonDidPressed))
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.isEnabled = false
        return btn
    }()
    private lazy var startBtn: NSButton = {
        let btn = NSButton(title: "Start", target: self, action: #selector(startButtonDidPressed))
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    private var steps = [IndexPath]()
    private var currentStep: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(grammarView)
        view.addSubview(nextBtn)
        view.addSubview(startBtn)
        view.addSubview(searchTextField)

        searchTextField.delegate = self
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: view.topAnchor),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor),

            startBtn.leadingAnchor.constraint(equalTo: searchTextField.trailingAnchor),
            startBtn.topAnchor.constraint(equalTo: searchTextField.topAnchor),
            startBtn.bottomAnchor.constraint(equalTo: searchTextField.bottomAnchor),

            nextBtn.topAnchor.constraint(equalTo: searchTextField.topAnchor),
            nextBtn.leadingAnchor.constraint(equalTo: startBtn.trailingAnchor),
            nextBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nextBtn.bottomAnchor.constraint(equalTo: searchTextField.bottomAnchor),

            grammarView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 10.0),
            grammarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            grammarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            grammarView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        grammarView.configure(grammar: grammar)
    }

    @objc func startButtonDidPressed() {
        currentStep = 0
        steps = []
        nextBtn.isEnabled = false
        startBtn.isEnabled = false
        _ = grammar.searchDeep2(substring: searchTextField.stringValue) { [weak self] (level, symbol) in
            guard let sself = self else { return }
            sself.steps.append(IndexPath(item: symbol, section: level))
        }
        nextBtn.isEnabled = true
        startBtn.isEnabled = true
    }

    @objc func nextButtonDidPressed() {
        guard currentStep < steps.count else {
            nextBtn.title = "Finished"
            nextBtn.isEnabled = false
            return
        }
        let step = steps[currentStep]
        grammarView.didSelect(level: step.section, symbol: step.item)
        currentStep += 1
        if currentStep >= steps.count {
            nextBtn.title = "Finished"
            nextBtn.isEnabled = false
        }
    }
}

extension ViewController: NSTextFieldDelegate {
    func control(_ control: NSControl, textShouldEndEditing fieldEditor: NSText) -> Bool {
        startButtonDidPressed()
        return true
    }
}

