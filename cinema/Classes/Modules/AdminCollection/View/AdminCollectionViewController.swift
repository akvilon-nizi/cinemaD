//
// Created by Danila Lyahomskiy on 11/12/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit

class AdminCollectionViewController: ParentViewController {

    var output: AdminCollectionViewOutput!

    var films: [Film] = []

    var imageUrl: String = ""

    var colInfo: String = ""

    var name: String = ""

    let windowWidth = (UIWindow(frame: UIScreen.main.bounds).bounds.width - 80) / 2

    fileprivate let collectionView: UICollectionView = {

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 20, left: 30, bottom: 0, right: 30)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(FilmsCollectionCell.self, forCellWithReuseIdentifier: FilmsCollectionCell.reuseIdentifier)
        collectionView.register(HeaderCollectionCell.self, forCellWithReuseIdentifier: HeaderCollectionCell.reuseIdentifier)
        collectionView.scrollsToTop = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white

        return collectionView
    }()

    // MARK: - Life cycle

    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    init(name: String) {
        self.name = name
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()

        view.backgroundColor = .white

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
        homeButton.addTarget(self, action: #selector(didTapHomeButton), for: .touchUpInside)
        homeButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        frame = homeButton.frame
        frame.origin.x -= 9
        frame.size = CGSize(width: 30, height: 100)
        homeButton.frame = frame
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: homeButton)

        titleViewLabel.text = "Коллекция"
        titleViewLabel.font = UIFont.cnmFutura(size: 20)

        view.addSubview(collectionView.prepareForAutoLayout())
        collectionView.pinEdgesToSuperviewEdges()
        collectionView.delegate = self
        collectionView.dataSource = self

        activityVC.isHidden = false
        activityVC.startAnimating()
    }

    // MARK: - Actions
    func didTapLeftButton() {
        output?.backTap()
    }

    func didTapHomeButton() {
        output?.homeTap()
    }
}

// MARK: - AdminCollectionViewInput

extension AdminCollectionViewController: AdminCollectionViewInput {
    func openCollection(_ collection: Collection) {
        if let films = collection.films {
            self.films = []
            for filmCol in films {
                let film = Film(id: filmCol.id, name: filmCol.name, imageUrl: filmCol.imageUrl)
                self.films.append(film)
            }
        }
        if let imageUrl = collection.imageUrl {
            self.imageUrl = imageUrl
        }

        self.name = collection.name

        if let description = collection.description {
            self.colInfo = description
        }
        collectionView.reloadData()
        activityVC.isHidden = true
        activityVC.stopAnimating()
    }

    func showNetworkError() {
        showAlert(message: L10n.alertCinemaNetworkErrror)
        activityVC.isHidden = true
        activityVC.stopAnimating()
    }

    func setupInitialState() {

    }
}

extension AdminCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            let inset: CGFloat = colInfo == "" ? 15 : 60
            return CGSize(
                width: view.frame.width - 55,
                height: (view.frame.width - 55) / 320 * 131 + colInfo.height(withConstrainedWidth: view.frame.width - 70,
                                                                             font: UIFont.cnmFuturaLight(size: 14) ) + inset)
        }
        return CGSize(width: windowWidth, height: windowWidth / 800 * 1_185)
    }
}

extension AdminCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        output?.openFilmID(films[indexPath.row].id, name: films[indexPath.row].name)
    }
}

extension AdminCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return films.count
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderCollectionCell.reuseIdentifier, for: indexPath)
            if let tagCell = cell as? HeaderCollectionCell {
                tagCell.setInfo(text: colInfo, title: name, imageUrl: imageUrl)
            }
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilmsCollectionCell.reuseIdentifier, for: indexPath)
        if let tagCell = cell as? FilmsCollectionCell {
            tagCell.linkUrlImage = films[indexPath.row].imageUrl
        }
        return cell
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
}

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(
            with: constraintRect,
            options: .usesLineFragmentOrigin,
            attributes: [NSFontAttributeName: font],
            context: nil
        )
        return ceil(boundingBox.height)
    }
}
