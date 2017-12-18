//
// Created by akvilon-nizi on 23/11/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit

class ProfileViewController: ParentViewController {

    var output: ProfileViewOutput!

    let profileHeader = ProfileHeader()

    let tableView = UITableView(frame: CGRect.zero, style: .grouped)

    var films: [Film] = []

    var avatar: String = ""

    var userName: String = ""

    let refreshControl = UIRefreshControl()

    let windowWidth = (UIWindow(frame: UIScreen.main.bounds).bounds.width - 40) / 9 * 4

    //refreshControl.endRefreshing()

    // MARK: - Life cycle

    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    init() {
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

        view.backgroundColor = .white

        let backButton = UIButton()
        backButton.setImage(Asset.NavBar.navBarArrowBack.image, for: .normal)
        backButton.addTarget(self, action: #selector(didTapLeftButton), for: .touchUpInside)
        backButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        var frame = backButton.frame
        frame.size = CGSize(width: 30, height: 100)
        backButton.frame = frame
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)

        titleViewLabel.text = L10n.profileTitleText
        titleViewLabel.font = UIFont.cnmFutura(size: 20)

        tableView.backgroundColor = .white
        view.addSubview(tableView.prepareForAutoLayout())
        tableView.pinEdgesToSuperviewEdges()
        tableView.delegate = self
        tableView.dataSource = self

        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)

        tableView.register(NewsFilterCell.self, forCellReuseIdentifier: NewsFilterCell.reuseIdentifier)

        profileHeader.delegate = self
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate, let profile = appDelegate.profile {
            profileHeader.setProfileInfo(profile: profile)
            userName = profile.name
            avatar = profile.avatar
        }

        activityVC.startAnimating()
        activityVC.isHidden = false
        activityVC.color = UIColor.cnmMainOrange
        view.bringSubview(toFront: activityVC)
    }

    // MARK: - Actions
    func didTapLeftButton() {
        output?.backButtonTap()
    }

    func refresh() {
//        delegate?.refreshes()
    }

}

// MARK: - ProfileViewInput

extension ProfileViewController: ProfileViewInput {
    func editeProfile(name: String, avatarUrl: String) {
        profileHeader.editeProfile(name: name, imageUrl: avatarUrl)
    }

    func setupInitialState() {

    }

    func getError() {
        showAlert(message: L10n.alertCinemaNetworkErrror)
        activityVC.isHidden = true
        activityVC.stopAnimating()
    }

    func getProfile(_ profile: ProfileModel) {
        
    }

    func getData(_ films: [FilmCollections]) {

        self.films = []

        for filmColW in films {
            var rate: Int = 0
            if let rating = filmColW.rate {
               rate = Int(rating)
            }
            let film = Film(id: filmColW.id, name: filmColW.name, imageUrl: filmColW.imageUrl, rate: rate)
            self.films.append(film)
        }
        tableView.reloadData()

        activityVC.isHidden = true
        activityVC.stopAnimating()
    }
}

// MARK: - UITableViewDelegate

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            return profileHeader
        case 1:
            if films.isEmpty {
                return nil
            }
            let view = HeaderViewTitle()
            view.title = L10n.profileDidWatch
            return view
        case 2:
            if films.isEmpty {
                return nil
            }
            let view = FilmGroup()
            view.films = films
            view.delegate = self
            return view
        default:
            return nil
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 190
        case 1:
            if films.isEmpty {
                return 0
            }
            return 27
        case 2:
            if films.isEmpty {
                return 0
            }
            return windowWidth
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
}

// MARK: - UITableViewDataSource

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

//        if indexPath.section == 5 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: NewsFilterCell.reuseIdentifier, for: indexPath)
//            if let collCel = cell as? NewsFilterCell {
//                collCel.indexPath = indexPath
//                collCel.title = newsFilterArray[indexPath.row].title
//                collCel.isDidSelect = newsFilterArray[indexPath.row].isSwitch
//            }
//
//            return cell
//        }

        return UITableViewCell()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
}

// MARK: - FilmGroupDelegate
extension ProfileViewController: FilmGroupDelegate {
    func openFilmID(_ filmID: String, name: String) {
        output?.openFilm(videoID: filmID, name: name)
    }

    func changeStatusFilm(_ film: Film, isAdd: Bool) {

    }
}

// MARK: - ProfileHeaderDelegate

extension ProfileViewController: ProfileHeaderDelegate {
    func tapEdit() {
        output?.editingButtonTap(nameUser: userName, avatar: avatar)
    }

    func tapSettings() {
        output?.settingButtonTap()
    }

    func tapButton(tag: Int) {
        switch tag {
        case 0:
            output.handleTapRewards()
        case 1:
            output.handleTapWatched()
        case 2:
            output.openFriends()
        default:
            print()
        }
    }
}
