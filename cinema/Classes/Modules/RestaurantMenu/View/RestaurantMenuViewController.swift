//
// Created by incetro on 12/08/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit

class RestaurantMenuViewController: TabViewController {

    fileprivate var categories: [Category] = []

    fileprivate let navigationBarView: RestaurantNavigationBarView = {

        let navigationBarView = RestaurantNavigationBarView(frame: CGRect(x: 0, y: 0, width: 200, height: 44))

        navigationBarView.backgroundColor = .clear

        return navigationBarView
    }()

    fileprivate let cartView = CartView(frame: CGRect(x: 0, y: 0, width: 40, height: 30))

    var output: RestaurantMenuViewOutput!

    // MARK: - Life cycle

    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    override init(transitionStyle style: UIPageViewControllerTransitionStyle,
                  navigationOrientation: UIPageViewControllerNavigationOrientation,
                  options: [String : Any]? = nil) {

        super.init(transitionStyle: style, navigationOrientation: navigationOrientation, options: nil)
    }

    convenience init() {

        self.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        output.viewIsReady()

        view.backgroundColor = .white

        let menuButton = UIButton()
        menuButton.setImage(Asset.NavBar.navBarArrowBack.image, for: .normal)
        menuButton.addTarget(self, action: #selector(didTapLeftButton), for: .touchUpInside)
        menuButton.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: menuButton)

        cartView.delegate = self
        cartView.sizeToFit()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: cartView)

        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 44))

        navigationBarView.frame = titleView.bounds

        titleView.addSubview(navigationBarView)

        self.navigationItem.titleView = titleView
    }

    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)

        output.updateCart()
    }

    override func didSelectPage(withIndex index: Int, title: String) {

        guard let id = categories.first(where: { $0.name == title })?.id else {

            return
        }

        output.didSelectPage(withCategoryID: id)
    }

    func didTapLeftButton() {

        navigationController?.popViewController(animated: true)
    }
}

// MARK: - CartViewDelegate

extension RestaurantMenuViewController: CartViewDelegate {

    func didTapCartButton() {

        output.openCartButtonTapped()
    }
}

// MARK: - RestaurantMenuViewInput

extension RestaurantMenuViewController: RestaurantMenuViewInput {

    func setupTabs(_ items: [(UIViewController, String)], selectedCategoryID: Int) {

        if let index = categories.index(where: { $0.id == selectedCategoryID }) {

            setup(withItems: items, startIndex: index)
            tabView.updateCurrentIndex(index, shouldScroll: true)
        }
    }

    func updateCartCount(_ cartCount: Int) {

        cartView.updateCount(cartCount)
    }

    func setupInitialState(withRestaurant restaurant: FullRestaurant) {

        self.categories = restaurant.categories

        navigationBarView.setup(withName: restaurant.name, address: restaurant.address, nameAlpha: 1, addressAlpha: 1)
    }
}
