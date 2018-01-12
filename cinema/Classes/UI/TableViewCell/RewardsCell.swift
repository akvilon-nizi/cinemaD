//
//  RewardsCell.swift
//  cinema
//
//  Created by iOS on 23.11.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

// MARK: - RewardsCell

//protocol RewardsCell: class {
//    func openShareSimple(news: News)
//}

class RewardsCell: UITableViewCell {

    let windowWidth = (UIWindow(frame: UIScreen.main.bounds).bounds.width - 80) / 2

    let windowWidthMain = UIWindow(frame: UIScreen.main.bounds).bounds.width - 30

    var beginInset: CGFloat = 0

    var lastOffset: CGFloat = 0

    let size: CGFloat = 92

    var awards: [Adward] = []

    private let titleLabel: UILabel = {

        let titleLabel = UILabel()

        titleLabel.text = L10n.slide3LabelTitleText
        titleLabel.font = UIFont.fdlGothamProMedium(size: 18)
        titleLabel.textColor = UIColor.cnmGreyDark

        return titleLabel
    }()

    private let nameLabel: UILabel = {

        let nameLabel = UILabel()

        nameLabel.text = "5/24"
        nameLabel.font = UIFont.cnmFutura(size: 14)
        nameLabel.textColor = UIColor.cnmGreyDark

        return nameLabel
    }()

    let descriptionLabel: UILabel = {

        let descriptionLabel = UILabel()

        descriptionLabel.font = UIFont.fdlSystemRegular(size: 18)
        descriptionLabel.text = L10n.slide3LabelDescriptionText
        descriptionLabel.textColor = UIColor.cnmBlueLight

        return descriptionLabel
    }()

    let infoLabel: UILabel = {

        let descriptionLabel = UILabel()

        descriptionLabel.font = UIFont.cnmFutura(size: 14)
        descriptionLabel.text = L10n.slide3LabelDescriptionText
        descriptionLabel.textColor = UIColor.cnmGreyLight

        return descriptionLabel
    }()

    fileprivate let collectionView: UICollectionView = {

        let layout = LineLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 12
        layout.minimumLineSpacing = 12
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)

        //layout.itemSize = CGSize(width: 100.0, height: 100.0)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(RewardCell.self, forCellWithReuseIdentifier: RewardCell.reuseIdentifier)
        collectionView.scrollsToTop = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white

        return collectionView
    }()

    required init?(coder _: NSCoder) {
        fatalError("NSCoding not supported")
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none

        contentView.backgroundColor = .white

        autoresizesSubviews = true

        let inset = windowWidthMain / 2 - 40

        beginInset = -inset
        lastOffset = -inset

        collectionView.contentInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)

        contentView.addSubview(titleLabel.prepareForAutoLayout())
        titleLabel.centerXAnchor ~= contentView.centerXAnchor
        titleLabel.topAnchor ~= contentView.topAnchor

        contentView.addSubview(nameLabel.prepareForAutoLayout())
        nameLabel.centerXAnchor ~= contentView.centerXAnchor
        nameLabel.topAnchor ~= titleLabel.bottomAnchor + 10
//
//        let stackView = createStackView(.horizontal, .center, .fillProportionally, 32, with: imagesArray)
//        contentView.addSubview(stackView.prepareForAutoLayout())
//        stackView.centerXAnchor ~= contentView.centerXAnchor
//        stackView.topAnchor ~= nameLabel.bottomAnchor + 17

        contentView.addSubview(collectionView.prepareForAutoLayout())
        collectionView.leadingAnchor ~= contentView.leadingAnchor
        collectionView.trailingAnchor ~= contentView.trailingAnchor
        collectionView.topAnchor ~= nameLabel.bottomAnchor + 17
        collectionView.heightAnchor ~= 90
        collectionView.delegate = self
        collectionView.dataSource = self

        let leftView = UIView()
        leftView.backgroundColor = .white
        contentView.addSubview(leftView.prepareForAutoLayout())
        leftView.leadingAnchor ~= collectionView.leadingAnchor
        leftView.topAnchor ~= collectionView.topAnchor
        leftView.heightAnchor ~= collectionView.heightAnchor
        leftView.widthAnchor ~= 30

        let rightView = UIView()
        rightView.backgroundColor = .white
        contentView.addSubview(rightView.prepareForAutoLayout())
        rightView.trailingAnchor ~= collectionView.trailingAnchor
        rightView.topAnchor ~= collectionView.topAnchor
        rightView.heightAnchor ~= collectionView.heightAnchor
        rightView.widthAnchor ~= 30

        contentView.addSubview(descriptionLabel.prepareForAutoLayout())
        descriptionLabel.centerXAnchor ~= contentView.centerXAnchor
        descriptionLabel.topAnchor ~= collectionView.bottomAnchor + 23

        contentView.addSubview(infoLabel.prepareForAutoLayout())
        infoLabel.leadingAnchor ~= contentView.leadingAnchor + 35
        infoLabel.trailingAnchor ~= contentView.trailingAnchor - 35
        infoLabel.topAnchor ~= descriptionLabel.bottomAnchor + 12
        infoLabel.heightAnchor ~= 55
        infoLabel.numberOfLines = 0

        let separatorView = UIView()
        separatorView.backgroundColor = .cnmDadada
        contentView.addSubview(separatorView.prepareForAutoLayout())
        separatorView.bottomAnchor ~= contentView.bottomAnchor
        separatorView.trailingAnchor ~= contentView.trailingAnchor - 24
        separatorView.leadingAnchor ~= contentView.leadingAnchor + 24
        separatorView.heightAnchor ~= 1
        separatorView.topAnchor ~= infoLabel.bottomAnchor + 16
        separatorView.bottomAnchor ~= contentView.bottomAnchor - 30

//        descriptionLabel.bottomAnchor ~= contentView.bottomAnchor
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    func setAwards(_ title: String, award: Adwards) {
        titleLabel.text = title
        nameLabel.text = "\(award.myAwardsCount)/\(award.awardsCount)"
        awards = award.awards
        collectionView.reloadData()
    }

//    func tiewapSharedButton() {
//        if let newShare = news {
//            delegate?.openShareSimple(news: newShare)
//        }
//    }

    static var reuseIdentifier: String {
        return "RewardsCell"
    }
}

extension RewardsCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 80, height: 80)
    }
}

extension RewardsCell: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView,
                        willDisplaySupplementaryView view: UICollectionReusableView,
                        forElementKind elementKind: String,
                        at indexPath: IndexPath
        ) {
        print(indexPath.row)
    }
}

extension RewardsCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return awards.count
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RewardCell.reuseIdentifier, for: indexPath)
        if let tagCell = cell as? RewardCell {
            tagCell.linkUrlImage = awards[indexPath.row].image
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        print(destinationIndexPath.row)
    }
}

extension RewardsCell: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let isRightScroll = scrollView.contentOffset.x > lastOffset
        lastOffset = scrollView.contentOffset.x

        if isRightScroll && (scrollView.contentOffset.x - beginInset).truncatingRemainder(dividingBy: size) > 61
            || !isRightScroll && (scrollView.contentOffset.x - beginInset).truncatingRemainder(dividingBy: size) < 31 {
            var number: Int = Int((scrollView.contentOffset.x - beginInset) / size)
            if isRightScroll {
                number += 1
            }

            infoLabel.text = awards[number].name
            descriptionLabel.text = awards[number].description
            infoLabel.layoutIfNeeded()
            contentView.layoutIfNeeded()
            contentView.layoutSubviews()
        }
    }

}
