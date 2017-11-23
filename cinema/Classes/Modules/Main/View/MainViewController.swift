//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit
import RxMoya
import RxSwift
import VKSdkFramework

struct NewsFilter {
    let title: String
    var isSwitch: Bool
}

class MainViewController: ParentViewController {

    var output: MainViewOutput!

    let header = MainVCHeader()

    let childController = UIViewController()

    var navController = UINavigationController()

    let contentView = UIView()

    var provider: RxMoyaProvider<FoodleTarget>!

    let tableView = UITableView(frame: CGRect.zero, style: .grouped)

    let windowWidth = UIWindow(frame: UIScreen.main.bounds).bounds.width - 60

    let windowWidth2 = (UIWindow(frame: UIScreen.main.bounds).bounds.width - 40) / 9 * 4

    var isFirstLoaded = false

    var mainData = MainData()

    var isNewsFilterOpen = false

    var newsFilterArray: [NewsFilter] = [
        NewsFilter(title: L10n.mainNewsNew, isSwitch: false),
        NewsFilter(title: L10n.mainNewsMessageActors, isSwitch: false),
        NewsFilter(title: L10n.mainNewsDrawing, isSwitch: false),
        NewsFilter(title: L10n.mainNewsFree, isSwitch: false)
    ]

    var newsHeader: HeaderViewOpenned = {
        let view = HeaderViewOpenned()
        view.title = L10n.mainNewsTitle
        return view
    } ()

    // MARK: - Life cycle

    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        navController.navigationBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()

        view.bringSubview(toFront: activityVC)
        activityVC.isHidden = false
        activityVC.startAnimating()
    }

    func addView() {
        mainTabView.isHidden = false
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension

        view.addSubview(mainTabView.prepareForAutoLayout())
        mainTabView.widthAnchor ~= view.widthAnchor
        mainTabView.heightAnchor ~= 80
        mainTabView.leadingAnchor ~= view.leadingAnchor
        mainTabView.bottomAnchor ~= view.bottomAnchor

        view.addSubview(contentView.prepareForAutoLayout())
        contentView.topAnchor ~= view.topAnchor
        contentView.leadingAnchor ~= view.leadingAnchor
        contentView.trailingAnchor ~= view.trailingAnchor
        contentView.bottomAnchor ~= mainTabView.topAnchor

        navController = UINavigationController(rootViewController: self.childController)

        navController.willMove(toParentViewController: self)
        navController.view.frame = contentView.bounds
        childController.view.backgroundColor = .red
        contentView.addSubview(navController.view)
        addChildViewController(navController)
        navController.didMove(toParentViewController: self)
        navController.navigationBar.isHidden = true
        let decorator = WhiteNavigationBarDecorator()
        decorator.configure(navController.navigationBar)

        output?.setRootVC(navController)

        navController.delegate = self

//        [myNav willMoveToParentViewController:self];
//        myNav.view.frame = navFrame;  //Set a frame or constraints
//        [self.view addSubview:myNav.view];
//        [self addChildViewController:myNav];
//        [myNav didMoveToParentViewController:self];

        childController.view.addSubview(tableView.prepareForAutoLayout())
        tableView.pinEdgesToSuperviewEdges()
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none

        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)

        mainTabView.delegate = self

        tableViewRegister()

        newsHeader.tag = 5
        newsHeader.isOpen = isNewsFilterOpen
        newsHeader.delegate = self
    }

    private func tableViewRegister() {
        tableView.register(NewsFilterCell.self, forCellReuseIdentifier: NewsFilterCell.reuseIdentifier)
        tableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.reuseIdentifier)
        tableView.register(NewsImageCell.self, forCellReuseIdentifier: NewsImageCell.reuseIdentifier)
        tableView.register(NewsVideoCell.self, forCellReuseIdentifier: NewsVideoCell.reuseIdentifier)
    }

    func reloadNewsFilter() {
        var filters: [String] = []
        for filterNews in newsFilterArray where filterNews.isSwitch == true {
            filters = switchNewsFilter(title: filterNews.title, filters: filters)
        }
        output?.changeFilter(filters)
    }

    private func switchNewsFilter(title: String, filters: [String]) -> [String] {
        var newsFilter: [String] = []
        newsFilter.append(contentsOf: filters)
        switch title {
        case L10n.mainNewsNew:
            newsFilter.append(L10n.filtersNewsNew)
            return newsFilter
        case L10n.mainNewsMessageActors:
            newsFilter.append(L10n.filtersNewsMessageActors)
            return newsFilter
        case L10n.mainNewsDrawing:
            newsFilter.append(L10n.filtersNewsDrawing)
            return newsFilter
        case L10n.mainNewsFree:
            newsFilter.append(L10n.filtersNewsFree)
            return newsFilter
        default:
            return filters
        }
    }

    func shareNews(imageShare: UIImage?, news: News?) {
        if let newsShare = news {
            let vkShare = VKShareDialogController()
            //            var text = newsShare.description.components(separatedBy: ".")
            let string: String = newsShare.name + ". " + newsShare.description
            vkShare.text = string
            if let image = imageShare {
                let img = VKUploadImage(image: image, andParams: nil)
                vkShare.uploadImages = [img as Any]
            }
            let link = URL(string: Configurations.linkShare)
            vkShare.shareLink = VKShareLink(title: "Cinemad", link: link)

            vkShare.completionHandler = { result, str  in
                self.dismiss(animated: true, completion: nil)
            }

            present(vkShare, animated: true, completion: nil)
        }
    }
}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if section == 5 && isNewsFilterOpen {
            return 4
        }
        if section == 6 {
            return mainData.news.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 5 {
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsFilterCell.reuseIdentifier, for: indexPath)
            if let collCel = cell as? NewsFilterCell {
                collCel.indexPath = indexPath
                collCel.title = newsFilterArray[indexPath.row].title
                collCel.isDidSelect = newsFilterArray[indexPath.row].isSwitch
            }

            return cell
        }

        if indexPath.section == 6 {
            if mainData.news[indexPath.row].type == "common" {
                let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.reuseIdentifier, for: indexPath)
                if let collCel = cell as? NewsCell {
                    collCel.setNews(mainData.news[indexPath.row])
                    collCel.delegate = self
                }
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: NewsImageCell.reuseIdentifier, for: indexPath)
                if let collCel = cell as? NewsImageCell {
                    collCel.setNews(mainData.news[indexPath.row])
                    collCel.delegate = self
                }
                return cell
            }
        }

        let cell = UITableViewCell()

        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 5 {
            let cell = tableView.cellForRow(at: indexPath)
            if let collectionCell = cell as? NewsFilterCell {
                collectionCell.isDidSelect = !collectionCell.isDidSelect
                newsFilterArray[indexPath.row].isSwitch = collectionCell.isDidSelect
                UIView.setAnimationsEnabled(false)
                tableView.beginUpdates()
                mainData.news = []
                tableView.reloadSections(IndexSet(integersIn: indexPath.section...indexPath.section + 1), with: UITableViewRowAnimation.none)
                tableView.endUpdates()
                UIView.setAnimationsEnabled(true)
                activityVC.startAnimating()
                activityVC.isHidden = false
                view.bringSubview(toFront: activityVC)
                reloadNewsFilter()
            }
        }
        if indexPath.section == 6 {
            output?.tapNews(newsID: mainData.news[indexPath.row].id)
        }
    }

}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 5 && isNewsFilterOpen {
            return 44
        }

        if indexPath.section == 6 {
            return UITableViewAutomaticDimension
        }
        return 0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            if mainData.trailers.isEmpty {
                return nil
            }
            header.trailers = mainData.trailers
            return header
        case 1:
            if mainData.now.isEmpty {
                return nil
            }
            let view = HeaderViewTitle()
            view.title = "Сейчас в кино"
            return view
        case 2:
            if mainData.now.isEmpty {
                return nil
            }
            let view = FilmGroup()
            view.films = mainData.now
            view.delegate = self
            return view
        case 3:
            if mainData.recomend.isEmpty {
                return nil
            }
            let view = HeaderViewTitle()
            view.title = "Рекомендации"
            return view
        case 4:
            if mainData.recomend.isEmpty {
                return nil
            }
            let view = FilmGroup()
            view.films = mainData.recomend
            view.delegate = self
            return view
        case 5:
            return newsHeader
        default:
            return nil
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            if mainData.trailers.isEmpty {
                return 0
            }
            return windowWidth / 16 * 9 + 20
        case 1:
            if mainData.now.isEmpty {
                return 0
            }
            return 27
        case 2:
            if mainData.now.isEmpty {
                return 0
            }
            return windowWidth2
        case 3:
            if mainData.recomend.isEmpty {
                return 0
            }
            return 27
        case 4:
            if mainData.recomend.isEmpty {
            return 0
            }
            return windowWidth2
        case 5:
            return 44
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }

}

// MARK: - MainViewInput

extension MainViewController: MainViewInput {

    func setupInitialState() {

    }

    func getError() {
        showAlert(message: L10n.alertCinemaNetworkErrror)
        activityVC.isHidden = true
        activityVC.stopAnimating()
    }
    func getData(_ mainData: MainData) {

        if !isFirstLoaded {
            addView()
            isFirstLoaded = true
        }

        self.mainData = mainData
        activityVC.isHidden = true
        activityVC.stopAnimating()
        UIView.setAnimationsEnabled(false)
        tableView.beginUpdates()
        tableView.reloadSections(IndexSet(integersIn: 6...6), with: UITableViewRowAnimation.none)
        tableView.endUpdates()
        UIView.setAnimationsEnabled(true)
    }

    func getNews(_ mainData: MainData) {
        self.mainData = mainData
        activityVC.isHidden = true
        activityVC.stopAnimating()
        tableView.reloadData()
    }



}

// MARK: - MainViewDelegate

extension MainViewController: MainTabViewDelegate {
    func ticketsTapped() {
        print("ticketsTapped")
    }

    func rewardsTapped() {
        output.openRewards()
    }

    func profileTapped() {
        print("profileTapped")
    }

    func chatTapped() {
//        output.openKinobase()
    }

    func kinobaseTapped() {
        output.openKinobase()
    }
}

// MARK: - FilmGroupDelegate
extension MainViewController: FilmGroupDelegate {
    func openFilmID(_ filmID: String, name: String) {
        output.openFilm(videoID: filmID, name: name)
        navController.navigationBar.isHidden = true
    }
}

// MARK: - HeaderViewOpennedDelegate

extension MainViewController: HeaderViewOpennedDelegate {

    func open(isOpen: Bool, section: Int) {
        isNewsFilterOpen = isOpen
        UIView.setAnimationsEnabled(false)
        tableView.beginUpdates()
        tableView.reloadSections(IndexSet(integersIn: 4...5), with: UITableViewRowAnimation.none)
        tableView.endUpdates()
        UIView.setAnimationsEnabled(true)
    }
}

// MARK: - HeaderViewOpennedDelegate

extension MainViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if navigationController.childViewControllers.count == 1 {
            mainTabView.reloadData()
        }
    }
}

extension MainViewController: NewsImageCellDelegate {
    func openShare(image: UIImage?, news: News) {
        shareNews(imageShare: image, news: news)
    }
}

extension MainViewController: NewsCellDelegate {
    func openShareSimple(news: News) {
        shareNews(imageShare: nil, news: news)
    }
}
