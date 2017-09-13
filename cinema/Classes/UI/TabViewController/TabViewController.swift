//
//  TabViewController.swift
//  foodle
//
//  Created by incetro on 11/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

// MARK: - TabViewController

class TabViewController: UIPageViewController {

    typealias TabItems = [(viewController: UIViewController, title: String)]

    var isInfinity = false
    var option = TabPageOption()
    var tabItems: TabItems = []

    var currentIndex: Int? {

        guard let viewController = viewControllers?.first else {

            return nil
        }

        return tabItems.map { $0.viewController }.index(of: viewController)
    }

    fileprivate var beforeIndex: Int = 0

    fileprivate var tabItemsCount: Int {

        return tabItems.count
    }

    fileprivate var defaultContentOffsetX: CGFloat {

        return self.view.bounds.width
    }

    fileprivate var shouldScrollCurrentBar: Bool = true

    lazy var tabView: TabView = self.configuredTabView()

    fileprivate var statusView: UIView?

    fileprivate var statusViewConstraint: NSLayoutConstraint?

    fileprivate var tabBarTopConstraint: NSLayoutConstraint?

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(transitionStyle style: UIPageViewControllerTransitionStyle,
                  navigationOrientation: UIPageViewControllerNavigationOrientation,
                  options: [String : Any]? = nil) {

        super.init(transitionStyle: style, navigationOrientation: navigationOrientation, options: options)
    }

    func setup(withItems items: TabItems, startIndex: Int) {

        beforeIndex = startIndex > 0 ? startIndex : 0

        self.tabItems = items

        setupPageViewController()
        setupScrollView()

        if tabView.superview == nil {

            tabView = configuredTabView()
        }

        if let currentIndex = currentIndex, isInfinity {

            tabView.updateCurrentIndex(currentIndex, shouldScroll: true)
        }

        tabView.layouted = true
        tabView.delegate = self
    }

    fileprivate func setupPageViewController() {

        dataSource = self
        delegate = self
        automaticallyAdjustsScrollViewInsets = false

        setViewControllers([tabItems[beforeIndex].viewController], direction: .forward, animated: false, completion: nil)
    }

    fileprivate func setupScrollView() {

        let scrollView = view.subviews.flatMap { $0 as? UIScrollView }.first
        scrollView?.scrollsToTop = false
        scrollView?.delegate = self
        scrollView?.backgroundColor = option.pageBackgoundColor
    }

    fileprivate func configuredTabView() -> TabView {

        let tabView = TabView(isInfinity: isInfinity, option: option)

        view.addSubview(tabView)

        tabView.translatesAutoresizingMaskIntoConstraints = false
        tabView.heightAnchor ~= option.tabHeight

        print("assa", view.frame)

        let top = view.topAnchor ~= tabView.topAnchor - 64
        let left = view.leadingAnchor ~= tabView.leadingAnchor
        let right = view.trailingAnchor ~= tabView.trailingAnchor

        view.addConstraints([top, left, right])

        tabView.names = tabItems.map { $0.title }
        tabView.updateCurrentIndex(beforeIndex, shouldScroll: true)

        tabView.pageItemPressedBlock = { [weak self] (index: Int, direction: UIPageViewControllerNavigationDirection) in

            self?.displayControllerWithIndex(index, direction: direction, animated: true)
        }

        tabBarTopConstraint = top

        return tabView
    }

    func didSelectPage(withIndex index: Int, title: String) {

    }

    private func setupStatusView() {

        let statusView = UIView()

        statusView.backgroundColor = option.tabBackgroundColor
        statusView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(statusView)
        statusView.pin(as: view, using: [.left, .right, .top])
        let height = statusView.heightAnchor ~= topLayoutGuide.heightAnchor
        height.isActive = true
        statusViewConstraint = height

        self.statusView = statusView
    }

    func updateNavigationBarHidden(_ hidden: Bool, animated: Bool) {

        guard let navigationController = navigationController else {
            return
        }

        switch option.hidesTopViewOnSwipeType {

        case .tabBar:

            updateTabBarOrigin(hidden: hidden)

        case .navigationBar:

            if hidden {

                navigationController.setNavigationBarHidden(true, animated: true)

            } else {

                showNavigationBar()
            }

        case .all:

            updateTabBarOrigin(hidden: hidden)

            if hidden {

                navigationController.setNavigationBarHidden(true, animated: true)

            } else {

                showNavigationBar()
            }

        default:
            break
        }

        if statusView == nil {
            setupStatusView()
        }

        statusViewConstraint?.constant = topLayoutGuide.length
    }

    func showNavigationBar() {

        guard let navigationController = navigationController, navigationController.isNavigationBarHidden else {
            return
        }

        guard let tabBarTopConstraint = tabBarTopConstraint else {
            return
        }

        if option.hidesTopViewOnSwipeType != .none {

            tabBarTopConstraint.constant = 0.0

            UIView.animate(withDuration: TimeInterval(UINavigationControllerHideShowBarDuration)) {
                self.view.layoutIfNeeded()
            }
        }

        navigationController.setNavigationBarHidden(false, animated: true)

    }

    private func updateTabBarOrigin(hidden: Bool) {

        guard let tabBarTopConstraint = tabBarTopConstraint else {
            return
        }

        tabBarTopConstraint.constant = hidden ? -(20.0 + option.tabHeight) : 0.0

        UIView.animate(withDuration: TimeInterval(UINavigationControllerHideShowBarDuration)) {
            self.view.layoutIfNeeded()
        }
    }

    func displayControllerWithIndex(_ index: Int, direction: UIPageViewControllerNavigationDirection, animated: Bool) {

        beforeIndex = index
        shouldScrollCurrentBar = false

        let nextViewControllers: [UIViewController] = [tabItems[index].viewController]

        let completion: ((Bool) -> Void) = { [weak self] _ in
            self?.shouldScrollCurrentBar = true
            self?.beforeIndex = index
        }

        setViewControllers(nextViewControllers, direction: direction, animated: animated, completion: completion)

        if isViewLoaded {
            tabView.updateCurrentIndex(index, shouldScroll: true)
        }
    }
}

// MARK: - UIPageViewControllerDataSource

extension TabViewController: UIPageViewControllerDataSource {

    fileprivate func nextViewController(_ viewController: UIViewController, isAfter: Bool) -> UIViewController? {

        guard var index = tabItems.map({ $0.viewController }).index(of: viewController) else {

            return nil
        }

        if isAfter {

            index += 1

        } else {

            index -= 1
        }

        if isInfinity {

            if index < 0 {

                index = tabItems.count - 1

            } else if index == tabItems.count {

                index = 0
            }
        }

        if index >= 0 && index < tabItems.count {

            return tabItems[index].viewController
        }

        return nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {

        return nextViewController(viewController, isAfter: true)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        return nextViewController(viewController, isAfter: false)
    }
}

// MARK: - TabViewDelegate

extension TabViewController: TabViewDelegate {

    func currentIndexChanged(_ index: Int) {

        didSelectPage(withIndex: index, title: tabItems[index % tabItems.count].title)
    }
}

// MARK: - UIPageViewControllerDelegate

extension TabViewController: UIPageViewControllerDelegate {

    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {

        shouldScrollCurrentBar = true
        tabView.scrollToHorizontalCenter()
        tabView.updateCollectionViewUserInteractionEnabled(false)
    }

    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {

        if let currentIndex = currentIndex, currentIndex < tabItemsCount {

            tabView.updateCurrentIndex(currentIndex, shouldScroll: false)
            beforeIndex = currentIndex
        }

        tabView.updateCollectionViewUserInteractionEnabled(true)
    }
}

// MARK: - UIScrollViewDelegate

extension TabViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        if scrollView.contentOffset.x == defaultContentOffsetX || !shouldScrollCurrentBar {

            return
        }

        var index: Int

        if scrollView.contentOffset.x > defaultContentOffsetX {

            index = beforeIndex + 1

        } else {

            index = beforeIndex - 1
        }

        if index == tabItemsCount {

            index = tabItemsCount - 1

        } else if index < 0 {

            index = 0
        }

        let scrollOffsetX = scrollView.contentOffset.x - view.frame.width

        tabView.scrollCurrentBarView(index, contentOffsetX: scrollOffsetX)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        tabView.updateCurrentIndex(beforeIndex, shouldScroll: true)
    }
}
