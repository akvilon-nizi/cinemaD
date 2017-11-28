//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit

class FilmsViewController: ParentViewController {

    var output: FilmsViewOutput!

    var films: [Film] = []

    let windowWidth = (UIWindow(frame: UIScreen.main.bounds).bounds.width - 80) / 2

    fileprivate let collectionView: UICollectionView = {

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 20, left: 30, bottom: 0, right: 30)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(FilmsCollectionCell.self, forCellWithReuseIdentifier: FilmsCollectionCell.reuseIdentifier)
        collectionView.scrollsToTop = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white

        return collectionView
    }()

    // MARK: - Life cycle

    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()

//        activityVC.startAnimating()
//        activityVC.isHidden = false

        let backButton = UIButton()
        backButton.setImage(Asset.NavBar.navBarArrowBack.image, for: .normal)
        backButton.addTarget(self, action: #selector(didTapLeftButton), for: .touchUpInside)
        backButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        var frame = backButton.frame
        frame.size = CGSize(width: 30, height: 100)
        backButton.frame = frame
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)

        let homeButton = UIButton()
        homeButton.setImage(Asset.Cinema.home.image, for: .normal)
        //        homeButton.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
        homeButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        frame = homeButton.frame
        frame.origin.x -= 9
        frame.size = CGSize(width: 30, height: 100)
        homeButton.frame = frame
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: homeButton)

        titleViewLabel.text = L10n.filmsTitleText
        titleViewLabel.font = UIFont.cnmFutura(size: 20)

        view.addSubview(collectionView.prepareForAutoLayout())
        collectionView.pinEdgesToSuperviewEdges()
        collectionView.delegate = self
        collectionView.dataSource = self

//        activityVC.isHidden = false
//        activityVC.startAnimating()
//        view.bringSubview(toFront: activityVC)
    }

    // MARK: - Actions
    func didTapLeftButton() {
        output?.backButtonTap()
    }

}

// MARK: - FilmsViewInput

extension FilmsViewController: FilmsViewInput {

    func setupInitialState(_ films: [Film]) {
        self.films = films
//        activityVC.stopAnimating()
//        activityVC.isHidden = true
//        activityVC.stopAnimating()
        self.collectionView.reloadData()
    }
}

extension FilmsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: windowWidth, height: windowWidth / 3 * 4)
    }
}

extension FilmsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        output?.openFilmID(films[indexPath.row].id, name: films[indexPath.row].name)
    }
}

extension FilmsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return films.count
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilmsCollectionCell.reuseIdentifier, for: indexPath)

        if let tagCell = cell as? FilmsCollectionCell {
            tagCell.linkUrlImage = films[indexPath.row].imageUrl
        }
        return cell
    }
}
