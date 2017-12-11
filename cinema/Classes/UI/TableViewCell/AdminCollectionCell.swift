//
//  CollectionCell.swift
//  cinema
//
//  Created by iOS on 11.12.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

// MARK: - CollectionCell

class AdminCollectionCell: UITableViewCell {

    var news: News?

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.cnmFutura(size: 19)
        label.textColor = .white
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        return label
    }()

    private let infoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.cnmFuturaLight(size: 12)
        label.textColor = .white
        label.numberOfLines = 1
        return label
    }()

    private let countLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.cnmFuturaLight(size: 12)
        label.textColor = .white
        label.numberOfLines = 1
        return label
    }()

    private let newsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.cnm3a3a3a
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleToFill
        return imageView
    }()

    var title: String = "" {
        didSet {
            titleLabel.text = "Какой-то заголовок"
            infoLabel.text = "sakdflsa, sdsadf,, sdf"
            countLabel.text = "3"
            newsImage.kf.indicatorType = .activity
            newsImage.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w640/cDgrrQnCmC6kqUGaFZmK7DmsE7.jpg"))
            //            newsLabel.layoutIfNeeded()
            //            layoutIfNeeded()
            //            layoutSubviews()
        }
    }

    let windowWidth = UIWindow(frame: UIScreen.main.bounds).bounds.width - 58

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
        mainView.topAnchor ~= contentView.topAnchor + 5
        mainView.leadingAnchor ~= contentView.leadingAnchor + 29
        mainView.trailingAnchor ~= contentView.trailingAnchor - 30
        mainView.bottomAnchor ~= contentView.bottomAnchor - 5

        mainView.addSubview(newsImage.prepareForAutoLayout())
        newsImage.pinEdgesToSuperviewEdges()
        newsImage.heightAnchor ~= windowWidth / 320 * 131

        let shareButton = UIButton()
        shareButton.setImage(Asset.Cinema.sharingOrange.image, for: .normal)
        //shareButton.addTarget(self, action: #selector(tapSharedButtons), for: .touchUpInside)

        //        mainView.addSubview(shareButton.prepareForAutoLayout())
        //        shareButton.leadingAnchor ~= mainView.leadingAnchor + 5
        //        shareButton.widthAnchor ~= 20
        //        shareButton.heightAnchor ~= 22
        //        shareButton.bottomAnchor ~= newsImage.bottomAnchor - 5
        //
        //        mainView.addSubview(countLabel.prepareForAutoLayout())
        //        countLabel.centerYAnchor ~= shareButton.centerYAnchor
        //        countLabel.leadingAnchor ~= shareButton.trailingAnchor + 6

        let imageTime = UIImageView(image: Asset.Cinema.timeOrange.image)
        mainView.addSubview(imageTime.prepareForAutoLayout())

        imageTime.leadingAnchor ~= mainView.leadingAnchor + 5
        imageTime.bottomAnchor ~= newsImage.bottomAnchor - 5
        imageTime.heightAnchor ~= 21
        imageTime.widthAnchor ~= 21

        mainView.addSubview(infoLabel.prepareForAutoLayout())
        infoLabel.centerYAnchor ~= imageTime.centerYAnchor
        infoLabel.leadingAnchor ~= imageTime.trailingAnchor + 9

        mainView.addSubview(titleLabel.prepareForAutoLayout())
        titleLabel.bottomAnchor ~= imageTime.topAnchor - 9
        titleLabel.leadingAnchor ~= imageTime.leadingAnchor
        //        let separatorView = UIView()
        //        separatorView.backgroundColor = .cnmDadada
        //        contentView.addSubview(separatorView.prepareForAutoLayout())
        //        separatorView.bottomAnchor ~= contentView.bottomAnchor
        //        separatorView.trailingAnchor ~= contentView.trailingAnchor - 24
        //        separatorView.leadingAnchor ~= contentView.leadingAnchor + 24
        //        separatorView.heightAnchor ~= 1
        //        separatorView.topAnchor ~= mainView.bottomAnchor + 20
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    func setNews(_ news: News) {
        self.news = news
        infoLabel.text = news.createdAt.hourMinutes + ", " + news.createdAt.monthMedium
        titleLabel.text = news.name
        countLabel.text = String(news.shared)
        if let cover = news.cover {
            newsImage.kf.setImage(with: URL(string: cover))
        }
        if let imageUrl = news.imageUrl {
            newsImage.kf.setImage(with: URL(string: imageUrl))
        }
    }

    func tapSharedButtons() {
        if let newShare = news {
            delegate?.openShare(image: newsImage.image, news: newShare)
        }
    }

    static var reuseIdentifier: String {
        return "NewsImageCell"
    }
}
