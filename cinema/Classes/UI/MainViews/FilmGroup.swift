//
//  FilmGroup.swift
//  cinema
//
//  Created by User on 11.10.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

class FilmGroup: UITableViewHeaderFooterView {
    let titleLabel: UILabel = UILabel()

    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    let windowWidth = (UIWindow(frame: UIScreen.main.bounds).bounds.width - 60) / 2

    fileprivate let collectionView: UICollectionView = {

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 30
        layout.minimumLineSpacing = 30
        layout.sectionInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(FilmsCollectionCell.self, forCellWithReuseIdentifier: FilmsCollectionCell.reuseIdentifier)
        collectionView.scrollsToTop = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white

        return collectionView
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addSubview(collectionView.prepareForAutoLayout())
        collectionView.pinEdgesToSuperviewEdges()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
    }
}

extension FilmGroup: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: windowWidth, height: windowWidth / 3 * 4)
    }
}

extension FilmGroup: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}

extension FilmGroup: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilmsCollectionCell.reuseIdentifier, for: indexPath)

        if let tagCell = cell as? FilmsCollectionCell {
            tagCell.linkUrlImage = indexPath.row % 2 == 0
        }
        return cell
    }
}
