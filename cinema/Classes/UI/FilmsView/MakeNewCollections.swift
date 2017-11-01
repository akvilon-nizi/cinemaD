//
//  MakeNewCollections.swift
//  cinema
//
//  Created by User on 01.11.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

protocol MakeNewCollDelegate: class {
    func openFullList()
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

        button.setImage(Asset.Kinobase.forward.image, for: .normal)
        addSubview(button.prepareForAutoLayout())
        button.semanticContentAttribute = .forceRightToLeft
        button.heightAnchor ~= 33
        button.centerYAnchor ~= centerYAnchor
        button.leadingAnchor ~= leadingAnchor + 33

        let separatorView = UIView()
        separatorView.heightAnchor ~= 1
        separatorView.topAnchor ~= button.bottomAnchor + 13
        //ASSA
    }

    func tapButton() {
        delegate?.openFullList()
    }
}
