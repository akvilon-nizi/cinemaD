//
//  TabView.swift
//  foodle
//
//  Created by incetro on 11/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

// MARK: - TabViewDelegate

protocol TabViewDelegate: class {

    func currentIndexChanged(_ index: Int)
}

// MARK: - TabView

class TabView: UIView {

    weak var delegate: TabViewDelegate?

    var pageItemPressedBlock: ((_ index: Int, _ direction: UIPageViewControllerNavigationDirection) -> Void)?

    var names: [String] = [] {

        didSet {

            beforeIndex = names.count
        }
    }

    var layouted: Bool = false

    fileprivate var isInfinity: Bool
    fileprivate var option: TabPageOption
    fileprivate var beforeIndex: Int = 0
    fileprivate var currentIndex: Int = 0 {

        didSet {

            delegate?.currentIndexChanged(currentIndex)
        }
    }

    fileprivate var pageTabItemsCount: Int {
        return names.count
    }

    fileprivate var shouldScrollToItem: Bool = false
    fileprivate var pageTabItemsWidth: CGFloat = 0.0
    fileprivate var collectionViewXOffset: CGFloat = 0.0
    fileprivate var currentBarViewWidth: CGFloat = 0.0
    fileprivate var cellForSize = TabCollectionCell(frame: .zero)
    fileprivate var cachedCellSizes: [IndexPath: CGSize] = [:]
    fileprivate var barViewLeftConstraint: NSLayoutConstraint?

    private let contentView: UIView = {

        let contentView = UIView(frame: .zero)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()

    fileprivate let collectionView: UICollectionView = {

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(TabCollectionCell.self, forCellWithReuseIdentifier: TabCollectionCell.reuseIdentifier)
        collectionView.scrollsToTop = false
        collectionView.showsHorizontalScrollIndicator = false

        return collectionView
    }()

    fileprivate let currentBarView: UIView = {

        let currentBarView = UIView(frame: .zero)
        currentBarView.layer.cornerRadius = 1
        currentBarView.translatesAutoresizingMaskIntoConstraints = false
        return currentBarView
    }()

    private var barViewWidthConstraint: NSLayoutConstraint?
    private var barViewHeightConstraint: NSLayoutConstraint?

    init(isInfinity: Bool, option: TabPageOption) {

        self.option = option
        self.isInfinity = isInfinity

        super.init(frame: CGRect.zero)

        addSubview(contentView)
        contentView.addSubview(collectionView)
        contentView.addSubview(currentBarView)

        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.pinEdgesToSuperviewEdges()

        currentBarView.centerXAnchor ~= contentView.centerXAnchor
        currentBarView.bottomAnchor ~= contentView.bottomAnchor
        barViewWidthConstraint = currentBarView.widthAnchor ~= 100
        barViewWidthConstraint?.isActive = true
        barViewHeightConstraint = currentBarView.heightAnchor ~= 2
        barViewHeightConstraint?.isActive = true

        contentView.pinEdgesToSuperviewEdges()

        contentView.backgroundColor = option.tabBackgroundColor.withAlphaComponent(option.tabBarAlpha)

        currentBarView.backgroundColor = option.currentColor
        barViewHeightConstraint?.constant = option.currentBarHeight

        if !isInfinity {

            currentBarView.removeFromSuperview()
            collectionView.addSubview(currentBarView)
            currentBarView.translatesAutoresizingMaskIntoConstraints = false

            let top = currentBarView.topAnchor ~= collectionView.topAnchor + (option.tabHeight - (barViewHeightConstraint?.constant ?? 0))
            let left = currentBarView.leadingAnchor ~= collectionView.leadingAnchor

            barViewLeftConstraint = left
            collectionView.addConstraints([top, left])
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func scrollCurrentBarView(_ index: Int, contentOffsetX: CGFloat) {

        var nextIndex = isInfinity ? index + pageTabItemsCount : index

        if isInfinity && index == 0 && (beforeIndex - pageTabItemsCount) == pageTabItemsCount - 1 {

            nextIndex = pageTabItemsCount * 2

        } else if isInfinity && (index == pageTabItemsCount - 1) && (beforeIndex - pageTabItemsCount) == 0 {

            nextIndex = pageTabItemsCount - 1
        }

        if collectionViewXOffset == 0.0 {
            collectionViewXOffset = collectionView.contentOffset.x
        }

        let currentIndexPath = IndexPath(item: currentIndex, section: 0)
        let nextIndexPath = IndexPath(item: nextIndex, section: 0)

        if let currentCell = collectionView.cellForItem(at: currentIndexPath) as? TabCollectionCell,
           let nextCell = collectionView.cellForItem(at: nextIndexPath) as? TabCollectionCell {

            nextCell.hideCurrentBarView()
            currentCell.hideCurrentBarView()

            currentBarView.isHidden = false

            if currentBarViewWidth == 0.0 {
                currentBarViewWidth = currentCell.frame.width
            }

            let distance = (currentCell.frame.width / 2.0) + (nextCell.frame.width / 2.0)
            let scrollRate = contentOffsetX / frame.width

            for cell in (collectionView.visibleCells as? [TabCollectionCell]) ?? [] {

                cell.unHighlightTitle()
            }

            if fabs(scrollRate) > 0.6 {

                nextCell.highlightTitle()

            } else {

                currentCell.highlightTitle()
            }

            let width = fabs(scrollRate) * (nextCell.frame.width - currentCell.frame.width)

            if isInfinity {

                let scroll = scrollRate * distance
                collectionView.contentOffset.x = collectionViewXOffset + scroll

            } else {

                if scrollRate > 0 {

                    barViewLeftConstraint?.constant = currentCell.frame.minX + scrollRate * currentCell.frame.width

                } else {

                    barViewLeftConstraint?.constant = currentCell.frame.minX + nextCell.frame.width * scrollRate
                }
            }

            var resultWidth = currentBarViewWidth + width

            if resultWidth > max(currentCell.frame.width, nextCell.frame.width) {

                resultWidth = max(currentCell.frame.width, nextCell.frame.width)
            }

            barViewWidthConstraint?.constant = resultWidth
        }
    }

    func scrollToHorizontalCenter() {

        let indexPath = IndexPath(item: currentIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
        collectionViewXOffset = collectionView.contentOffset.x
    }

    func updateCurrentIndex(_ index: Int, shouldScroll: Bool) {

        collectionView.visibleCells.forEach {

            ($0 as? TabCollectionCell)?.unHighlightTitle()
        }

        currentIndex = isInfinity ? index + pageTabItemsCount : index
        let indexPath = IndexPath(item: currentIndex, section: 0)
        moveCurrentBarView(indexPath, animated: !isInfinity, shouldScroll: shouldScroll)
    }

    fileprivate func updateCurrentIndexForTap(_ index: Int) {

        collectionView.visibleCells.flatMap { $0 as? TabCollectionCell }.forEach { $0.isCurrent = false }

        if isInfinity && (index < pageTabItemsCount) || (index >= pageTabItemsCount * 2) {

            currentIndex = (index < pageTabItemsCount) ? index + pageTabItemsCount : index - pageTabItemsCount
            shouldScrollToItem = true

        } else {

            currentIndex = index
        }

        let indexPath = IndexPath(item: index, section: 0)
        moveCurrentBarView(indexPath, animated: true, shouldScroll: true)
    }

    fileprivate func moveCurrentBarView(_ indexPath: IndexPath, animated: Bool, shouldScroll: Bool) {

        if shouldScroll {

            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: animated)
            layoutIfNeeded()
            collectionViewXOffset = 0.0
            currentBarViewWidth = 0.0
        }

        if let cell = collectionView.cellForItem(at: indexPath) as? TabCollectionCell {

            currentBarView.isHidden = false

            if animated && shouldScroll {

                cell.isCurrent = true
            }

            cell.hideCurrentBarView()

            barViewWidthConstraint?.constant = cell.frame.width

            if !isInfinity {

                barViewLeftConstraint?.constant = cell.frame.origin.x
            }

            UIView.animate(withDuration: 0.2, animations: {

                self.layoutIfNeeded()

            }, completion: { _ in

                if !animated && shouldScroll {
                    cell.isCurrent = true
                }

                self.updateCollectionViewUserInteractionEnabled(true)
            })
        }

        beforeIndex = currentIndex
    }

    func updateCollectionViewUserInteractionEnabled(_ userInteractionEnabled: Bool) {
        collectionView.isUserInteractionEnabled = userInteractionEnabled
    }
}

// MARK: - UICollectionViewDataSource

extension TabView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isInfinity ? pageTabItemsCount * 3 : pageTabItemsCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let identifier = TabCollectionCell.reuseIdentifier

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? TabCollectionCell else {
            fatalError("Cennot dequeue UICollectionView cell (\(TabCollectionCell.reuseIdentifier))")
        }

        configureCell(cell, indexPath: indexPath)

        return cell
    }

    fileprivate func configureCell(_ cell: TabCollectionCell, indexPath: IndexPath) {

        let fixedIndex = isInfinity ? indexPath.item % pageTabItemsCount : indexPath.item

        cell.itemName = names[fixedIndex]
        cell.option = option
        cell.isCurrent = fixedIndex == (currentIndex % pageTabItemsCount)
        cell.tabItemPressedBlock = { [weak self, weak cell] in

            var direction = UIPageViewControllerNavigationDirection.forward

            if let pageTabItemsCount = self?.pageTabItemsCount, let currentIndex = self?.currentIndex {

                if self?.isInfinity == true {

                    if (indexPath.item < pageTabItemsCount) || (indexPath.item < currentIndex) {
                        direction = .reverse
                    }

                } else if indexPath.item < currentIndex {

                    direction = .reverse
                }
            }

            self?.pageItemPressedBlock?(fixedIndex, direction)

            if cell?.isCurrent == false {

                self?.updateCollectionViewUserInteractionEnabled(false)
            }

            self?.updateCurrentIndexForTap(indexPath.item)
        }
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

        if let cell = cell as? TabCollectionCell, layouted {
            let fixedIndex = isInfinity ? indexPath.item % pageTabItemsCount : indexPath.item
            cell.isCurrent = fixedIndex == (currentIndex % pageTabItemsCount)
        }
    }
}

// MARK: - UIScrollViewDelegate

extension TabView: UICollectionViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        if scrollView.isDragging {

            currentBarView.isHidden = true

            let indexPath = IndexPath(item: currentIndex, section: 0)

            if let cell = collectionView.cellForItem(at: indexPath) as? TabCollectionCell {

                cell.showCurrentBarView()
            }
        }

        guard isInfinity else {
            return
        }

        if pageTabItemsWidth == 0.0 {
            pageTabItemsWidth = floor(scrollView.contentSize.width / 3.0)
        }

        if (scrollView.contentOffset.x <= 0.0) || (scrollView.contentOffset.x > pageTabItemsWidth * 2.0) {
            scrollView.contentOffset.x = pageTabItemsWidth
        }

    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {

        updateCollectionViewUserInteractionEnabled(true)

        guard isInfinity else {
            return
        }

        let indexPath = IndexPath(item: currentIndex, section: 0)

        if shouldScrollToItem {
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
            shouldScrollToItem = false
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension TabView: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        if let size = cachedCellSizes[indexPath] {

            return size
        }

        configureCell(cellForSize, indexPath: indexPath)

        let size = cellForSize.sizeThatFits(CGSize(width: collectionView.bounds.width, height: option.tabHeight))

        cachedCellSizes[indexPath] = size

        return size
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
