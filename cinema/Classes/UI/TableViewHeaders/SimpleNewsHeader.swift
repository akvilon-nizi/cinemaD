//
//  SimpleNewsHeader.swift
//  cinema
//
//  Created by User on 17.11.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit
import Foundation
import RxSwift

protocol SimpleNewsHeaderDelegate: class {
    func openShareSimple()
    func reloadHeaderSimpler()
}

class SimpleNewsHeader: UITableViewHeaderFooterView {

    weak var delegate: SimpleNewsHeaderDelegate?

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.cnmFutura(size: 19)
        label.textColor = UIColor.cnmBlueLight
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    private let newsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.cnmFuturaLight(size: 14)
        label.textColor = UIColor.cnm3a3a3a
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

    private let userImage: UIImageView = {
        let imageView = UIImageView()
        imageView.heightAnchor ~= 23
        imageView.widthAnchor ~= 23
        imageView.backgroundColor = UIColor.cnm3a3a3a
        imageView.layer.cornerRadius = 23 / 2
        return imageView
    }()

    let disposeBag = DisposeBag()

    var contentOffset: CGPoint = CGPoint(x: 0, y: 0)

    let webView = UIWebView()

    var webViewHight: NSLayoutConstraint?

    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        contentView.backgroundColor = .white

        autoresizesSubviews = true

        let mainView = UIView()
        contentView.addSubview(mainView.prepareForAutoLayout())
        mainView.topAnchor ~= contentView.topAnchor + 19
        mainView.leadingAnchor ~= contentView.leadingAnchor + 34
        mainView.trailingAnchor ~= contentView.trailingAnchor - 27

        mainView.addSubview(infoLabel.prepareForAutoLayout())
        infoLabel.topAnchor ~= mainView.topAnchor
        infoLabel.leadingAnchor ~= mainView.leadingAnchor

        mainView.addSubview(titleLabel.prepareForAutoLayout())
        titleLabel.topAnchor ~= infoLabel.bottomAnchor + 12
        titleLabel.leadingAnchor ~= mainView.leadingAnchor
        titleLabel.trailingAnchor ~= mainView.trailingAnchor

        mainView.addSubview(webView.prepareForAutoLayout())
        webView.topAnchor ~= titleLabel.bottomAnchor + 14
        webView.leadingAnchor ~= mainView.leadingAnchor
        webView.trailingAnchor ~= mainView.trailingAnchor
        webView.delegate = self
        webView.scrollView.delegate = self
        webView.scrollView.isScrollEnabled = false
        webView.scrollView.isPagingEnabled = false
        webView.scrollView.bounces = false
        webView.scrollView.showsHorizontalScrollIndicator = false
        webView.scrollView.backgroundColor = .white
        webView.scrollView.showsVerticalScrollIndicator = false
        webView.backgroundColor = .white
        webView.isOpaque = false
        webViewHight = webView.heightAnchor.constraint(equalToConstant: 1)
        webViewHight?.isActive = true

        let shareButton = UIButton()
        shareButton.setImage(Asset.Cinema.sharing.image, for: .normal)
        shareButton.addTarget(self, action: #selector(tapSharedButton), for: .touchUpInside)

        mainView.addSubview(shareButton.prepareForAutoLayout())
        shareButton.topAnchor ~= webView.bottomAnchor + 10
        shareButton.leadingAnchor ~= mainView.leadingAnchor
        shareButton.widthAnchor ~= 20
        shareButton.heightAnchor ~= 22
        shareButton.bottomAnchor ~= mainView.bottomAnchor

        mainView.addSubview(countLabel.prepareForAutoLayout())
        countLabel.centerYAnchor ~= shareButton.centerYAnchor
        countLabel.leadingAnchor ~= shareButton.trailingAnchor + 6

        let separatorView = UIView()
        separatorView.backgroundColor = .cnmDadada
        contentView.addSubview(separatorView.prepareForAutoLayout())
        separatorView.bottomAnchor ~= contentView.bottomAnchor
        separatorView.trailingAnchor ~= contentView.trailingAnchor - 24
        separatorView.leadingAnchor ~= contentView.leadingAnchor + 24
        separatorView.heightAnchor ~= 1
        separatorView.topAnchor ~= mainView.bottomAnchor + 20
    }

    func setNews(_ news: News) {
        infoLabel.text = news.createdAt.hourMinutes + ", " + news.createdAt.monthMedium
        userImage.kf.setImage(with: URL(string: news.creator.avatar))
        titleLabel.text = news.name
        webView.loadHTMLString(String(format: "<span style=\"font-family: \(newsLabel.font.fontName); font-size: \(newsLabel.font.pointSize)\">%@</span>", news.description), baseURL: nil)
        contentOffset = webView.scrollView.contentOffset
        countLabel.text = String(news.shared)
    }

    func tapSharedButton() {
        delegate?.openShareSimple()
    }
}

extension SimpleNewsHeader: UIWebViewDelegate {
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if let link = request.url, link.absoluteString != "about:blank" {
            UIApplication.shared.open(link, options: [:], completionHandler: nil)
            return false
        } else {
            return true
        }
    }

    func webViewDidFinishLoad(_ webView: UIWebView) {
        webViewHight?.constant = webView.scrollView.contentSize.height
        delegate?.reloadHeaderSimpler()
    }
}

extension SimpleNewsHeader: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentOffset = contentOffset
        scrollView.zoomScale = 1
    }

    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        scrollView.zoomScale = 1
    }
}
