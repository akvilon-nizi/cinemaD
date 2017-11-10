//
//  FilmGroup.swift
//  cinema
//
//  Created by User on 11.10.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

protocol FilmGroupDelegate: class {
    func openFilmID(_ filmID: String, name: String)
}

class FilmGroup: UITableViewHeaderFooterView {
    let titleLabel: UILabel = UILabel()

    var isCollections: Bool = false
    var isAdd: Bool = false

    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    var films: [Film] = [] {
        didSet {
            collectionView.reloadData()
        }
    }

    weak var delegate: FilmGroupDelegate?

    let windowWidth = (UIWindow(frame: UIScreen.main.bounds).bounds.width - 40) / 3

    fileprivate let collectionView: UICollectionView = {

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 13
        layout.minimumLineSpacing = 13
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
        if isCollections {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilmsCollectionCell.reuseIdentifier, for: indexPath)

            if let tagCell = cell as? FilmsCollectionCell {
                if isAdd {
                    films[indexPath.row].add = !films[indexPath.row].add
                } else {
                    films[indexPath.row].delete = !films[indexPath.row].delete
                }
               collectionView.reloadItems(at: [indexPath])
            }
        } else {
            delegate?.openFilmID(films[indexPath.row].id, name: films[indexPath.row].name)
        }
    }
}

extension FilmGroup: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return films.count
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilmsCollectionCell.reuseIdentifier, for: indexPath)

        if let tagCell = cell as? FilmsCollectionCell {
            tagCell.linkUrlImage = films[indexPath.row].imageUrl
            if let rate = films[indexPath.row].rate, rate > 0 {
                tagCell.setRating(rate)
            }
            if isCollections {
                tagCell.isCollections()
                tagCell.isAdd = isAdd
                if films[indexPath.row].delete || films[indexPath.row].add {
                    tagCell.isCheck = true
                }
            }
        }
        return cell
    }
}
