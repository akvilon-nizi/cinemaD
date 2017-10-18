//
//  MainVCHeader.swift
//  cinema
//
//  Created by User on 09.10.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

class MainVCHeader: UITableViewHeaderFooterView {
    let titleLabel: UILabel = UILabel()

    var trailers: [String] = [] {
        didSet{
             collectionView.reloadData()
        }
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    let windowWidth = UIWindow(frame: UIScreen.main.bounds).bounds.width - 60

    fileprivate let collectionView: UICollectionView = {

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 30
        layout.minimumLineSpacing = 30
        layout.sectionInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(YoutubeViewCell.self, forCellWithReuseIdentifier: YoutubeViewCell.reuseIdentifier)
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

extension MainVCHeader: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: windowWidth, height: windowWidth / 4 * 3)
    }
}

extension MainVCHeader: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}

extension MainVCHeader: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trailers.count
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: YoutubeViewCell.reuseIdentifier, for: indexPath)

        if let tagCell = cell as? YoutubeViewCell {
            tagCell.idVideo = trailers[indexPath.row]
//            print("assa", indexPath.row, trailers[indexPath.row] )
            tagCell.loadPlayer()
        }
        return cell
    }
}