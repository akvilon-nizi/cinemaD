//
//  ExsRewardsCell.swift
//  cinema
//
//  Created by iOS on 07.12.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

// MARK: - RewardsCell

//protocol RewardsCell: class {
//    func openShareSimple(news: News)
//}

class ExsRewardsCell: UITableViewCell {

    let windowWidth = (UIWindow(frame: UIScreen.main.bounds).bounds.width - 80) / 2

    let windowWidthMain = UIWindow(frame: UIScreen.main.bounds).bounds.width - 30

    var beginInset: CGFloat = 0

    var lastOffset: CGFloat = 0

    var currentElement: Int = 0

    let size: CGFloat = 92

    var awards: [Adward] = []

    let windowY = UIWindow(frame: UIScreen.main.bounds).frame.width

    private let titleLabel: UILabel = {

        let titleLabel = UILabel()

        titleLabel.text = L10n.slide3LabelTitleText
        titleLabel.font = UIFont.fdlGothamProMedium(size: 18)
        titleLabel.textColor = UIColor.cnmGreyDark

        return titleLabel
    }()

    let backButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.Cinema.backImage.image, for: .normal)
        button.heightAnchor ~= 50
        button.widthAnchor ~= 50
        button.setTitleColor(.red, for: .normal)
        return button
    }()

    let forwardButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.Cinema.forwardImage.image, for: .normal)
        button.heightAnchor ~= 50
        button.widthAnchor ~= 50
        button.setTitleColor(.red, for: .normal)
        return button
    }()

    private let nameLabel: UILabel = {

        let nameLabel = UILabel()

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

        let layout = UICollectionViewFlowLayout()
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
        collectionView.isScrollEnabled = false

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

        contentView.addSubview(titleLabel.prepareForAutoLayout())
        titleLabel.centerXAnchor ~= contentView.centerXAnchor
        titleLabel.topAnchor ~= contentView.topAnchor

        contentView.addSubview(nameLabel.prepareForAutoLayout())
        nameLabel.centerXAnchor ~= contentView.centerXAnchor
        nameLabel.topAnchor ~= titleLabel.bottomAnchor + 10

        contentView.addSubview(collectionView.prepareForAutoLayout())
        collectionView.leadingAnchor ~= contentView.leadingAnchor
        collectionView.trailingAnchor ~= contentView.trailingAnchor
        collectionView.topAnchor ~= nameLabel.bottomAnchor + 27
        collectionView.heightAnchor ~= 167
        collectionView.delegate = self
        collectionView.dataSource = self

        contentView.addSubview(backButton.prepareForAutoLayout())
        backButton.centerYAnchor ~= collectionView.centerYAnchor
        backButton.leadingAnchor ~= contentView.leadingAnchor + 20
        backButton.addTarget(self, action: #selector(backButtonTap), for: .touchUpInside)

        contentView.addSubview(forwardButton.prepareForAutoLayout())
        forwardButton.centerYAnchor ~= collectionView.centerYAnchor
        forwardButton.trailingAnchor ~= contentView.trailingAnchor - 20
        forwardButton.addTarget(self, action: #selector(forwardButtonTap), for: .touchUpInside)

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

    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    func backButtonTap() {
        currentElement -= 1
        forwardButton.isEnabled = true
        if currentElement == 0 {
            backButton.isEnabled = false
        }
        setContentOffset()

    }

    func forwardButtonTap() {
        currentElement += 1
        backButton.isEnabled = true
        if currentElement == awards.count - 1 {
            forwardButton.isEnabled = false
        }
        setContentOffset()
    }

    private func setContentOffset() {
        let indexPath = IndexPath(row: currentElement, section: 0)
        collectionView.isScrollEnabled = true
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        collectionView.isScrollEnabled = false
        infoLabel.text = awards[currentElement].name
        descriptionLabel.text = awards[currentElement].description
        infoLabel.layoutIfNeeded()
        print(currentElement)
    }

    func setAwards(_ title: String, award: Adwards) {
        titleLabel.text = title
        nameLabel.text = "\(award.myAwardsCount)/\(award.awardsCount)"
        awards = award.awards
        collectionView.reloadData()

        backButton.isEnabled = false

        if awards.count < 2 {
            forwardButton.isEnabled = false
        }
    }

    static var reuseIdentifier: String {
        return "ExsRewardsCell"
    }
}

extension ExsRewardsCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: windowY, height: 130)
    }
}

extension ExsRewardsCell: UICollectionViewDelegate {
}

extension ExsRewardsCell: UICollectionViewDataSource {
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
