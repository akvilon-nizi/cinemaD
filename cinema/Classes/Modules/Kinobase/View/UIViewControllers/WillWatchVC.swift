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
    func openCollection(id: String, name: String)
    func refreshes()
}

class WillWatchVC: ParentViewController {

    let tableView = UITableView(frame: CGRect.zero, style: .grouped)

    let windowWidth = UIWindow(frame: UIScreen.main.bounds).bounds.width - 60

    let windowWidth2 = (UIWindow(frame: UIScreen.main.bounds).bounds.width - 40) / 9 * 4

    var films: [Film] = []

    var collections: [Collection] = []

    weak var delegate: WillWatchVCDelegate?

    let headerViewTitle = HeaderViewTitle()

    let fullListFilms = FullListFilms()

    let filmGroup = FilmGroup()

    let headerSearchView = SearchCommonView()

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

        view.addSubview(tableView.prepareForAutoLayout())
        tableView.topAnchor ~= view.topAnchor
        tableView.leadingAnchor ~= view.leadingAnchor
        tableView.trailingAnchor ~= view.trailingAnchor
        tableView.bottomAnchor ~= view.bottomAnchor

        tableView.contentInset = UIEdgeInsets(top: -11, left: 0, bottom: 0, right: 0)

        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)

        headerViewTitle.title = "Фильмы"
        headerViewTitle.heightAnchor ~= 44

        fullListFilms.delegate = self
        fullListFilms.heightAnchor ~= 35

        filmGroup.delegate = self
        filmGroup.heightAnchor ~= windowWidth / 4 * 3 - 53.5
        filmGroup.films = films

        headerSearchView.delegate = self
        headerSearchView.heightAnchor ~= 48

        tableView.register(AdminCollectionCell.self, forCellReuseIdentifier: AdminCollectionCell.reuseIdentifier)

        tableView.separatorStyle = .none
    }

    func refresh() {
        delegate?.refreshes()
    }

    func setHeaderView() {

        let view = HeaderViewTitle()
        view.title = "Коллекции"

        var viewArray: [UIView] = []
        var height: CGFloat = 44

        if films.isEmpty {
            viewArray = [view]
            view.heightAnchor ~= 44
        } else {
            view.heightAnchor ~= 30
            height = windowWidth / 4 * 3 + 103.5
            viewArray = [headerViewTitle, fullListFilms, headerSearchView, filmGroup, view]
        }

        let stackView = createStackView(.vertical, .fill, .fill, 0, with: viewArray)
        stackView.widthAnchor ~= UIWindow(frame: UIScreen.main.bounds).bounds.width
        stackView.heightAnchor ~= height
        stackView.frame = CGRect(x: 0, y: 0, width: UIWindow(frame: UIScreen.main.bounds).bounds.width, height: height)
        tableView.tableHeaderView = stackView
    }

    func setFilms(_ films: [Film], collections: [Collection]) {
        self.films = films
        tableView.scrollsToTop = true
        setHeaderView()
        refreshControl.endRefreshing()
        self.collections = collections
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
        return collections.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AdminCollectionCell.reuseIdentifier, for: indexPath)
        if let collCel = cell as? AdminCollectionCell {
            var imageLink = ""
            if let imageUrl = collections[indexPath.row].imageUrl {
                imageLink = imageUrl
            }
            collCel.setInfo(name: collections[indexPath.row].name, imageUrl: imageLink)
        }
        return cell
    }

}

// MARK: - UITableViewDelegate

extension WillWatchVC: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.openCollection(id: collections[indexPath.row].id, name: collections[indexPath.row].name)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
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

extension WillWatchVC: SearchCommonDelegate {
    func changeText(_ text: String) {
        delegate?.getQuery(text)
    }
    func tapFilter() {
        delegate?.tapFilter()
    }
}
