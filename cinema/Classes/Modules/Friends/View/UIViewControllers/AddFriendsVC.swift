//
//  AddFriendsVC.swift
//  cinema
//
//  Created by iOS on 11.12.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

protocol AddFriendsVCDelegate: class {
    func addFriend(id: String)
}

class AddFriendsVC: ParentViewController {

    let tableView = UITableView(frame: CGRect.zero, style: .grouped)

    let windowWidth = UIWindow(frame: UIScreen.main.bounds).bounds.width - 60

    let windowWidth2 = (UIWindow(frame: UIScreen.main.bounds).bounds.width - 40) / 9 * 4

    var friends: [Creator] = []

    var curentIndex: Int?

    var addedIndex: Set<Int> = []

    weak var delegate: AddFriendsVCDelegate?

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
        tableView.contentInset = UIEdgeInsets(top: -25, left: 0, bottom: 0, right: 0)

        tableView.separatorStyle = .none
        tableView.allowsMultipleSelection = false
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(FriendsAddCell.self, forCellReuseIdentifier: FriendsAddCell.reuseIdentifier)

        tableView.reloadData()
    }

    func setFriends(_ friends: [Creator]) {
        self.friends = friends
        tableView.reloadData()
    }

    func seccessAdded() {
        if let id = curentIndex {
            addedIndex.insert(id)
            tableView.reloadRows(at: [IndexPath(row: id, section: 0)], with: .none)
        }
    }
}

// MARK: - UITableViewDataSource

extension AddFriendsVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return friends.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FriendsAddCell.reuseIdentifier, for: indexPath)
        if let cellFriends = cell as? FriendsAddCell {
            cellFriends.delegate = self
            cellFriends.index = indexPath.row
            cellFriends.name = friends[indexPath.row].name
            cellFriends.linkImage = friends[indexPath.row].avatar
            cellFriends.buttonIsEnabled = !addedIndex.contains(indexPath.row)
        }

        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

}

// MARK: - UITableViewDelegate

extension AddFriendsVC: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 67
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
}

extension AddFriendsVC: FriendsAddCellDelegate {
    func tapButtonChat(_ index: Int) {
        if let id = friends[index].id {
            delegate?.addFriend(id: id)
            curentIndex = index
        }
    }
}
