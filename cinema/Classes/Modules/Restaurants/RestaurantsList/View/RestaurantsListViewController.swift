//
// Created by Alexander Maslennikov on 25/07/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit

class RestaurantsListViewController: ParentViewController {

    var output: RestaurantsListViewOutput!

    fileprivate let indication: Indication = {
        let indication = Indication()
        indication.register(view: IndicationLoadView(), for: .load)
        indication.register(view: IndicationErrorView(), for: .error)
        return indication
    }()
    fileprivate let tableView = UITableView()

    fileprivate var items: [RestaurantsDisplayItem] = []

    // MARK: - Life cycle

    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.titleView = UIImageView(image: (Asset.NavBar.navBarLogo.image).withRenderingMode(.alwaysTemplate))

        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = .fdlGreyishBrown
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()

        let menuButton = UIButton(type: .system)
        menuButton.addTarget(self, action: #selector(handleMenuButtonPressed), for: .touchUpInside)
        menuButton.setImage(Asset.NavBar.navBarMenu.image, for: .normal)
        menuButton.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: menuButton)

        let mapButton = UIButton(type: .system)
        mapButton.addTarget(self, action: #selector(handleMapButtonPressed), for: .touchUpInside)
        mapButton.setImage(Asset.NavBar.navBarMap.image, for: .normal)
        mapButton.sizeToFit()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: mapButton)

        tableView.dataSource = self
        tableView.rowHeight = 114
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        tableView.register(RestaurantTableViewCell.self)
        view.addSubview(tableView.prepareForAutoLayout())
        tableView.pinEdgesToSuperviewEdges()

        indication.output = self
        indication.insets = UIEdgeInsets(top: 44, left: 0, bottom: 0, right: 0)
        view.register(indication: indication)

        output.viewIsReady()
    }

    // MARK: - Actions

    func handleMapButtonPressed() {
        output.pressMapButton()
    }

    func handleMenuButtonPressed() {
        output.pressMenuButton()
    }
}

// MARK: - RestaurantsListViewInput

extension RestaurantsListViewController: RestaurantsListViewInput {

    func update(displayItems: [RestaurantsDisplayItem]) {
        self.items = displayItems

        indication.hide(animated: true)

        tableView.reloadData()
    }

    func showEmptyLoading() {
        indication.show(type: .load, animated: true)
    }

    func show(error: String) {
        indication.updateError(message: error)
        indication.show(type: .error, animated: true)
    }
}

// MARK: - IndicationOutput

extension RestaurantsListViewController: IndicationOutput {

    func reloadPressed(in indication: Indication) {
        output.needRetryFetchRestaurants()
    }
}

// MARK: - UITableViewDataSource

extension RestaurantsListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RestaurantTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.update(with: items[indexPath.row])
        return cell
    }
}
