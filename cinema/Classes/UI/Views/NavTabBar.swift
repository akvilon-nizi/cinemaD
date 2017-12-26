//
//  NavTabBar.swift
//  cinema
//
//  Created by iOS on 06.12.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

protocol NavTabBarDelegate: class {
    func tapElement(_ number: Int)
}

class NavTabBar: UIView {

    weak var delegate: NavTabBarDelegate?

    required init(coder _: NSCoder) {
        fatalError("NSCoding not supported")
    }

    private var buttonsArray: [UIButton] = []

    private var currentNumber: Int = 0

    var width: CGFloat = 0

    let height: CGFloat = 37

    let inset: CGFloat = 16

    init(titles: [String]) {
        super.init(frame: .zero)

        width = (UIWindow(frame: UIScreen.main.bounds).bounds.width - inset * 2 - CGFloat(titles.count - 1)) / CGFloat(titles.count)

        var elementsArray: [UIView] = []

        var i = 0

        var widthStackView: CGFloat = 0

        for title in titles {
            let button = UIButton().setParameters(title: title, width: width, height: height)
            button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
            button.tag = i
            i += 1
            buttonsArray.append(button)
            button.sizeToFit()
            widthStackView += button.frame.width + 15
            elementsArray.append(button)
            if i != titles.count {
                widthStackView += 1
                elementsArray.append(UIView().makeSeparator(height: height))
            }
        }

        buttonsArray[0].isSelected = true

        let scrollView = UIScrollView()
        addSubview(scrollView.prepareForAutoLayout())
        scrollView.topAnchor ~= topAnchor
        scrollView.leadingAnchor ~= leadingAnchor
        scrollView.widthAnchor ~= UIWindow(frame: UIScreen.main.bounds).bounds.width
        scrollView.heightAnchor ~= height + 50
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
        scrollView.contentOffset = CGPoint(x: -inset, y: 0)

        let stackView = createStackView(.horizontal, .fill, .equalSpacing, 0, with: elementsArray)
        scrollView.addSubview(stackView.prepareForAutoLayout())
        stackView.centerYAnchor ~= scrollView.centerYAnchor
        stackView.leadingAnchor ~= scrollView.leadingAnchor
        stackView.widthAnchor ~= widthStackView + 20
        stackView.heightAnchor ~= height
        scrollView.contentSize = CGSize(width: widthStackView + 20, height: height)

    }

    func didTapButton(button: UIButton) {
        if currentNumber != button.tag {
            for but in buttonsArray {
                if but.tag == button.tag {
                    but.isSelected = true
                } else {
                    but.isSelected = false
                }
            }
            currentNumber = button.tag
            delegate?.tapElement(currentNumber)
        }
    }
}

private extension UIButton {
    func setParameters(title: String, width: CGFloat, height: CGFloat) -> UIButton {
        self.setTitle(title, for: .normal)
        self.setTitleColor(UIColor.setColorGray(white: 175, alpha: 0.4), for: .normal)
        self.setTitleColor(UIColor.setColorGray(white: 175, alpha: 1), for: .selected)

        let size: CGFloat = UIWindow(frame: UIScreen.main.bounds).bounds.width == 320 ? 14 : 16

        self.titleLabel?.font = UIFont.cnmFuturaLight(size: size)
        self.heightAnchor ~= height
        self.titleLabel?.sizeToFit()
        if let titleLabel = self.titleLabel {
            self.widthAnchor ~= titleLabel.widthAnchor + 15
        }
        return self
    }
}

private extension UIView {
    func makeSeparator(height: CGFloat) -> UIView {
        self.heightAnchor ~= height
        self.widthAnchor ~= 1
        self.backgroundColor = UIColor.cnmAfafaf
        return self
    }
}
