//
//  DeleteFooter.swift
//  cinema
//
//  Created by User on 10.11.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

class DeleteFooter: UITableViewHeaderFooterView {

    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    let deleteButton = UIButton(type: .system).setTitleWithColor(
        title: "Удалить",
        color: UIColor(red: 202.0 / 255.0, green: 80.0 / 255.0, blue: 62.0 / 255.0, alpha: 1.0)
    )

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        addSubview(deleteButton.prepareForAutoLayout())

        deleteButton.centerYAnchor ~= centerYAnchor
        deleteButton.centerXAnchor ~= centerXAnchor
    }
}
