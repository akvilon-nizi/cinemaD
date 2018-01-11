//
//  ImageNewsHeader.swift
//  cinema
//
//  Created by User on 17.11.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit
import ImageSlideshow
import Kingfisher
//import AVFoundation

protocol ImageNewsHeaderDelegate: class {
    func openShare(image: UIImage?)
}

class ImageNewsHeader: UITableViewHeaderFooterView {
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

    weak var delegate: ImageNewsHeaderDelegate?

    private let newsImage = ImageSlideshow()

    private let newsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.cnmFuturaLight(size: 14)
        label.textColor = UIColor.cnm3a3a3a
        label.numberOfLines = 0
        return label
    }()

    let windowWidth = UIWindow(frame: UIScreen.main.bounds).bounds.width

    var image: UIImage?

    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        contentView.backgroundColor = .white

        //autoresizesSubviews = true

//        let videoURL = URL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
//        let player = AVPlayer(url: videoURL!)
//        let playerLayer = AVPlayerLayer(player: player)
//        playerLayer.frame = CGRect(x: 0, y: 0, width: 320, height: 200)
//        contentView.layer.addSublayer(playerLayer)
//        player.play()
//
//        contentView.heightAnchor ~= 320

        let mainView = UIView()
        contentView.addSubview(mainView.prepareForAutoLayout())
        mainView.topAnchor ~= contentView.topAnchor + 5
        mainView.leadingAnchor ~= contentView.leadingAnchor
        mainView.trailingAnchor ~= contentView.trailingAnchor

        mainView.addSubview(newsImage.prepareForAutoLayout())
        newsImage.pinEdgesToSuperviewEdges()
        newsImage.heightAnchor ~= windowWidth / 375 * 131
//        newsImage.topAnchor ~= mainView.topAnchor
//        newsImage.bottomAnchor ~= mainView.bottomAnchor
//        newsImage.centerXAnchor ~= mainView.centerXAnchor
//        newsImage.widthAnchor ~= windowWidth - 55
//        newsImage.heightAnchor ~= windowWidth / 320 * 131
//        newsImage.layer.cornerRadius = 5.0
//        newsImage.layer.masksToBounds = true

        let shareButton = UIButton()
        shareButton.setImage(Asset.Cinema.sharingOrange.image, for: .normal)
        shareButton.addTarget(self, action: #selector(tapSharedButton), for: .touchUpInside)

        newsImage.addSubview(shareButton.prepareForAutoLayout())
        shareButton.leadingAnchor ~= newsImage.leadingAnchor + 35
        shareButton.widthAnchor ~= 20
        shareButton.heightAnchor ~= 22
        shareButton.bottomAnchor ~= newsImage.bottomAnchor - 10

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

        newsImage.addSubview(titleLabel.prepareForAutoLayout())
        titleLabel.bottomAnchor ~= shareButton.topAnchor - 9
        titleLabel.leadingAnchor ~= shareButton.leadingAnchor

        mainView.addSubview(newsLabel.prepareForAutoLayout())
        newsLabel.topAnchor ~= newsImage.bottomAnchor + 35
        newsLabel.leadingAnchor ~= mainView.leadingAnchor + 35
        newsLabel.trailingAnchor ~= mainView.trailingAnchor - 35

        let separatorView = UIView()
        separatorView.backgroundColor = .cnmDadada
        contentView.addSubview(separatorView.prepareForAutoLayout())
        separatorView.bottomAnchor ~= contentView.bottomAnchor
        separatorView.trailingAnchor ~= contentView.trailingAnchor - 24
        separatorView.leadingAnchor ~= contentView.leadingAnchor + 24
        separatorView.heightAnchor ~= 1
        separatorView.topAnchor ~= newsLabel.bottomAnchor + 24
    }

    func setNews(_ news: News) {
        infoLabel.text = news.createdAt.hourMinutes + ", " + news.createdAt.monthMedium
        titleLabel.text = news.name
        countLabel.text = String(news.shared)
        newsLabel.text = news.description

        var imageLink: String = ""

        if let cover = news.cover {
            if let attached = news.attached, !attached.isEmpty {
                var imageArray: [KingfisherSource] = []
                for imageUrl in attached {
                    imageArray.append(KingfisherSource(urlString: imageUrl)!)
                }
                newsImage.setImageInputs(imageArray)
                newsImage.contentScaleMode = .scaleToFill
                newsImage.slideshowInterval = 3.0
                newsImage.draggingEnabled = false
                newsImage.pageControlPosition = .hidden
                newsImage.activityIndicator = DefaultActivityIndicator()
            } else {
                newsImage.setImageInputs([
                    KingfisherSource(urlString: cover)!
                    ])
                newsImage.contentScaleMode = .scaleToFill
                newsImage.activityIndicator = DefaultActivityIndicator()
            }

            imageLink = cover
        }
        if let imageUrl = news.imageUrl {
            newsImage.setImageInputs([
                KingfisherSource(urlString: imageUrl)!
            ])
             newsImage.contentScaleMode = .scaleToFill
            newsImage.activityIndicator = DefaultActivityIndicator()
            imageLink = imageUrl
        }

        if let link = URL(string: imageLink) {
            KingfisherManager.shared.retrieveImage(with: link, options: nil, progressBlock: nil, completionHandler: {[weak self] image, _, _, _ in
                if let loadImage = image {
                    self?.image = loadImage
                }
            })
        }

    }

    func tapSharedButton() {
        delegate?.openShare(image: self.image)
    }
}
