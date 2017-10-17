//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit

class MainViewController: ParentViewController {

    var output: MainViewOutput!

    let header = MainVCHeader()

    let tableView = UITableView(frame: CGRect.zero, style: .grouped)

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
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self

        view.addSubview(tableView.prepareForAutoLayout())
        tableView.topAnchor ~= view.topAnchor
        tableView.leadingAnchor ~= view.leadingAnchor
        tableView.trailingAnchor ~= view.trailingAnchor
        tableView.bottomAnchor ~= mainTabView.topAnchor

        mainTabView.delegate = self
    }
}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()

//        cell.setData(products[indexPath.row])
//        cell.delegate = self

        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }

}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            return header
        case 1:
            let view = HeaderViewTitle()
            view.title = "Сейчас в кино"
            return view
        case 2:
            return FilmGroup()
        case 3:
            let view = HeaderViewTitle()
            view.title = "Рекомендации"
            return view
        default:
            return FilmGroup()
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 280
        case 1:
            return 55
        case 2:
            return 240
        case 3:
            return 55
        default:
            return 240
        }
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
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
