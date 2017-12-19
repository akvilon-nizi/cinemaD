//
//  NewFriendsView.swift
//  cinema
//
//  Created by iOS on 19.12.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit
import RxSwift

class FriendsNewsData {
    let imageUrl: String?
    let name: String
    init(imageUrl: String?, name: String) {
        self.imageUrl = imageUrl
        self.name = name
    }
}

class NewFriendsView: UIView {

    var persons: [FriendsNewsData] = [] {
        didSet {
            collectionView.reloadData()
        }
    }

    fileprivate let collectionView: UICollectionView = {

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 25
        layout.minimumLineSpacing = 25
        layout.sectionInset = UIEdgeInsets(top: 0, left: 36, bottom: 0, right: 36)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(NewFriendsCell.self, forCellWithReuseIdentifier: NewFriendsCell.reuseIdentifier)
        collectionView.scrollsToTop = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white

        return collectionView
    }()

    required init(coder _: NSCoder) {
        fatalError("NSCoding not supported")
    }

    init() {
        super.init(frame: .zero)
        addSubview(collectionView.prepareForAutoLayout())
        collectionView.pinEdgesToSuperviewEdges()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
    }

}

extension NewFriendsView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 88, height: 110)
    }
}

extension NewFriendsView: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        delegate?.openPersonID(persons[indexPath.row].id, name: persons[indexPath.row].name, role: persons[indexPath.row].relation)
//    }
}

extension NewFriendsView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return persons.count
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewFriendsCell.reuseIdentifier, for: indexPath)

        if let tagCell = cell as? NewFriendsCell {
            if let imageUrl = persons[indexPath.row].imageUrl {
                tagCell.linkUrlImage = imageUrl
            } else {
                tagCell.linkUrlImage = ""
            }
            tagCell.name = persons[indexPath.row].name
        }
        return cell
    }
}
