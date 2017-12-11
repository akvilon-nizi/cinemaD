//
//  SearchView.swift
//  cinema
//
//  Created by Mac on 29.10.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

// MARK: - SearchView

class SearchView: UIView {

    private let contentView = UIView()

    var buttonsStack: UIStackView?

//    private let titleLabel: UILabel = {
//
//        let titleLabel = UILabel()
//
//        titleLabel.text = L10n.slide1ButtonText
//        titleLabel.font = UIFont.fdlGothamProMedium(size: 9)
//        titleLabel.textColor = UIColor.white
//        titleLabel.textAlignment = .center
//        titleLabel.backgroundColor = UIColor.cnmMainOrange
//        titleLabel.layer.cornerRadius = 3.0
//        titleLabel.layer.masksToBounds = true
//
//        return titleLabel
//    }()

    override init(frame: CGRect) {

        super.init(frame: frame)

    }

    func setInfo(placeholder: String, titles: [String]) {
        var buttonsArray: [SearchCell] = []
        for title in titles {
            let view = SearchCell()
            view.button.addTarget(self, action: #selector(titleButtonTap), for: .touchUpInside)
            view.titleLabel.text = title
            buttonsArray.append(view)
        }
        buttonsStack = createStackView(.vertical, .fill, .fill, 1.0, with: buttonsArray)
        let titleField = UITextField()
        titleField.placeholder = placeholder

        let searchImageView = UIImageView(image: Asset.Search.search.image)
        let leftView = UIView()
        leftView.frame = CGRect(x: 0, y: 0, width: 62, height: 18)
        leftView.addSubview(searchImageView)
        searchImageView.frame = CGRect(x: 32, y: 0, width: 19, height: 18)

        titleField.leftView = leftView
        titleField.leftViewMode = .always

        let rightButton = UIButton(frame: CGRect(x: 10, y: 0, width: 20, height: 20))
        rightButton.setImage(Asset.Search.type.image, for: .normal)
        rightButton.addTarget(self, action: #selector(typeButtonTap), for: .touchUpInside)
        let rightView = UIView()
        rightView.frame = CGRect(x: 0, y: 0, width: 68, height: 20)
        rightView.addSubview(rightButton)
        titleField.rightView = rightView
        titleField.rightViewMode = .always

        if let stackView = buttonsStack {
            let mainStack = createStackView(.vertical, .fill, .fill, 20.0, with: [titleField, stackView])
            addSubview(mainStack.prepareForAutoLayout())
            mainStack.pinEdgesToSuperviewEdges()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Actions

    func titleButtonTap(button: UIButton) {
        button.isSelected = !button.isSelected
        if button.isSelected {
            button.backgroundColor = .clear
        } else {
            button.backgroundColor = UIColor.cnmMainOrange
        }
    }

    func typeButtonTap() {
        if let stackView = buttonsStack {
            stackView.isHidden = !stackView.isHidden
        }
    }
}
