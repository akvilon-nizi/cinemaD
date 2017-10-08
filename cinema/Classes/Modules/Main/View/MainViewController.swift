//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit

class MainViewController: ParentViewController {

    var output: MainViewOutput!

    let tableView = UITableView()

    // MARK: - Life cycle

    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()

        mainTabView.isHidden = false

        tableView.delegate = self
        tableView.dataSource = self

        view.addSubview(tableView.prepareForAutoLayout())
        tableView.pin(to: view, edgesInsets: UIEdgeInsets(top: 0, left: 0, bottom: 80, right: 0))

        mainTabView.delegate = self
    }
}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = CartCell()

//        cell.setData(products[indexPath.row])
//        cell.delegate = self

        return cell
    }
}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 110
    }
}

// MARK: - MainViewInput

extension MainViewController: MainViewInput {

    func setupInitialState() {

    }
}

// MARK: - MainViewDelegate

extension MainViewController: MainTabViewDelegate {
    func ticketsTapped() {
        print("ticketsTapped")
    }

    func rewardsTapped() {
        print("rewardsTapped")
    }

    func profileTapped() {
        print("profileTapped")
    }

    func chatTapped() {
        print("chatTapped")
    }

    func kinobaseTapped() {
        print("kinobaseTapped")
    }
}
