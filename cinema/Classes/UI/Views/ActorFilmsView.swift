//
//  ActorFilmView.swift
//  cinema
//
//  Created by iOS on 29.11.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

protocol ActorFilmsViewDelegate: class {
    func openFilmID(_ film: String, name: String)
}

class ActorFilmsView: UIView {

    weak var delegate: ActorFilmsViewDelegate?

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.cnmFuturaBold(size: 16)
        label.textColor = UIColor.setColorGray(white: 58)
        label.textAlignment = .left
        label.text = L10n.personFilmsText
        return label
    }()

    let windowWidth = (UIWindow(frame: UIScreen.main.bounds).bounds.width - 40) / 3

    fileprivate let collectionView: UICollectionView = {

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 13
        layout.minimumLineSpacing = 13
        layout.sectionInset = UIEdgeInsets(top: 0, left: 41, bottom: 0, right: 41)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(FilmsCollectionCell.self, forCellWithReuseIdentifier: FilmsCollectionCell.reuseIdentifier)
        collectionView.scrollsToTop = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white

        return collectionView
    }()

    var films: [FilmFromPerson] = []

    required init(coder _: NSCoder) {
        fatalError("NSCoding not supported")
    }

    init(films: [FilmFromPerson]) {
        super.init(frame: .zero)

        addSubview(titleLabel.prepareForAutoLayout())
        titleLabel.topAnchor ~= topAnchor
        titleLabel.leadingAnchor ~= leadingAnchor + 41
        titleLabel.trailingAnchor ~= trailingAnchor - 41

        addSubview(collectionView.prepareForAutoLayout())
        collectionView.topAnchor ~= titleLabel.bottomAnchor + 15
        collectionView.leadingAnchor ~= leadingAnchor
        collectionView.trailingAnchor ~= trailingAnchor
        collectionView.bottomAnchor ~= bottomAnchor
        collectionView.heightAnchor ~= windowWidth / 3 * 4
        collectionView.delegate = self
        collectionView.dataSource = self
        self.films = films
        collectionView.reloadData()
    }

}

extension ActorFilmsView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: windowWidth, height: windowWidth / 3 * 4)
    }
}

extension ActorFilmsView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            delegate?.openFilmID(films[indexPath.row].id, name: films[indexPath.row].name)
    }
}

extension ActorFilmsView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return films.count
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilmsCollectionCell.reuseIdentifier, for: indexPath)

        if let tagCell = cell as? FilmsCollectionCell {
            tagCell.linkUrlImage = films[indexPath.row].imageUrl
        }
        return cell
    }
}
