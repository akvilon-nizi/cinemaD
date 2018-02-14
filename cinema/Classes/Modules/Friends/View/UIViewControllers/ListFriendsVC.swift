//
//  ListFriendsVC.swift
//  cinema
//
//  Created by iOS on 11.12.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

protocol FriendsSubVCDelegate: class {
    func pullToRefresh()
}

class ListFriendsVC: ParentViewController {

    let tableView = UITableView(frame: CGRect.zero, style: .grouped)

    weak var delegate: FriendsSubVCDelegate?

    let windowWidth = UIWindow(frame: UIScreen.main.bounds).bounds.width - 60

    let windowWidth2 = (UIWindow(frame: UIScreen.main.bounds).bounds.width - 40) / 9 * 4

    var friends: [Creator] = []

    var arrayVC: [Creator] = []

    let refreshControl = UIRefreshControl()

    // MARK: - Life cycle

    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self

        let searchView = SearchCommonView()
        searchView.hiddenFilter()

        let headerView = UIView()

        headerView.addSubview(searchView.prepareForAutoLayout())
        searchView.topAnchor ~= headerView.topAnchor + 10
        searchView.leadingAnchor ~= headerView.leadingAnchor
        searchView.trailingAnchor ~= headerView.trailingAnchor
        searchView.heightAnchor ~= 45
        searchView.bottomAnchor ~= headerView.bottomAnchor
        searchView.delegate = self

        headerView.frame = CGRect(x: 0, y: 0, width: UIWindow(frame: UIScreen.main.bounds).bounds.width, height: 45)

        tableView.tableHeaderView = headerView

        view.addSubview(tableView.prepareForAutoLayout())
        tableView.topAnchor ~= view.topAnchor + 10
        tableView.leadingAnchor ~= view.leadingAnchor
        tableView.trailingAnchor ~= view.trailingAnchor
        tableView.bottomAnchor ~= view.bottomAnchor

        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)

        tableView.separatorStyle = .none
        tableView.allowsMultipleSelection = false
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(FriendsListCell.self, forCellReuseIdentifier: FriendsListCell.reuseIdentifier)

        tableView.reloadData()
    }

    func refresh() {
        delegate?.pullToRefresh()
    }

    func setFriends(_ friends: [Creator]) {
        refreshControl.endRefreshing()
        self.friends = friends
        self.arrayVC = friends
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension ListFriendsVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return friends.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FriendsListCell.reuseIdentifier, for: indexPath)
        if let cellFriends = cell as? FriendsListCell {
            cellFriends.delegate = self
            cellFriends.index = indexPath.row
            cellFriends.name = friends[indexPath.row].name
            cellFriends.linkImage = friends[indexPath.row].avatar
        }

        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

}

// MARK: - UITableViewDelegate

extension ListFriendsVC: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 67
    }

//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        switch section {
//        case 0:
//            let view = HeaderViewTitle()
//            view.title = "Фильмы"
//            return view
//        default:
//            return nil
//        }
//    }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        switch section {
//        case 0:
//            return 22
//        case 1:
//            return 22
//        case 3:
//            if films.isEmpty {
//                return 0
//            }
//            return windowWidth / 4 * 3 - 80
//        case 2:
//            return 33
//        default:
//            return 0
//        }
  //  }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
}

// MARK: - SearchCommonDelegate

extension ListFriendsVC: SearchCommonDelegate {
    func tapFilter() {

    }

    func changeText(_ text: String) {
        if text.count >= 1 {
            friends = arrayVC.filter { $0.name.range(of: text) != nil || $0.name.lowercased().range(of: text) != nil || $0.name.range(of: text.lowercased()) != nil || $0.name.lowercased().range(of: text.lowercased()) != nil}
        } else {
            friends = arrayVC
        }
        tableView.reloadData()
    }
}

extension ListFriendsVC: FriendsListCellDelegate {
    func tapButtonChat(_ index: Int) {
        print()
    }
}
