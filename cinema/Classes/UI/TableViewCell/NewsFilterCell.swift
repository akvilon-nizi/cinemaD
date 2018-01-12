//
//  NewsFilterCell.swift
//  cinema
//
//  Created by  iMac on 14.11.2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

// MARK: - NewsFilterCell

class NewsFilterCell: UITableViewCell {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.cnmFutura(size: 19)
        label.textColor = UIColor.cnmAfafaf
        return label
    }()

    let selectImage = Asset.Kinobase.check28.image

    private let button = UIButton()

    var indexPath: IndexPath = IndexPath(row: 0, section: 0)

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
            let image = !isDidSelect ? Asset.Kinobase.cicle.image : Asset.Kinobase.check28.image
            button.setImage(image, for: .normal)
        }
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none

        contentView.backgroundColor = .white

        contentView.addSubview(titleLabel.prepareForAutoLayout())
        titleLabel.centerYAnchor ~= centerYAnchor
        titleLabel.leadingAnchor ~= leadingAnchor + 34

        contentView.addSubview(button.prepareForAutoLayout())
        button.centerYAnchor ~= centerYAnchor
        button.trailingAnchor ~= trailingAnchor - 40
        button.isUserInteractionEnabled = false
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        contentView.backgroundColor = .white
    }

    static var reuseIdentifier: String {
        return "NewsFilterCell"
    }
}
