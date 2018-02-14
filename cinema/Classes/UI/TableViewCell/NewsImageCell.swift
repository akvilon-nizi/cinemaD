//
//  NewsImageCell.swift
//  cinema
//
//  Created by User on 16.11.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

// MARK: - NewsImageCell

protocol NewsImageCellDelegate: class {
    func openShare(image: UIImage?, news: News)
}

class NewsImageCell: UITableViewCell {

    var news: News?

    weak var delegate: NewsImageCellDelegate?

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.cnmFutura(size: 19)
        label.textColor = .white
        label.numberOfLines = 0
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
            titleLabel.text = ""
            infoLabel.text = ""
            countLabel.text = ""
            newsImage.kf.indicatorType = .activity
            newsImage.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w640/cDgrrQnCmC6kqUGaFZmK7DmsE7.jpg"))
        }
    }

    let windowWidth = UIWindow(frame: UIScreen.main.bounds).bounds.width - 59

    required init?(coder _: NSCoder) {
        fatalError("NSCoding not supported")
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none

        contentView.backgroundColor = .white

        contentView.heightAnchor ~= windowWidth / 320 * 131 + 10    

        let mainView = UIView()
        contentView.addSubview(mainView.prepareForAutoLayout())
        mainView.topAnchor ~= contentView.topAnchor + 5
        mainView.leadingAnchor ~= contentView.leadingAnchor + 29
        mainView.trailingAnchor ~= contentView.trailingAnchor - 30
       // mainView.bottomAnchor ~= contentView.bottomAnchor - 5

        mainView.addSubview(newsImage.prepareForAutoLayout())
        newsImage.pinEdgesToSuperviewEdges()
        newsImage.heightAnchor ~= windowWidth / 320 * 131
        newsImage.kf.indicatorType = .activity

        let shareButton = UIButton()
        shareButton.setImage(Asset.Cinema.sharingOrange.image, for: .normal)

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
        titleLabel.trailingAnchor ~= mainView.trailingAnchor - 10
    }

    func setNews(_ news: News) {

//        DispatchQueue.global(qos: .background).async {
//            //let attrString = news.description.htmlAttributedString(font: assa!)
            DispatchQueue.main.async {
                if let cover = news.cover {
                    self.newsImage.kf.setImage(with: URL(string: cover))
                }
                if let imageUrl = news.imageUrl {
                    self.newsImage.kf.setImage(with: URL(string: imageUrl))
                }
                self.news = news
                self.infoLabel.text = news.createdAt.hourMinutes + ", " + news.createdAt.monthMedium
                self.titleLabel.text = news.name
                self.countLabel.text = String(news.shared)
            }
//        }

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
