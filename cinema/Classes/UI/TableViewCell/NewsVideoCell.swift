//
//  NewsVideoCell.swift
//  cinema
//
//  Created by User on 16.11.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

// MARK: - NewsVideoCell

class NewsVideoCell: UITableViewCell {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.cnmFutura(size: 20)
        label.textColor = .white
        label.numberOfLines = 1
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
        imageView.contentMode = .scaleAspectFill
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
        newsImage.heightAnchor ~= windowWidth / 320 * 175

        let shareButton = UIButton()
        shareButton.setImage(Asset.Cinema.sharingOrange.image, for: .normal)

        newsImage.addSubview(shareButton.prepareForAutoLayout())
        shareButton.leadingAnchor ~= newsImage.leadingAnchor + 5
        shareButton.widthAnchor ~= 20
        shareButton.heightAnchor ~= 22
        shareButton.bottomAnchor ~= newsImage.bottomAnchor - 5

        newsImage.addSubview(countLabel.prepareForAutoLayout())
        countLabel.centerYAnchor ~= shareButton.centerYAnchor
        countLabel.leadingAnchor ~= shareButton.trailingAnchor + 6

        let imageTime = UIImageView(image: Asset.Cinema.timeOrange.image)
        newsImage.addSubview(imageTime.prepareForAutoLayout())

        imageTime.centerYAnchor ~= shareButton.centerYAnchor
        imageTime.leadingAnchor ~= countLabel.trailingAnchor + 15
        imageTime.heightAnchor ~= 21
        imageTime.widthAnchor ~= 21

        newsImage.addSubview(infoLabel.prepareForAutoLayout())
        infoLabel.centerYAnchor ~= shareButton.centerYAnchor
        infoLabel.leadingAnchor ~= imageTime.trailingAnchor + 9
    }

    func setNews(_ news: News) {

    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    func tapSharedButton() {

    }

    static var reuseIdentifier: String {
        return "NewsVideoCell"
    }
}
