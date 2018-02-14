//
// Created by akvilon-nizi on 16/11/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit

class RewardsViewController: ParentViewController {

    var output: RewardsViewOutput!

    var container: UIView = UIView()

    let pageViewController = UIPageViewController(
        transitionStyle: .pageCurl,
        navigationOrientation: .horizontal,
        options: nil
    )

    let willWatchButton: UIButton = {
        let button = UIButton()
        button.setTitle(L10n.rewardsLocationTitle, for: .normal)
        button.setTitleColor(UIColor.cnmAfafaf, for: .normal)
        button.setTitleColor(UIColor.cnmMainOrange, for: .selected)
        button.titleLabel?.font = UIFont.cnmFuturaLight(size: 16)
        button.heightAnchor ~= 33
        button.widthAnchor ~= (UIWindow(frame: UIScreen.main.bounds).bounds.width - 1) / 2
        return button
    }()

    let watchedButton: UIButton = {
        let button = UIButton()
        button.setTitle(L10n.rewardsReviewsTitle, for: .normal)
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

    let reviewsVC = RewardsSubViewController()
    let locationVC = RewardsSubViewController()
    let controllers: [UIViewController]

    // MARK: - Life cycle

    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    init() {
        self.controllers = [reviewsVC, locationVC]
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

        let backButton = UIButton()
        backButton.setImage(Asset.NavBar.navBarArrowBack.image, for: .normal)
        backButton.addTarget(self, action: #selector(didTapLeftButton), for: .touchUpInside)
        backButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        var frame = backButton.frame
        frame.size = CGSize(width: 30, height: 100)
        backButton.frame = frame
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)

        titleViewLabel.text = L10n.rewardsTitleText
        titleViewLabel.font = UIFont.cnmFutura(size: 20)

        watchedButton.isSelected = true

        watchedButton.addTarget(self, action: #selector(didTapWatchedButton), for: .touchUpInside)

        willWatchButton.addTarget(self, action: #selector(didTapWillWatchButton), for: .touchUpInside)

        setPageVC()

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

        container = pageViewController.view
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

// MARK: - RewardsViewInput

extension RewardsViewController: RewardsViewInput {
    func showError() {
        showAlert(message: L10n.alertCinemaNetworkErrror)
        activityVC.isHidden = true
        activityVC.stopAnimating()
    }

    func getAwards(_ awards: [String: Adwards]) {
        var awardsView: [String: Adwards] = [:]
        var awardsGeo: [String: Adwards] = [:]
        for (key, value) in awards {
            if key != L10n.awardsResponseGeo && key != L10n.awardsResponseExclusive && value.awardsCount != 0 {
                awardsView[key] = value
            }
        }

        if let count = awards[L10n.awardsResponseGeo]?.myAwardsCount, count >= 1 {
            awardsGeo[L10n.awardsResponseGeoRu] = awards[L10n.awardsResponseGeo]
        }

        if let count = awards[L10n.awardsResponseExclusive]?.myAwardsCount, count >= 1 {
            awardsView[L10n.awardsResponseExclusiveRu] = awards[L10n.awardsResponseGeo]
        }

        reviewsVC.setAwards(awardsView)
        locationVC.setAwards(awardsGeo)
    }

    func setupInitialState() {

    }
}
