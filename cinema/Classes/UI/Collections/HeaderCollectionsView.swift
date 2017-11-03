//
//  HeaderCollectionsView.swift
//  cinema
//
//  Created by User on 01.11.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

class HeaderCollectionsView: UITableViewHeaderFooterView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.cnmFutura(size: 19)
        label.textColor = UIColor.cnmGreyColor1
        label.text = "Ваша коллекция"
        return label
    }()

    private let textField: UITextField = {
        let textF = UITextField()
        textF.font = UIFont.cnmFutura(size: 17)
        textF.textColor = UIColor.cnmGreyColor1
        textF.placeholder = "Введите название коллекции"
        return textF
    }()

    var title: String = "" {
        didSet {
            textField.text = title
        }
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    let windowWidth = UIWindow(frame: UIScreen.main.bounds).bounds.width - 60

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        addSubview(titleLabel.prepareForAutoLayout())
        titleLabel.topAnchor ~= topAnchor + 15
        titleLabel.trailingAnchor ~= trailingAnchor - 30
        titleLabel.leadingAnchor ~= leadingAnchor + 30

        addSubview(textField.prepareForAutoLayout())
        textField.topAnchor ~= titleLabel.bottomAnchor + 15
        textField.trailingAnchor ~= trailingAnchor - 30
        textField.leadingAnchor ~= leadingAnchor + 30
    }

    func returnTitle() -> String {
        if let text = textField.text {
            return text
        } else {
            return ""
        }
    }
}
