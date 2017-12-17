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

    var film: FullFilm?

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

    let likedView = LikedView(isLike: true)

    let dislikedView = LikedView(isLike: false)

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

        let buttonsStack = createStackView(.horizontal, .fill, .fill, 1, with: [likedView, separatorView, dislikedView])
        addSubview(buttonsStack.prepareForAutoLayout())
        buttonsStack.centerXAnchor ~= centerXAnchor
        buttonsStack.topAnchor ~= genresLabel.bottomAnchor + 24
        buttonsStack.bottomAnchor ~= bottomAnchor

        likedView.delegate = self
        dislikedView.delegate = self
    }

    func setParameters(film: FullFilm) {
        self.film = film
        titleLabel.text = film.name
        var textsArray: [String] = []
        for genres in film.genres {
            if let text = genres.name, !text.isEmpty {
                textsArray.append(text.capitalized)
            }
        }

        likedView.count = film.liked
        dislikedView.count = film.notLiked

        genresLabel.text = textsArray.joined(separator: "/")
        if let iLiked = film.iLiked {
            if iLiked {
                likedView.didSelect = true
                dislikedView.didSelect = false
            } else {
                likedView.didSelect = false
                dislikedView.didSelect = true
            }
        }
    }
}

extension ReviewsHeaderView: LikedViewDelegate {
    func changeStatus(isLike: Bool, isSelect: Bool) {
        guard let filmInfo = film else {
            return
        }
        if isLike {
            if isSelect {
                delegate?.selectLike()
                filmInfo.liked += 1
                filmInfo.iLiked = true
                if dislikedView.didSelect {
                    filmInfo.notLiked -= 1
                    dislikedView.didSelect = false
                    dislikedView.count = filmInfo.notLiked
                }
            } else {
                delegate?.unselectLike()
                filmInfo.liked -= 1
                filmInfo.iLiked = nil
            }
        } else {
            if isSelect {
                delegate?.selectDislike()
                filmInfo.notLiked += 1
                filmInfo.iLiked = false
                if likedView.didSelect {
                    filmInfo.liked -= 1
                    likedView.didSelect = false
                    likedView.count = filmInfo.liked
                }
            } else {
                delegate?.unselectDislike()
                filmInfo.notLiked -= 1
                filmInfo.iLiked = nil
            }
        }
    }
}
