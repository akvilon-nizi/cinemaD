//
//  FullListFilms.swift
//  cinema
//
//  Created by Mac on 31.10.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

protocol FullListFilmsDelegate: class {
    func openFullList()
}

class FullListFilms: UITableViewHeaderFooterView {

    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    weak var delegate: FullListFilmsDelegate?

    let windowWidth = UIWindow(frame: UIScreen.main.bounds).bounds.width - 60

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        let button: UIButton = UIButton()
        button.setTitle("Полный список   ", for: .normal)
        button.setTitleColor(UIColor(white: 119.0 / 255.0, alpha: 1.0), for: .normal)
        button.titleLabel?.font = UIFont.cnmFutura(size: 16)
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)

        button.setImage(Asset.Kinobase.forward.image, for: .normal)
        addSubview(button.prepareForAutoLayout())
        button.semanticContentAttribute = .forceRightToLeft
        button.heightAnchor ~= 33
        button.centerYAnchor ~= centerYAnchor
        button.trailingAnchor ~= trailingAnchor - 30

    }

    func tapButton() {
        delegate?.openFullList()
    }
}
