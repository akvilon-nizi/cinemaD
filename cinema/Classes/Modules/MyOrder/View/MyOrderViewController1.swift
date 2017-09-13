//
// Created by DanilaLyahomskiy on 05/09/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

//import UIKit
//
//class MyOrderViewController: ParentViewController {
//
//    var output: MyOrderViewOutput!
//
//    fileprivate let indication: Indication = {
//        let indication = Indication()
//        indication.register(view: IndicationLoadView(), for: .load)
//        indication.register(view: IndicationErrorView(), for: .error)
//        return indication
//    }()
//
//    fileprivate let tableView = UITableView()
//
//    fileprivate var items: [OrdersDisplayItem] = []
//
//    fileprivate let refreshControl = UIRefreshControl()
//
//    // MARK: - Life cycle
//
//    required init(coder aDecoder: NSCoder) {
//        fatalError("NSCoding not supported")
//    }
//
//    init() {
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        navigationController?.setNavigationBarHidden(false, animated: animated)
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        navigationController?.navigationBar.isTranslucent = true
//        navigationController?.navigationBar.tintColor = .white
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        indication.output = self
//        indication.insets = UIEdgeInsets(top: 44, left: 0, bottom: 0, right: 0)
//        view.register(indication: indication)
//
//        let titleLabel = UILabel()
//        titleLabel.textColor = UIColor.fdlGreyishBrown
//        titleLabel.font = UIFont.fdlGothamProBold(size: 17)
//        titleLabel.text = L10n.myOrdersMainTitle
//        titleLabel.sizeToFit()
//
//        navigationItem.titleView = titleLabel
//
//        navigationController?.navigationBar.barTintColor = .white
//        navigationController?.navigationBar.isTranslucent = false
//        navigationController?.navigationBar.tintColor = .fdlGreyishBrown
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navigationController?.navigationBar.shadowImage = UIImage()
//
//        let menuButton = UIButton(type: .system)
//        menuButton.addTarget(self, action: #selector(handleTapMenuButton), for: .touchUpInside)
//        menuButton.setImage(Asset.NavBar.navBarMenu.image, for: .normal)
//        menuButton.sizeToFit()
//        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: menuButton)
//
//        tableView.dataSource = self
//        tableView.rowHeight = 100
//        tableView.separatorStyle = .none
//        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
//        tableView.register(OrderTableViewCell.self)
//        view.addSubview(tableView.prepareForAutoLayout())
//        tableView.pinEdgesToSuperviewEdges()
//
//        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
//        refreshControl.addTarget(self, action: #selector(refresh), for: UIControlEvents.valueChanged)
//        tableView.addSubview(refreshControl)
//        output.viewIsReady()
//    }
//
//    // MARK: - Actions
//
//    func handleTapMenuButton() {
//        output.close()
//    }
//
//    func refresh() {
//        output.reloadData()
//    }
//}
//
//// MARK: - MyOrderViewInput
//
//extension MyOrderViewController: MyOrderViewInput {
//
//    func setupInitialState(withOrders orders: [Order]) {
//        indication.hide(animated: true)
//    }
//
//    func showEmptyLoading() {
//        indication.show(type: .load, animated: true)
//    }
//
//    func show(error: String) {
//        indication.updateError(message: error)
//        indication.show(type: .error, animated: true)
//    }
//
//    func update(displayItems: [OrdersDisplayItem]) {
//        self.items = displayItems
//
//        indication.hide(animated: true)
//
//        refreshControl.endRefreshing()
//
//        tableView.reloadData()
//    }
//}
//
//// MARK: - IndicationOutput
//
//extension  MyOrderViewController: IndicationOutput {
//
//    func reloadPressed(in indication: Indication) {
//        //        output.reloadData()
//    }
//}
//
//// MARK: - UITableViewDataSource
//
//extension MyOrderViewController: UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return items.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell: OrderTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
//        cell.update(with: items[indexPath.row])
//        return cell
//    }
//}
