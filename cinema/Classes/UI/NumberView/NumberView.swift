//
//  NumberView.swift
//  foodle
//
//  Created by incetro on 21/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

// MARK: - NumberViewDelegate

protocol NumberViewDelegate: class {

    func didFinishInput(text: String)
}

// MARK: - NumberView

class NumberView: UIView {

    weak var delegate: NumberViewDelegate?

    fileprivate var index = 0
    fileprivate var isKeyboardVisible = false
    fileprivate var tapped = false
    fileprivate var delete = false

    private let textField: NumberTextField = {

        let textField = NumberTextField()

        textField.font = UIFont.fdlSystemRegular(size: 20)
        textField.keyboardType = .numberPad
        textField.inputAccessoryView = UIToolbar()

        return textField
    }()

    private let stackView: UIStackView = {

        let stackView = UIStackView()

        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill

        return stackView
    }()

    fileprivate let components: [PointDigitView]

    var number: String {

        return components.flatMap { $0.digit }.reduce("", +)
    }

    init(withDigitsCount count: Int, separateIn indexes: Int...) {

        components = (0..<count).map { _ in PointDigitView() }

        super.init(frame: .zero)

        backgroundColor = .white

        addSubview(textField.prepareForAutoLayout())

        textField.pinEdgesToSuperviewEdges()

        addSubview(stackView.prepareForAutoLayout())

        stackView.pinEdgesToSuperviewEdges()

        textField.delegate = self
        textField.deleteDelegate = self

        var index = 0

        for i in 0..<count + indexes.count {

            if indexes.contains(i) {

                stackView.addArrangedSubview(UIView())

            } else {

                stackView.addArrangedSubview(components[index].prepareForAutoLayout())

                index += 1
            }
        }

        components.first?.turnOn()

        let recognizer = UITapGestureRecognizer(target: self, action: #selector(tap(recognizer:)))

        self.addGestureRecognizer(recognizer)
    }

    func activateCursor() {

        textField.becomeFirstResponder()
    }

    func tap(recognizer: UITapGestureRecognizer) {

        if !isKeyboardVisible {

            textField.becomeFirstResponder()
            isKeyboardVisible = true
            return
        }

        tapped = true

        let position = recognizer.location(in: stackView)

        guard let component = components.first(where: { $0.frame.contains(position) }) else {

            return
        }

        guard let index = components.index(of: component), index < self.index else {

            return
        }

        for i in 0..<components.count where i != index {

            components[i].turnOff()
        }

        self.index = index

        component.turnOn()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - NumberTextFieldDelegate

extension NumberView: NumberTextFieldDelegate {

    func deletePressed() {

        if tapped, index >= 0 {

            components[index].clear()
            components[index].turnOn()

            if index + 1 < components.count {

                components[index + 1].turnOff()
            }

            index -= 1

            delete = true

        } else if index >= 0 {

            index -= 1

            guard index >= 0 else {

                return
            }

            components[index].clear()
            components[index].turnOn()

            if index + 1 < components.count {

                components[index + 1].turnOff()
            }
        }
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        guard index < components.count else {

            return false
        }

        if !string.isEmpty {

            if tapped {

                if delete {

                    delete = false
                    index += 1
                }

                guard index >= 0, index < components.count else {

                    return false
                }

                components[index].setDigit(string)

                index += 1

                if index < components.count {

                    components[index].turnOn()
                }

            } else {

                guard index < components.count else {

                    return false
                }

                if index < 0 {

                    index = 0
                }

                components[index].setDigit(string)

                index += 1
            }

            if index >= components.count {

                tapped = false
                textField.resignFirstResponder()

                if number.characters.count == components.count {

                    delegate?.didFinishInput(text: number)
                }

            } else {

                components[index].turnOn()
            }
        }

        return false
    }

    func textFieldDidEndEditing(_ textField: UITextField) {

        isKeyboardVisible = false
    }
}
