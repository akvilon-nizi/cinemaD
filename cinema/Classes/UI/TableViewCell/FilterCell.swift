//
//  Filter.swift
//  cinema
//
//  Created by User on 07.11.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

protocol FilterCellDelegate: class {
    func tapButtonSetting(_ index: IndexPath)
}

// MARK: - FilterCell

class FilterCell: UITableViewCell {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.cnmFutura(size: 19)
        label.textColor = UIColor.cnmAfafaf
        return label
    }()

    let selectImage = Asset.Kinobase.check28.image

    private let button = UIButton()

    var indexPath: IndexPath = IndexPath(row: 0, section: 0)

    weak var delegate: FilterCellDelegate?

    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }

    required init?(coder _: NSCoder) {
        fatalError("NSCoding not supported")
    }

    var isDidSelect = false {
        didSet {
            titleLabel.textColor = !isDidSelect ? UIColor.cnmAfafaf : UIColor.cnmMainOrange
            let image = !isDidSelect ? nil : Asset.Kinobase.check28.image
            button.setImage(image, for: .normal)
        }
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none

        contentView.addSubview(titleLabel.prepareForAutoLayout())
        titleLabel.centerYAnchor ~= centerYAnchor
        titleLabel.leadingAnchor ~= leadingAnchor + 34

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

        contentView.backgroundColor = .white
    }

    // MARK: Actions
    func tapSettings() {
        delegate?.tapButtonSetting(indexPath)
    }

    static var reuseIdentifier: String {
        return "FilterCell"
    }
}
