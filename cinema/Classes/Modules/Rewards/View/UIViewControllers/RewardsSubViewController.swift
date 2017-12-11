//
//  RewardsSubViewControler.swift
//  cinema
//
//  Created by iOS on 23.11.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

class RewardsSubViewController: ParentViewController {

    let tableView = UITableView(frame: CGRect.zero, style: .grouped)

    let windowWidth = UIWindow(frame: UIScreen.main.bounds).bounds.width - 60

    var awardsKey: [String] = []

    var awards: [Adwards] = []

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
        tableView.topAnchor ~= view.topAnchor
        tableView.leadingAnchor ~= view.leadingAnchor
        tableView.trailingAnchor ~= view.trailingAnchor
        tableView.bottomAnchor ~= view.bottomAnchor

        tableViewRegister()
        //tableView.contentInset = UIEdgeInsets(top: -35, left: 0, bottom: 0, right: 0)

        tableView.separatorStyle = .none
        tableView.allowsMultipleSelection = false
    }

    private func tableViewRegister() {
        tableView.register(RewardsCell.self, forCellReuseIdentifier: RewardsCell.reuseIdentifier)
        tableView.register(ExsRewardsCell.self, forCellReuseIdentifier: ExsRewardsCell.reuseIdentifier)
    }

    func setAwards(_ awards: [String: Adwards]) {
        awardsKey = []
        self.awards = []
        for (key, value) in awards {
            awardsKey.append(key)
            self.awards.append(value)
        }
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension RewardsSubViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return awardsKey.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if awardsKey[indexPath.row] == L10n.awardsResponseExclusiveRu {
            let cell = tableView.dequeueReusableCell(withIdentifier: ExsRewardsCell.reuseIdentifier, for: indexPath)
            if let cellAdwards = cell as? ExsRewardsCell {
                cellAdwards.setAwards(awardsKey[indexPath.row], award: awards[indexPath.row])
            }

            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: RewardsCell.reuseIdentifier, for: indexPath)
            if let cellAdwards = cell as? RewardsCell {
                cellAdwards.setAwards(awardsKey[indexPath.row], award: awards[indexPath.row])
            }

            return cell
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

}

// MARK: - UITableViewDelegate

extension RewardsSubViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
}
