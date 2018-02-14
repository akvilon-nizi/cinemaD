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
        didSet {
             collectionView.reloadData()
        }
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    var scrollItem: Int = 0

    var beginContentOffsetX: CGFloat = -30.0

    let windowY = UIWindow(frame: UIScreen.main.bounds).frame.width - 30
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
        collectionView.allowsSelection = true
        collectionView.reloadData()

    }
}

extension MainVCHeader: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: windowWidth, height: windowWidth / 16 * 9)
    }
}

extension MainVCHeader: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? YoutubeViewCell {
            cell.playVideo()
        }
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
            tagCell.loadPlayer()
        }
        return cell
    }
}

extension MainVCHeader: UIScrollViewDelegate {
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        collectionView.isScrollEnabled = false
        beginContentOffsetX = CGFloat(scrollItem) * windowY
            scrollView.setContentOffset(CGPoint(x: CGFloat(scrollItem) * windowY, y: 0), animated: true)
        collectionView.isScrollEnabled = true
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let actualPosition = scrollView.panGestureRecognizer.translation(in: scrollView.superview)

        var isScroll = false

        if actualPosition.x > 0 && scrollView.contentOffset.x != 0 {
            let newItem = scrollItem - 1
            scrollItem = newItem >= 0 ? newItem : scrollItem
            isScroll = true
        } else {
            isScroll = true
            let newItem = scrollItem + 1
            scrollItem = newItem < trailers.count ? newItem : scrollItem
        }

        collectionView.isScrollEnabled = false
        beginContentOffsetX = CGFloat(scrollItem) * windowY
        if isScroll {
            scrollView.setContentOffset(CGPoint(x: CGFloat(scrollItem) * windowY, y: 0), animated: true)
        }
        collectionView.isScrollEnabled = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            for colCell in self.collectionView.visibleCells {
                if let cell = colCell as? YoutubeViewCell {
                    cell.pauseVideo()
                }
            }
        }
    }
}
