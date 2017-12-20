//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit

class KinobaseViewController: ParentViewController {

    var output: KinobaseViewOutput!

    let pageViewController = UIPageViewController(
        transitionStyle: .pageCurl,
        navigationOrientation: .horizontal,
        options: nil
    )

    let willWatchVC = WillWatchVC()
    let watchedVC = WatchedVC()

    let controllers: [UIViewController]

    var container = UIView()

    var watched: [Film] = []

    var kbData: KinobaseData = KinobaseData()

    let willWatchButton: UIButton = {
        let button = UIButton()
        button.setTitle(L10n.filmWillWatchButton, for: .normal)
        button.setTitleColor(UIColor.cnmAfafaf, for: .normal)
        button.setTitleColor(UIColor.cnmMainOrange, for: .selected)
        button.titleLabel?.font = UIFont.cnmFuturaLight(size: 16)
        button.heightAnchor ~= 33
        button.widthAnchor ~= (UIWindow(frame: UIScreen.main.bounds).bounds.width - 1) / 2
        return button
    }()

    let watchedButton: UIButton = {
        let button = UIButton()
        button.setTitle(L10n.filmWatchedButton, for: .normal)
        button.setTitleColor(UIColor.cnmAfafaf, for: .normal)
        button.setTitleColor(UIColor.cnmMainOrange, for: .selected)
        button.titleLabel?.font = UIFont.cnmFuturaLight(size: 16)
        button.heightAnchor ~= 33
        button.widthAnchor ~= (UIWindow(frame: UIScreen.main.bounds).bounds.width - 1) / 2
        return button
    }()

    let separatorView: UIView = {
        let view = UIView()
        view.heightAnchor ~= 33
        view.widthAnchor ~= 1
        view.backgroundColor = UIColor.cnmAfafaf
        return view
    }()

    var currentIndex: Int = 0

    // MARK: - Life cycle

    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    init(controllers: [UIViewController]) {
        self.controllers = [watchedVC, willWatchVC]
        super.init(nibName: nil, bundle: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()

        willWatchVC.delegate = self
        watchedVC.delegate = self

        let backButton = UIButton()
        backButton.setImage(Asset.NavBar.navBarArrowBack.image, for: .normal)
        backButton.addTarget(self, action: #selector(didTapLeftButton), for: .touchUpInside)
        backButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        var frame = backButton.frame
        frame.size = CGSize(width: 30, height: 100)
        backButton.frame = frame
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)

        titleViewLabel.text = "Кинобаза"
        titleViewLabel.font = UIFont.cnmFutura(size: 20)

        watchedButton.isSelected = true

        watchedButton.addTarget(self, action: #selector(didTapWatchedButton), for: .touchUpInside)

        willWatchButton.addTarget(self, action: #selector(didTapWillWatchButton), for: .touchUpInside)

        setPageVC()

        activityVC.startAnimating()
        activityVC.isHidden = false
        activityVC.color = UIColor.cnmMainOrange
        view.bringSubview(toFront: activityVC)
    }

    private func setPageVC() {
        pageViewController.setViewControllers(
            [controllers[0]],
            direction: .forward,
            animated: false,
            completion: nil
        )

        let buttonsStack = createStackView(.horizontal, .fill, .fill, 1, with: [watchedButton, separatorView, willWatchButton])
        view.addSubview(buttonsStack.prepareForAutoLayout())
        buttonsStack.centerXAnchor ~= view.centerXAnchor
        buttonsStack.topAnchor ~= view.topAnchor + 40

        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
//        pageViewController.dataSource = self
//        pageViewController.delegate = self

        container = pageViewController.view
//        container = SearchView()
//        container.setInfo(placeholder: "assa", titles: ["assa", "assa1", "asdadsa"])
        view.addSubview(container.prepareForAutoLayout())
        container.topAnchor ~= buttonsStack.bottomAnchor + 10
        container.leadingAnchor ~= view.leadingAnchor
        container.trailingAnchor ~= view.trailingAnchor
        container.bottomAnchor ~= view.bottomAnchor

    }

    // MARK: - Actions
    func didTapLeftButton() {
        output?.backButtonTap()
    }

    func didTapWatchedButton() {
        if currentIndex != 0 {
            watchedButton.isSelected = true
            willWatchButton.isSelected = false
            pageViewController.setViewControllers(
                [controllers[0]],
                direction: .forward,
                animated: false,
                completion: nil)
            currentIndex = 0
        }
    }

    func didTapWillWatchButton() {
        if currentIndex != 1 {
            willWatchButton.isSelected = true
            watchedButton.isSelected = false
            pageViewController.setViewControllers(
                [controllers[1]],
                direction: .forward,
                animated: false,
                completion: nil)
            currentIndex = 1
        }
    }
}
// MARK: - UIPageViewControllerDataSource

extension KinobaseViewController: UIPageViewControllerDataSource {

    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController
        ) -> UIViewController? {
        guard let index = controllers.index(of: viewController), index != 0 else {
            return nil
        }
        return controllers[index - 1]
    }

    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController
        ) -> UIViewController? {
        guard let index = controllers.index(of: viewController), index != controllers.count - 1 else {
            return nil
        }
        return controllers[index + 1]
    }

}

// MARK: - UIPageViewControllerDelegate

extension KinobaseViewController: UIPageViewControllerDelegate {

    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
//        if let vc = pendingViewControllers.last,
////            let index = controllers.index(of: vc),
////            let tab = ProfileTabType(rawValue: index) {
////            tabBar.set(tab: tab)
//        }
    }

}

// MARK: - KinobaseViewInput

extension KinobaseViewController: KinobaseViewInput {

    func setupInitialState() {
    }

    func getError() {
        showAlert(message: L10n.alertCinemaNetworkErrror)
        activityVC.isHidden = true
        activityVC.stopAnimating()
    }
    func getData(_ kbData: KinobaseData) {

        self.kbData = kbData

        var willWatch: [Film] = []
        for filmCol in kbData.willWatched {
            let film = Film(id: filmCol.id, name: filmCol.name, imageUrl: filmCol.imageUrl)
            willWatch.append(film)
        }
        willWatchVC.setFilms(willWatch, collections: kbData.adminCollections)

        watched = []

        for filmColW in kbData.watched {
            let rate = filmColW.rate != nil ? Int(filmColW.rate!) : 0
            let film = Film(id: filmColW.id, name: filmColW.name, imageUrl: filmColW.imageUrl, rate: Double(rate))
            watched.append(film)
        }
        watchedVC.refreshControl.endRefreshing()
        watchedVC.setFilmsAndCol(watched, col: kbData.collections)

        activityVC.isHidden = true
        activityVC.stopAnimating()
    }

    func getCollection(_ collection: Collection) {
        watchedVC.openCollection(collection)
        activityVC.isHidden = true
        activityVC.stopAnimating()
    }

    func startTrober() {
        activityVC.isHidden = false
        activityVC.startAnimating()
    }
    func getSearch(_ kbData: KinobaseData, isWatched: Bool) {
        activityVC.isHidden = true
        activityVC.stopAnimating()
        self.kbData = kbData
        if isWatched {
//            watched = []
//            for filmColW in kbData.watched {
//                let rate = filmColW.rate != nil ? Int(filmColW.rate!) : 0
//                let film = Film(id: filmColW.id, name: filmColW.name, imageUrl: filmColW.imageUrl, rate: rate)
//                watched.append(film)
//            }
            watchedVC.getSearch(kbData.filmsSearch)
        } else {
//            var willWatch: [Film] = []
//            for filmCol in kbData.willWatched {
//                let film = Film(id: filmCol.id, name: filmCol.name, imageUrl: filmCol.imageUrl)
//                willWatch.append(film)
//            }
            willWatchVC.getSearch(kbData.filmsSearch)
        }
    }

}

extension KinobaseViewController: WillWatchVCDelegate {
    func openFullList(_ films: [Film]) {
        output?.openFullFilm(films)
    }

    func openFilmId(_ filmID: String, name: String) {
        output?.openFilm(videoID: filmID, name: name)
    }

    func getQuery(_ query: String) {
        output?.searchWithText(query, isWatched: false)
    }
    func tapFilter() {
        output?.tapFilter(isWatched: false, genres: kbData.genresWillWatch, years: kbData.yearsWillWatch)
    }

    func openCollection(id: String, name: String) {
        output?.openAdminCollection(id: id, name: name)
    }

    func refreshes() {
        activityVC.isHidden = false
        activityVC.startAnimating()
        output?.refresh()
    }
}

extension KinobaseViewController: WatchedFilmDelegate {
    func openFullAlls(_ films: [Film]) {
        output?.openFullFilm(films)
    }
    func openCollectionFromId(id: String) {
        activityVC.isHidden = false
        activityVC.startAnimating()
        output?.openCollecttion(id: id)
    }
    func newCollection() {
        output?.openCollections(id: "", name: "", watched: watched)
    }

    func settingsCollection(id: String, name: String) {
        output.openCollections(id: id, name: name, watched: watched)
    }

    func openFilmID(_ filmID: String, name: String) {
        output?.openFilm(videoID: filmID, name: name)
    }

    func refresh() {
        activityVC.isHidden = false
        activityVC.startAnimating()
        output?.refresh()
    }

    func getQueryWatched(_ query: String) {
        output?.searchWithText(query, isWatched: true)
    }
    func tapFilterWatched() {
        output?.tapFilter(isWatched: true, genres: kbData.genresWatched, years: kbData.yearsWatched)
    }

    func removeCollectionFromId(id: String) {
        output?.deleteCollections(id: id)
    }
}
