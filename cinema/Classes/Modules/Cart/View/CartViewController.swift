//
// Created by incetro on 17/08/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit

class CartViewController: ParentViewController {

    fileprivate let navigationBarView: RestaurantNavigationBarView = {

        let navigationBarView = RestaurantNavigationBarView(frame: CGRect(x: 0, y: 0, width: 200, height: 44))

        navigationBarView.backgroundColor = .clear

        return navigationBarView
    }()

    fileprivate let cartTableView: UITableView = {

        let cartTableBiew = UITableView()

        cartTableBiew.separatorStyle = .none
        cartTableBiew.backgroundColor = .clear
        cartTableBiew.clipsToBounds = false

        return cartTableBiew
    }()

    var output: CartViewOutput!

    let contentManager = CartContentManager()

    let footerItemBuilder: CartFooterItemBuilder = CartFooterItemBuilderImplementation()

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

        contentManager.tableView = cartTableView

        setupUI()
    }

    func setupUI() {

        let backButton = UIButton()
        backButton.setImage(Asset.NavBar.navBarArrowBack.image, for: .normal)
        backButton.addTarget(self, action: #selector(didTapLeftButton), for: .touchUpInside)
        backButton.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)

        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 44))

        navigationBarView.frame = titleView.bounds

        titleView.addSubview(navigationBarView)

        self.navigationItem.titleView = titleView

        view.addSubview(cartTableView.prepareForAutoLayout())

        automaticallyAdjustsScrollViewInsets = false

        cartTableView.pinEdgesToSuperviewEdges(excluding: .top)
        cartTableView.heightAnchor ~= self.view.frame.height - 74

        contentManager.delegate = self
    }

    func didTapLeftButton() {

        navigationController?.popViewController(animated: true)
    }

    func didTapRightButton() {

        output.clearCartButtonTapped()
    }
}

// MARK: - CartEmptyViewDelegate

extension CartViewController: CartEmptyViewDelegate {

    func didTapRestaurantsButton() {

    }
}

// MARK: - CartContentManagerDelegate

extension CartViewController: CartContentManagerDelegate {

    func plusButtonTapped(productID: Int) {

        output.incrementProductInCart(productID: productID)
    }

    func minusButtonTapped(productID: Int) {

        output.decrementProductInCart(productID: productID)
    }
}

// MARK: - CartViewInput

extension CartViewController: CartViewInput {

    func refreshState(withCart cart: Cart) {

        contentManager.setProducts(cart.products)

        if cart.products.isEmpty {

            let emptyView = CartEmptyView(frame: cartTableView.frame)

            cartTableView.backgroundView = emptyView
            cartTableView.tableFooterView = nil

        } else {

            let footer = CartFooterView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 60))

            footer.setData(footerItemBuilder.cartFooterItem(fromCart: cart))

            cartTableView.tableFooterView = footer
        }

        if cart.products.isEmpty {

            navigationItem.rightBarButtonItem = nil

        } else {

            navigationItem.rightBarButtonItem = UIBarButtonItem(
                title: L10n.cartClearTitle,
                style: .plain,
                target: self,
                action: #selector(didTapRightButton)
            )
            navigationItem.rightBarButtonItem?.tintColor = UIColor.fdlWarmGrey
        }

        guard let restaurant = cart.restaurant else {

            return
        }

        navigationBarView.setup(withName: restaurant.name, address: restaurant.address, nameAlpha: 1, addressAlpha: 1)
    }
}
