//
//  NewsCell.swift
//  cinema
//
//  Created by User on 16.11.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

// MARK: - NewsFilterCell

protocol NewsCellDelegate: class {
    func openShareSimple(news: News)
}

class NewsCell: UITableViewCell {

    var news: News?

    weak var delegate: NewsCellDelegate?

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.cnmFutura(size: 19)
        label.textColor = UIColor.cnmBlueLight
        label.numberOfLines = 2
        return label
    }()

    private let newsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.cnmFuturaLight(size: 14)
        label.textColor = UIColor.cnm3a3a3a
        label.numberOfLines = 4
        label.lineBreakMode = .byTruncatingTail
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

        mainView.addSubview(titleLabel.prepareForAutoLayout())
        titleLabel.topAnchor ~= userImage.bottomAnchor + 9
        titleLabel.leadingAnchor ~= mainView.leadingAnchor
        titleLabel.trailingAnchor ~= mainView.trailingAnchor

        mainView.addSubview(newsLabel.prepareForAutoLayout())
        newsLabel.topAnchor ~= titleLabel.bottomAnchor + 14
        newsLabel.leadingAnchor ~= mainView.leadingAnchor
        newsLabel.trailingAnchor ~= mainView.trailingAnchor
        newsLabel.sizeToFit()
        newsLabel.bottomAnchor ~= mainView.bottomAnchor

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

    func setNews(_ news: News) {
        self.news = news
        infoLabel.text = news.creator.name + ", " + news.createdAt.hourMinutes + ", " + news.createdAt.monthMedium
        userImage.kf.setImage(with: URL(string: news.creator.avatar))
        titleLabel.text = news.name
        newsLabel.text = news.description
        countLabel.text = String(news.shared)
    }

    func tapSharedButton() {
        if let newShare = news {
            delegate?.openShareSimple(news: newShare)
        }
    }

    static var reuseIdentifier: String {
        return "NewsCell"
    }
}
