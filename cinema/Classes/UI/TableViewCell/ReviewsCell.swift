//
//  ReviewsCell.swift
//  cinema
//
//  Created by iOS on 29.11.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

// MARK: - NewsFilterCell

protocol ReviewsCellDelegate: class {
    func deleteReview(indexRow: Int)
}

class ReviewsCell: UITableViewCell {

    var comment: Comment?

    weak var delegate: ReviewsCellDelegate?

    var indexRow: Int = 0

    private let userInfoView = UIView()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.cnmFuturaLight(size: 18)
        label.textColor = UIColor.cnmBlue
        label.numberOfLines = 2
        return label
    }()

    private let newsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.cnmFuturaLight(size: 14)
        label.textColor = UIColor.setColorGray(white: 52)
        label.numberOfLines = 0
        return label
    }()

    private let infoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.cnmFuturaLight(size: 10)
        label.textColor = UIColor.cnmAfafaf
        label.numberOfLines = 1
        return label
    }()

    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.cnmFuturaLight(size: 18)
        label.textColor = UIColor.cnmMainOrange
        label.numberOfLines = 1
        return label
    }()

    private let userImage: UIImageView = {
        let imageView = UIImageView()
        imageView.heightAnchor ~= 55
        imageView.widthAnchor ~= 55
        imageView.backgroundColor = UIColor.cnm3a3a3a
        imageView.layer.cornerRadius = 55 / 2
        imageView.layer.masksToBounds = true
        return imageView
    }()

    private let starImage: UIImageView = {
        let imageView = UIImageView()
        imageView.heightAnchor ~= 11
        imageView.widthAnchor ~= 12
        imageView.image = Asset.Cinema.orangeStars.image
        return imageView
    } ()

    private let deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.Kinobase.close.image, for: .normal)
        return button
    }()

    required init?(coder _: NSCoder) {
        fatalError("NSCoding not supported")
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none

        autoresizesSubviews = true

        let mainView = UIView()
        contentView.addSubview(mainView.prepareForAutoLayout())
        mainView.topAnchor ~= contentView.topAnchor + 26
        mainView.leadingAnchor ~= contentView.leadingAnchor + 44
        mainView.trailingAnchor ~= contentView.trailingAnchor - 49

        mainView.addSubview(userImage.prepareForAutoLayout())
        userImage.topAnchor ~= mainView.topAnchor
        userImage.leadingAnchor ~= mainView.leadingAnchor

        userInfoView.addSubview(statusLabel.prepareForAutoLayout())
        statusLabel.topAnchor ~= userInfoView.topAnchor
        statusLabel.leadingAnchor ~= userInfoView.leadingAnchor

        userInfoView.addSubview(starImage.prepareForAutoLayout())
        starImage.leadingAnchor ~= statusLabel.trailingAnchor + 7
        starImage.centerYAnchor ~= statusLabel.centerYAnchor
        userInfoView.heightAnchor ~= statusLabel.heightAnchor

        let infoStack = createStackView(.vertical, .fill, .fill, 2, with: [userInfoView, nameLabel, infoLabel])

        mainView.addSubview(infoStack.prepareForAutoLayout())
        infoStack.centerYAnchor ~= userImage.centerYAnchor
        infoStack.leadingAnchor ~= userImage.trailingAnchor + 11
        infoStack.trailingAnchor ~= mainView.trailingAnchor

        mainView.addSubview(newsLabel.prepareForAutoLayout())
        newsLabel.topAnchor ~= userImage.bottomAnchor + 14
        newsLabel.leadingAnchor ~= mainView.leadingAnchor
        newsLabel.trailingAnchor ~= mainView.trailingAnchor
        newsLabel.bottomAnchor ~= mainView.bottomAnchor

        contentView.addSubview(deleteButton.prepareForAutoLayout())
        deleteButton.trailingAnchor ~= contentView.trailingAnchor - 20
        deleteButton.topAnchor ~= contentView.topAnchor + 20
        deleteButton.isHidden = true
        deleteButton.addTarget(self, action: #selector(deleteButtonTap), for: .touchUpInside)

        let separatorView = UIView()
        separatorView.backgroundColor = .cnmDadada
        contentView.addSubview(separatorView.prepareForAutoLayout())
        separatorView.bottomAnchor ~= contentView.bottomAnchor
        separatorView.trailingAnchor ~= contentView.trailingAnchor - 24
        separatorView.leadingAnchor ~= contentView.leadingAnchor + 24
        separatorView.heightAnchor ~= 1
        separatorView.topAnchor ~= mainView.bottomAnchor + 25
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    func setComment(_ comment: Comment) {
        self.comment = comment
        infoLabel.text = comment.createdAt.hourMinutes + ", " + comment.createdAt.monthMedium
        userImage.kf.setImage(with: URL(string: comment.creator.avatar))
        nameLabel.text = comment.creator.name
        newsLabel.text = comment.description
        if let type = comment.creator.type {
            switch type {
            case "user":
                userInfoView.isHidden = true
            case "admin":
                userInfoView.isHidden = false
                starImage.isHidden = true
                statusLabel.text = "Администратор"
                statusLabel.text = type
            default:
                userInfoView.isHidden = false
                starImage.isHidden = false
                statusLabel.text = "Блогер"
                statusLabel.text = type
            }
        }
    }

    func isMain() {
        deleteButton.isHidden = false
    }

    func isNotMain() {
        deleteButton.isHidden = true
    }

    func tapSharedButton() {
    }

    func deleteButtonTap() {
        delegate?.deleteReview(indexRow: indexRow)
    }

    static var reuseIdentifier: String {
        return "ReviewsCell"
    }
}
