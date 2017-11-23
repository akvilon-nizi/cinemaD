//
//  RewardsCell.swift
//  cinema
//
//  Created by iOS on 23.11.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

// MARK: - NewsFilterCell

//protocol RewardsCell: class {
//    func openShareSimple(news: News)
//}

class RewardsCell: UITableViewCell {

    let windowWidth = (UIWindow(frame: UIScreen.main.bounds).bounds.width - 80) / 2

    let windowWidthMain = UIWindow(frame: UIScreen.main.bounds).bounds.width - 30

    var beginInset: CGFloat = 0

    var lastOffset: CGFloat = 0

    let size: CGFloat = 92

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

    private let descriptionLabel: UILabel = {

        let descriptionLabel = UILabel()

        descriptionLabel.font = UIFont.fdlSystemRegular(size: 18)
        descriptionLabel.text = L10n.slide3LabelDescriptionText
        descriptionLabel.textColor = UIColor.cnmBlueLight

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
        collectionView.register(FilmsCollectionCell.self, forCellWithReuseIdentifier: FilmsCollectionCell.reuseIdentifier)
        collectionView.scrollsToTop = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white

        return collectionView
    }()

    private let imagesArray: [UIImageView] = [
        UIImageView(image: Asset.Cinema.Slides.slide3Image1.image).setSize(width: 15, height: 20),
        UIImageView(image: Asset.Cinema.Slides.slide3Image2.image).setSize(width: 33, height: 37),
        UIImageView(image: Asset.Cinema.Slides.slide3Image3.image).setSize(width: 39, height: 67),
        UIImageView(image: Asset.Cinema.Slides.slide3Image4.image).setSize(width: 33, height: 37),
        UIImageView(image: Asset.Cinema.Slides.slide3Image5.image).setSize(width: 15, height: 20)
    ]

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
//        descriptionLabel.bottomAnchor ~= contentView.bottomAnchor
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

//    func setNews(_ news: News) {
//        self.news = news
//        infoLabel.text = news.creator.name + ", " + news.createdAt.hourMinutes + ", " + news.createdAt.monthMedium
//        userImage.kf.setImage(with: URL(string: news.creator.avatar))
//        titleLabel.text = news.name
//        newsLabel.text = news.description
//        countLabel.text = String(news.shared)
//    }
//
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

//        if indexPath.row == 0 {
//            return CGSize(width: windowWidth, height: windowWidth / 3 * 4)
//        }

        return CGSize(width: 80, height: 80)
    }
}

extension RewardsCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //output?.openFilmID(films[indexPath.row].id, name: films[indexPath.row].name)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        print("willDisplay", indexPath.row)
    }

    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        print("didDisplay", indexPath.row)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        print(indexPath.row)
    }
}

extension RewardsCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilmsCollectionCell.reuseIdentifier, for: indexPath)

        //            if let tagCell = cell as? FilmsCollectionCell {
        //                tagCell.linkUrlImage = films[indexPath.row].imageUrl
        //            }
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
            var assa: Int = Int((scrollView.contentOffset.x - beginInset) / size)
            if isRightScroll {
                assa += 1
            }
            print(assa)
        }
    }

}