//
//  NewsFriendVC.swift
//  cinema
//
//  Created by User on 18.12.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

protocol NewsFriendVCDelegate: class {
    func openFilmId(_ filmID: String, name: String)
}

class NewsFriendVC: ParentViewController {

    weak var delegate: NewsFriendVCDelegate?

    let tableView = UITableView(frame: CGRect.zero, style: .grouped)

    let windowWidth = UIWindow(frame: UIScreen.main.bounds).bounds.width - 60

    let windowWidth2 = (UIWindow(frame: UIScreen.main.bounds).bounds.width - 40) / 9 * 4

    var news: [FriendsNewsForView] = []

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

        view.addSubview(tableView.prepareForAutoLayout())
        tableView.pinEdgesToSuperviewEdges()

        tableView.contentInset = UIEdgeInsets(top: -35, left: 0, bottom: 0, right: 0)

        tableView.separatorStyle = .none
        tableView.allowsMultipleSelection = false
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(FriendsNewsCell.self, forCellReuseIdentifier: FriendsNewsCell.reuseIdentifier)
        tableView.register(FriendsNewCell.self, forCellReuseIdentifier: FriendsNewCell.reuseIdentifier)

        tableView.reloadData()
    }

    func setNews(_ news: [FriendsNewsForView]) {
        self.news = news
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension NewsFriendVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return news.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if news[indexPath.row].type == .willWatch || news[indexPath.row].type == .watched {
            let cell = tableView.dequeueReusableCell(withIdentifier: FriendsNewsCell.reuseIdentifier, for: indexPath)
            if let cellFriends = cell as? FriendsNewsCell {
                cellFriends.setUserInfo(info: news[indexPath.row])
                cellFriends.delegate = self
            }

            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: FriendsNewCell.reuseIdentifier, for: indexPath)
            if let cellFriends = cell as? FriendsNewCell {
                cellFriends.setUserInfo(info: news[indexPath.row])
            }

            return cell
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

}

// MARK: - UITableViewDelegate

extension NewsFriendVC: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
}

extension NewsFriendVC: FriendsNewsCellDelegate {
    func openFilmId(_ filmID: String, name: String) {
        delegate?.openFilmId(filmID, name: name)
    }
}
