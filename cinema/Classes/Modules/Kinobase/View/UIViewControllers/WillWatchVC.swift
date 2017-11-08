//
//  WillWatchVC.swift
//  cinema
//
//  Created by Mac on 31.10.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

protocol WillWatchVCDelegate: class {
    func openFullList(_ films: [Film])
    func openFilmId(_ filmID: String, name: String)
    func getQuery(_ query: String)
    func tapFilter()
}

class WillWatchVC: ParentViewController {

    let tableView = UITableView(frame: CGRect.zero, style: .grouped)

    let windowWidth = UIWindow(frame: UIScreen.main.bounds).bounds.width - 60

    let windowWidth2 = (UIWindow(frame: UIScreen.main.bounds).bounds.width - 40) / 9 * 4

    var films: [Film] = []

    weak var delegate: WillWatchVCDelegate?

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

extension WillWatchVC: UITableViewDataSource {

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
        return 4
    }

}

// MARK: - UITableViewDelegate

extension WillWatchVC: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            if films.isEmpty {
                return nil
            }
            let view = HeaderViewTitle()
            view.title = "Фильмы"
            return view
        case 1:
            if films.isEmpty {
                return nil
            }
            let view = FullListFilms()
            view.delegate = self
            return view
        case 3:
            if films.isEmpty {
                return nil
            }
            let view = FilmGroup()
            view.films = films
            view.delegate = self
            return view
        case 2:
            if films.isEmpty {
                return nil
            }
            let view = HeaderSearchView()
            view.delegate = self
            return view
        default:
            return nil
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 22
        case 1:
            return 22
        case 3:
            if films.isEmpty {
                return 0
            }
            return windowWidth / 4 * 3 - 80
        case 2:
            return 33
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
}

extension WillWatchVC: FullListFilmsDelegate {
    func openFullList() {
        delegate?.openFullList(films)
    }
}

// MARK: - FilmGroupDelegate
extension WillWatchVC: FilmGroupDelegate {
    func openFilmID(_ filmID: String, name: String) {
        delegate?.openFilmId(filmID, name: name)
    }
}

// MARK: - FilmGroupDelegate

extension WillWatchVC: HeaderSearchDelegate {
    func changeText(_ text: String) {
        delegate?.getQuery(text)
    }
    func tapFilter() {
        delegate?.tapFilter()
    }
}
