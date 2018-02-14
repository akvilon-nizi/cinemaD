//
//  MakeNewCollections.swift
//  cinema
//
//  Created by User on 01.11.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

protocol MakeNewCollDelegate: class {
    func newCollections()
}

class MakeNewCollections: UITableViewHeaderFooterView {

    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    weak var delegate: MakeNewCollDelegate?

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        let button: UIButton = UIButton()
        button.setTitle("+ Создать коллекцию", for: .normal)
        button.setTitleColor(UIColor.cnmMainOrange, for: .normal)
        button.titleLabel?.font = UIFont.cnmFutura(size: 16)
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)

        addSubview(button.prepareForAutoLayout())
        button.heightAnchor ~= 33
        button.centerYAnchor ~= centerYAnchor
        button.leadingAnchor ~= leadingAnchor + 33

        let separatorView = UIView()
        separatorView.backgroundColor = .cnmDadada
        contentView.addSubview(separatorView.prepareForAutoLayout())
        separatorView.bottomAnchor ~= bottomAnchor
        separatorView.trailingAnchor ~= trailingAnchor - 24
        separatorView.leadingAnchor ~= leadingAnchor + 24
        separatorView.heightAnchor ~= 1

        contentView.backgroundColor = .white
    }

    func tapButton() {
        delegate?.newCollections()
    }
}
