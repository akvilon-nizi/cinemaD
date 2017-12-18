//
// Created by Danila Lyahomskiy on 05/12/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit

class FriendsViewController: ParentViewController {

    var output: FriendsViewOutput!

    let controllers: [UIViewController]

    let pageViewController = UIPageViewController(
        transitionStyle: .pageCurl,
        navigationOrientation: .horizontal,
        options: nil
    )

    var container = UIView()

    let listFriendsVC = ListFriendsVC()

    let addFriendsVC = AddFriendsVC()

    let newsFriendsVC = NewsFriendVC()

    // MARK: - Life cycle

    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    init() {

        controllers = [listFriendsVC, addFriendsVC, newsFriendsVC]
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

        addFriendsVC.delegate = self

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

        titleViewLabel.text = L10n.friendsTitleText
        titleViewLabel.font = UIFont.cnmFutura(size: 20)

        setPageVC()

    }

    private func setPageVC() {
        pageViewController.setViewControllers(
            [controllers[0]],
            direction: .forward,
            animated: false,
            completion: nil
        )

        let navTabBar = NavTabBar(titles: ["Друзья", "Рекомендации", "Новости"])
        navTabBar.delegate = self

        view.addSubview(navTabBar.prepareForAutoLayout())
        navTabBar.leadingAnchor ~= view.leadingAnchor
        navTabBar.trailingAnchor ~= view.trailingAnchor
        navTabBar.topAnchor ~= view.topAnchor + 40

        container = pageViewController.view

        view.addSubview(container.prepareForAutoLayout())
        container.topAnchor ~= navTabBar.bottomAnchor + 10
        container.leadingAnchor ~= view.leadingAnchor
        container.trailingAnchor ~= view.trailingAnchor
        container.bottomAnchor ~= view.bottomAnchor

    }

    // MARK: - Actions
    func didTapLeftButton() {
        output?.backTap()
    }

    func didTapHomeButton() {
        output?.homeTap()
    }
}

// MARK: - FriendsViewInput

extension FriendsViewController: FriendsViewInput {
    func getData(data: FriendsData) {
        listFriendsVC.setFriends(data.friends)
        addFriendsVC.setFriends(data.recomendaions)
        newsFriendsVC.setNews(data.newsView)
    }

    func addedFriend() {
        addFriendsVC.seccessAdded()
    }

    func showNetworkError() {
        showAlert(message: L10n.alertCinemaNetworkErrror)
        activityVC.isHidden = true
        activityVC.stopAnimating()
    }

    func setupInitialState() {

    }
}

// MARK: - NavTabBarDelegate

extension FriendsViewController: NavTabBarDelegate {
    func tapElement(_ number: Int) {
        pageViewController.setViewControllers(
            [controllers[number]],
            direction: .forward,
            animated: false,
            completion: nil
        )
       // currentIndex = 1
    }
}

// MARK: - AddFriendsVCDelegate

extension FriendsViewController: AddFriendsVCDelegate {
    func addFriend(id: String) {
        output.addFriend(id: id)
    }
}
