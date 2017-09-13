//
// Created by Alexander Maslennikov on 24/07/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit

struct Indents {

    static let navigationBarViewHeight: CGFloat = 64
    static let favoriteViewHeight: CGFloat = ProductsView.heightConstant
    static let infoViewHeight: CGFloat = 188
    static let verticalSpacing: CGFloat = 42
}

class RestaurantViewController: ParentViewController {

    var output: RestaurantViewOutput!

    fileprivate let navigationBarView: RestaurantNavigationBarView = {

        let navigationBarView = RestaurantNavigationBarView(frame: CGRect(x: 0, y: 0, width: 200, height: 38))

        navigationBarView.backgroundColor = .clear
        navigationBarView.alpha = 0

        return navigationBarView
    }()

    private let imageView: UIImageView = {

        let view = UIImageView()

        view.image = Asset.fakeRestaurantPhoto.image
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private let scrollView: UIScrollView = {

        let view = UIScrollView()

        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsVerticalScrollIndicator = false

        return view
    }()

    private let productsViewLabel: UILabel = {

        let label = UILabel()

        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.fdlGothamProMedium(size: 20)
        label.text = L10n.restaurantFavoriteMealsTitle
        label.textColor = UIColor.fdlGreyishBrown

        return label
    }()

    private let productsView: ProductsView = {

        let contentManager = ProductsViewContentManager()
        let view = ProductsView(contentManager: contentManager)

        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    fileprivate let infoView: RestaurantInfoView = {

        let infoView = RestaurantInfoView()

        infoView.translatesAutoresizingMaskIntoConstraints = false

        return infoView
    }()

    private let menuView: RestaurantMenuView = {

        let contentManager = RestaurantMenuViewContentManager()
        let view = RestaurantMenuView(contentManager: contentManager)

        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private let animator = RestaurantViewAnimator()
    private let layouter = RestaurantViewLayouter()

    fileprivate let dataBuilder = RestaurantViewDataBuilder()

    // MARK: - Life cycle

    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        menuView.setDelegate(self)

        output.viewIsReady()

        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    func setupUI(showFavoriteView: Bool) {

        view.addSubview(imageView)
        view.addSubview(scrollView)

        scrollView.addSubview(infoView)
        scrollView.addSubview(productsViewLabel)
        scrollView.addSubview(productsView)
        scrollView.addSubview(menuView)

        layouter.configureImageView(imageView, height: 133, heightConstraintID: "ID")
        layouter.configureScrollView(scrollView, width: self.view.frame.width, top: 64)
        layouter.configureInfoView(infoView, inScrollView: scrollView, width: self.view.frame.width)

        if showFavoriteView {

            let width = self.view.frame.width
            let height = Indents.favoriteViewHeight

            layouter.configureProductsViewLabel(productsViewLabel, in: scrollView, topAnchor: infoView.bottomAnchor)
            layouter.configureProductsView(productsView, in: scrollView, width: width, height: height, bottomAnchor: productsViewLabel.bottomAnchor)
        }

        layouter.configureMenuView(menuView,
                                   inScrollView: scrollView,
                                   width: self.view.frame.width,
                                   bottomAnchor: showFavoriteView ? productsView.bottomAnchor : infoView.bottomAnchor)

        animator.imageView = imageView
        animator.scrollView = scrollView
        animator.navigationBarView = navigationBarView

        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 44))

        navigationBarView.frame = titleView.bounds

        titleView.addSubview(navigationBarView)

        self.navigationItem.titleView = titleView
    }

    func updateFavoriteMealsView(products: [Product]) {

        productsView.setup(withItems: dataBuilder.favorireMealObjects(fromProducts: products))
        productsView.delegate = self
    }

    func updateContent(categories: [Category], products: [Product]) {

        if !products.isEmpty {

            updateFavoriteMealsView(products: products)
        }

        let items = dataBuilder.restaurantMenuItems(fromCategories: categories)

        menuView.setup(withItems: items)

        let tableViewHeight = CGFloat(items.count) * RestaurantMenuView.cellHeight

        let spacing = Indents.verticalSpacing * (!products.isEmpty ? 3 : 2)

        let scrollViewHeight = [

            spacing,
            Indents.infoViewHeight,
            productsViewLabel.font.pointSize,
            !products.isEmpty ? Indents.favoriteViewHeight : 0,
            Indents.verticalSpacing,
            tableViewHeight

        ].reduce(0, +)

        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: scrollViewHeight)
    }
}

extension RestaurantViewController: ProductsViewDelegate {

    func needToRefresh() {

        print("refresh")
    }

    func incrementButtonTapped(product: ProductCellObject) {

        print("increment \(product.id)")
    }

    func decrementButtonTapped(product: ProductCellObject) {

        print("decrement \(product.id)")
    }

    func addButtonTapped(product: ProductCellObject) {

        print(product)
    }

    func openProductInfo(product: ProductCellObject) {
        print(product)
    }
}

extension RestaurantViewController: RestaurantMenuViewDelegate {

    func didSelectMenuItem(withItemID itemID: Int) {

        output.openMenuButtonTapped(selectedCategoryID: itemID)
    }
}

// MARK: - RestaurantViewInput

extension RestaurantViewController: RestaurantViewInput {

    func setupInitialState(withRestaurant restaurant: FullRestaurant) {

        setupUI(showFavoriteView: !restaurant.products.isEmpty)
        updateContent(categories: restaurant.categories, products: restaurant.products)

        infoView.configure(withData: dataBuilder.restaurantInfo(fromRestaurant: restaurant))
        navigationBarView.setup(withName: infoView.restaurantName, address: infoView.restaurantAddress)
    }
}
