//
//  RolesCV.swift
//  cinema
//
//  Created by User on 19.10.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

//protocol FilmGroupDelegate: class {
//    func openFilmID(_ filmID: String, name: String)
//}

class RolesCV: UITableViewHeaderFooterView {
    let titleLabel: UILabel = UILabel()

    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    var persons: [PersonFromFilm] = [] {
        didSet {
            collectionView.reloadData()
        }
    }

//    weak var delegate: FilmGroupDelegate?

    fileprivate let collectionView: UICollectionView = {

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 25
        layout.minimumLineSpacing = 25
        layout.sectionInset = UIEdgeInsets(top: 0, left: 36, bottom: 0, right: 36)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(RolesCell.self, forCellWithReuseIdentifier: RolesCell.reuseIdentifier)
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

extension RolesCV: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 56, height: 150)
    }
}

extension RolesCV: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        delegate?.openFilmID(films[indexPath.row].id, name: films[indexPath.row].name)
    }
}

extension RolesCV: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return persons.count
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RolesCell.reuseIdentifier, for: indexPath)

        if let tagCell = cell as? RolesCell {
            if let imageUrl = persons[indexPath.row].imageUrl {
                tagCell.linkUrlImage = imageUrl
            } else {
                tagCell.linkUrlImage = ""
            }
            tagCell.role = persons[indexPath.row].relation
            tagCell.name = persons[indexPath.row].name
        }
        return cell
    }
}
