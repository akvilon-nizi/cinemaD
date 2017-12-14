//
//  ReviewsHeaderView.swift
//  cinema
//
//  Created by iOS on 29.11.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

protocol ReviewsHeaderViewDelegate: class {
    func selectLike()
    func unselectLike()
    func selectDislike()
    func unselectDislike()
}

class ReviewsHeaderView: UITableViewHeaderFooterView {

    weak var delegate: ReviewsHeaderViewDelegate?

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.cnmFuturaBold(size: 20)
        label.textColor = UIColor.setColorGray(white: 45)
        return label
    } ()

    let genresLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.cnmFuturaLight(size: 14)
        label.textColor = UIColor.setColorGray(white: 175)
        return label
    } ()

    let willWatchButton: UIButton = {
        let button = UIButton()
        button.setTitle(L10n.reviewsDislikeText, for: .normal)
        button.setTitleColor(UIColor.cnmAfafaf, for: .normal)
        button.setTitleColor(UIColor.cnmMainOrange, for: .selected)
        button.titleLabel?.font = UIFont.cnmFuturaLight(size: 16)
        button.heightAnchor ~= 33
        button.tag = 1
        button.widthAnchor ~= (UIWindow(frame: UIScreen.main.bounds).bounds.width - 1) / 2
        return button
    }()

    let watchedButton: UIButton = {
        let button = UIButton()
        button.setTitle(L10n.reviewsLikeText, for: .normal)
        button.setTitleColor(UIColor.cnmAfafaf, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(UIColor.cnmMainOrange, for: .selected)
        button.titleLabel?.font = UIFont.cnmFuturaLight(size: 16)
        button.heightAnchor ~= 33
        button.widthAnchor ~= (UIWindow(frame: UIScreen.main.bounds).bounds.width - 1) / 2
        return button
    }()

    let separatorView: UIView = {
        let view = UIView()
        view.heightAnchor ~= 33
        view.widthAnchor ~= 1
        view.backgroundColor = UIColor.cnmAfafaf
        return view
    }()

    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    let windowWidth = UIWindow(frame: UIScreen.main.bounds).bounds.width - 60

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        addSubview(titleLabel.prepareForAutoLayout())
        titleLabel.topAnchor ~= topAnchor
        titleLabel.centerXAnchor ~= centerXAnchor

        addSubview(genresLabel.prepareForAutoLayout())
        genresLabel.topAnchor ~= titleLabel.bottomAnchor
        genresLabel.centerXAnchor ~= centerXAnchor

        willWatchButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        watchedButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)

        let buttonsStack = createStackView(.horizontal, .fill, .fill, 1, with: [watchedButton, separatorView, willWatchButton])
        addSubview(buttonsStack.prepareForAutoLayout())
        buttonsStack.centerXAnchor ~= centerXAnchor
        buttonsStack.topAnchor ~= genresLabel.bottomAnchor + 24
        buttonsStack.bottomAnchor ~= bottomAnchor
    }

    func setParameters(film: FullFilm) {
        titleLabel.text = film.name
        var textsArray: [String] = []
        for genres in film.genres {
            if let text = genres.name, !text.isEmpty {
                textsArray.append(text.capitalized)
            }
        }

        genresLabel.text = textsArray.joined(separator: "/")
        if let iLiked = film.iLiked {
            if iLiked {
                watchedButton.isSelected = true
            } else {
                willWatchButton.isSelected = true
            }
        }
    }

    func tapButton(button: UIButton) {
        if button.tag == 0 {
            watchedButton.isSelected = !watchedButton.isSelected
            if watchedButton.isSelected {
                willWatchButton.isSelected = false
                delegate?.selectLike()
            } else {
                delegate?.unselectLike()
            }
        } else {
             willWatchButton.isSelected = !willWatchButton.isSelected
            if willWatchButton.isSelected {
                watchedButton.isSelected = false
                delegate?.selectDislike()
            } else {
                delegate?.unselectDislike()
            }
        }
    }
}
