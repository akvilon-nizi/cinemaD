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
        label.numberOfLines = 1
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

    private var contentHeight: NSLayoutConstraint?

    private let width = UIWindow(frame: UIScreen.main.bounds).frame.width - 61

    required init?(coder _: NSCoder) {
        fatalError("NSCoding not supported")
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none

        contentView.backgroundColor = .white

        contentHeight = contentView.heightAnchor.constraint(equalToConstant: 191)
        contentHeight?.isActive = true

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
        newsLabel.bottomAnchor ~= mainView.bottomAnchor

        let separatorView = UIView()
        separatorView.backgroundColor = .cnmDadada
        contentView.addSubview(separatorView.prepareForAutoLayout())
        separatorView.bottomAnchor ~= contentView.bottomAnchor
        separatorView.trailingAnchor ~= contentView.trailingAnchor - 24
        separatorView.leadingAnchor ~= contentView.leadingAnchor + 24
        separatorView.heightAnchor ~= 1
        //separatorView.topAnchor ~= mainView.bottomAnchor + 20
    }

    func setNews(_ news: News) {

        //newsLabel.text = news.description

        let assa = self.newsLabel.font
//        self.contentHeight?.constant = 191 - 25 + news.name.heightWithConstrainedWidth(width: width, font: self.titleLabel.font)
//        UIView.animate(withDuration: 0, animations: {
//            self.contentView.layoutIfNeeded()
//            self.layoutIfNeeded()
//        })
        DispatchQueue.global(qos: .background).async {
            let attrString = news.description.htmlAttributedString(font: assa!)
            DispatchQueue.main.async {
                self.newsLabel.attributedText = attrString
                //self.newsLabel.text = "dsffds"
                self.news = news
                self.infoLabel.text = news.creator.name + ", " + news.createdAt.hourMinutes + ", " + news.createdAt.monthMedium
                self.userImage.kf.setImage(with: URL(string: news.creator.avatar))
                self.titleLabel.text = news.name
                self.countLabel.text = String(news.shared)
            }
        }
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

extension String {
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSFontAttributeName: font], context: nil)
        return boundingBox.height
    }
}
