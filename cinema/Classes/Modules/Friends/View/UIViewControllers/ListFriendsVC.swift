//
//  ListFriendsVC.swift
//  cinema
//
//  Created by iOS on 11.12.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

class ListFriendsVC: ParentViewController {

    let tableView = UITableView(frame: CGRect.zero, style: .grouped)

    let windowWidth = UIWindow(frame: UIScreen.main.bounds).bounds.width - 60

    let windowWidth2 = (UIWindow(frame: UIScreen.main.bounds).bounds.width - 40) / 9 * 4

    var films: [Film] = []

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

        view.addSubview(searchView.prepareForAutoLayout())
        searchView.topAnchor ~= view.topAnchor + 10
        searchView.leadingAnchor ~= view.leadingAnchor
        searchView.trailingAnchor ~= view.trailingAnchor
        searchView.delegate = self

        view.addSubview(tableView.prepareForAutoLayout())
        tableView.topAnchor ~= searchView.bottomAnchor
        tableView.leadingAnchor ~= view.leadingAnchor
        tableView.trailingAnchor ~= view.trailingAnchor
        tableView.bottomAnchor ~= view.bottomAnchor

        tableView.contentInset = UIEdgeInsets(top: -35, left: 0, bottom: 0, right: 0)

        tableView.separatorStyle = .none
        tableView.allowsMultipleSelection = false
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(FriendsListCell.self, forCellReuseIdentifier: FriendsListCell.reuseIdentifier)

        tableView.reloadData()
    }

    func setFilms(_ films: [Film]) {
        self.films = films
        tableView.reloadData()
    }

    func getSearch(_ films: [Film]) {
        self.films = films
        UIView.setAnimationsEnabled(false)
        tableView.beginUpdates()
        tableView.reloadSections(IndexSet(integersIn: 3...3), with: UITableViewRowAnimation.none)
        tableView.endUpdates()
        UIView.setAnimationsEnabled(true)
    }
}

// MARK: - UITableViewDataSource

extension ListFriendsVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FriendsListCell.reuseIdentifier, for: indexPath)
        if let cellFriends = cell as? FriendsListCell {
            cellFriends.delegate = self
            cellFriends.index = indexPath.row
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
    func changeText(_ query: String) {

    }
}

extension ListFriendsVC: FriendsListCellDelegate {
    func tapButtonChat(_ index: Int) {
        print()
    }
}
