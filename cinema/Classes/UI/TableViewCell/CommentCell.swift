//
//  CommentCell.swift
//  cinema
//
//  Created by User on 22.11.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

// MARK: - NewsFilterCell

protocol CommentCellDelegate: class {
//    func openShareSimple(comment: News)
    func deleteComment(indexRow: Int)
}

class CommentCell: UITableViewCell {

    var comment: Comment?

    var indexRow: Int = 0

    weak var delegate: CommentCellDelegate?

    private let newsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.cnmFuturaLight(size: 14)
        label.textColor = UIColor.cnmAfafaf
        label.numberOfLines = 0
        return label
    }()

    private let infoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.cnmFuturaLight(size: 10)
        label.textColor = UIColor(white: 117.0 / 255.0, alpha: 1.0)
        label.numberOfLines = 1
        return label
    }()

    private let countLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.cnmFuturaLight(size: 12)
        label.textColor = UIColor.cnm3a3a3a
        label.numberOfLines = 1
        return label
    }()

    private let deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.Kinobase.close.image, for: .normal)
        return button
    }()

    private let userImage: UIImageView = {
        let imageView = UIImageView()
        imageView.heightAnchor ~= 23
        imageView.widthAnchor ~= 23
        imageView.backgroundColor = UIColor.cnm3a3a3a
        imageView.layer.cornerRadius = 23 / 2
        imageView.layer.masksToBounds = true
        return imageView
    }()

    required init?(coder _: NSCoder) {
        fatalError("NSCoding not supported")
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none

        contentView.backgroundColor = .white

        autoresizesSubviews = true

        let mainView = UIView()
        contentView.addSubview(mainView.prepareForAutoLayout())
        mainView.topAnchor ~= contentView.topAnchor + 19
        mainView.leadingAnchor ~= contentView.leadingAnchor + 34
        mainView.trailingAnchor ~= contentView.trailingAnchor - 27

        mainView.addSubview(userImage.prepareForAutoLayout())
        userImage.topAnchor ~= mainView.topAnchor
        userImage.leadingAnchor ~= mainView.leadingAnchor

        mainView.addSubview(infoLabel.prepareForAutoLayout())
        infoLabel.centerYAnchor ~= userImage.centerYAnchor
        infoLabel.leadingAnchor ~= userImage.trailingAnchor + 11

        mainView.addSubview(newsLabel.prepareForAutoLayout())
        newsLabel.topAnchor ~= infoLabel.bottomAnchor + 14
        newsLabel.leadingAnchor ~= mainView.leadingAnchor
        newsLabel.trailingAnchor ~= mainView.trailingAnchor
        newsLabel.bottomAnchor ~= mainView.bottomAnchor

        contentView.addSubview(deleteButton.prepareForAutoLayout())
        deleteButton.trailingAnchor ~= contentView.trailingAnchor - 20
        deleteButton.topAnchor ~= contentView.topAnchor + 10
        deleteButton.isHidden = true
        deleteButton.addTarget(self, action: #selector(deleteButtonTap), for: .touchUpInside)

        let separatorView = UIView()
        separatorView.backgroundColor = .cnmDadada
        contentView.addSubview(separatorView.prepareForAutoLayout())
        separatorView.bottomAnchor ~= contentView.bottomAnchor
        separatorView.trailingAnchor ~= contentView.trailingAnchor - 24
        separatorView.leadingAnchor ~= contentView.leadingAnchor + 24
        separatorView.heightAnchor ~= 1
        separatorView.topAnchor ~= mainView.bottomAnchor + 20
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    func setComment(_ comment: Comment) {
        self.comment = comment
        infoLabel.text = comment.creator.name + ", " + comment.createdAt.hourMinutes + ", " + comment.createdAt.monthMedium
        userImage.kf.setImage(with: URL(string: comment.creator.avatar))
        newsLabel.text = comment.description
        countLabel.text = String(comment.shared)
    }

    func isMain() {
        deleteButton.isHidden = false
    }

    func isNotMain() {
        deleteButton.isHidden = true
    }

    func deleteButtonTap() {
        delegate?.deleteComment(indexRow: indexRow)
    }

    static var reuseIdentifier: String {
        return "CommentCell"
    }
}
