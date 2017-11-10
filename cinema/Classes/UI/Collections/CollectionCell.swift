//
//  CollectionCell.swift
//  cinema
//
//  Created by User on 02.11.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

protocol CollectionCellDelegate: class {
    func tapButtonSetting(_ index: Int)
}

// MARK: - CollectionCell

class CollectionCell: UITableViewCell {

//    let selectColor = UIColor(white: 87.0 / 255.0, alpha: 1.0)
//    let unSelectColor = UIColor.cnmAfafaf

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.cnmFutura(size: 19)
        label.textColor = UIColor.cnmAfafaf
//        label.text = "sdofnkalsfna"
        return label
    }()

    private let button = UIButton()

    var indexPath: Int = 0

    weak var delegate: CollectionCellDelegate?

    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }

    required init?(coder _: NSCoder) {
        fatalError("NSCoding not supported")
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none

        contentView.addSubview(titleLabel.prepareForAutoLayout())
        titleLabel.centerYAnchor ~= centerYAnchor
        titleLabel.leadingAnchor ~= leadingAnchor + 34

        button.setImage(Asset.Kinobase.settingsUnselect.image, for: .normal)
        contentView.addSubview(button.prepareForAutoLayout())
        button.centerYAnchor ~= centerYAnchor
        button.trailingAnchor ~= trailingAnchor - 40
        button.addTarget(self, action: #selector(tapSettings), for: .touchUpInside)

        let separatorView = UIView()
        separatorView.backgroundColor = .cnmDadada
        contentView.addSubview(separatorView.prepareForAutoLayout())
        separatorView.bottomAnchor ~= bottomAnchor
        separatorView.trailingAnchor ~= trailingAnchor - 24
        separatorView.leadingAnchor ~= leadingAnchor + 24
        separatorView.heightAnchor ~= 1
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        titleLabel.textColor = !selected ? UIColor.cnmAfafaf : UIColor(white: 87.0 / 255.0, alpha: 1.0)

        if selected {
            button.setImage(Asset.Kinobase.settings.image, for: .normal)
        } else {
            button.setImage(Asset.Kinobase.settingsUnselect.image, for: .normal)
        }

        contentView.backgroundColor = .white
    }

    // MARK: Actions
    func tapSettings() {
        delegate?.tapButtonSetting(indexPath)
    }

    static var reuseIdentifier: String {
        return "CollectionCell"
    }
}
