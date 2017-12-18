//
//  NewsFriendVC.swift
//  cinema
//
//  Created by User on 18.12.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

class NewsFriendVC: ParentViewController {

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

        tableView.register(FriendsNewsCell.self, forCellReuseIdentifier: FriendsListCell.reuseIdentifier)

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
        let cell = tableView.dequeueReusableCell(withIdentifier: FriendsListCell.reuseIdentifier, for: indexPath)
        if let cellFriends = cell as? FriendsNewsCell {
            cellFriends.setUserInfo(info: news[indexPath.row])
//            cellFriends.delegate = self
//            cellFriends.index = indexPath.row
//            cellFriends.name = friends[indexPath.row].name
        }
        //        cell.setData(products[indexPath.row])
        //        cell.delegate = self

        return cell
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

//// MARK: - SearchCommonDelegate
//
//extension ListFriendsVC: SearchCommonDelegate {
//    func tapFilter() {
//
//    }
//
//    func changeText(_ text: String) {
//
//    }
//}
//
//extension ListFriendsVC: FriendsListCellDelegate {
//    func tapButtonChat(_ index: Int) {
//        print()
//    }
//}

