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

    let controllers: [UIViewController]

    var container = SearchView()

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
        self.controllers = controllers
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()

        activityVC.startAnimating()
        activityVC.isHidden = false

        let backButton = UIButton()
        backButton.setImage(Asset.NavBar.navBarArrowBack.image, for: .normal)
        backButton.addTarget(self, action: #selector(didTapLeftButton), for: .touchUpInside)
        backButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
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

//        container = pageViewController.view
        container = SearchView()
        container.setInfo(placeholder: "assa", titles: ["assa", "assa1", "asdadsa"])
        view.addSubview(container.prepareForAutoLayout())
        container.topAnchor ~= buttonsStack.bottomAnchor + 10
        container.leadingAnchor ~= view.leadingAnchor
        container.trailingAnchor ~= view.trailingAnchor
//        container.bottomAnchor ~= view.bottomAnchor

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
}
