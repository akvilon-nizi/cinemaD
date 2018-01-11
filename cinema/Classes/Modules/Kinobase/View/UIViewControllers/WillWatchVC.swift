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

    let tableView = UITableView(frame: CGRect.zero, style: .plain)

    let windowWidth = UIWindow(frame: UIScreen.main.bounds).bounds.width - 60

    let windowWidth2 = (UIWindow(frame: UIScreen.main.bounds).bounds.width - 40) / 9 * 4

    var films: [Film] = []

    var collections: [Collection] = []

    var widthLayout: NSLayoutConstraint?

    var fixHeight: CGFloat = 0

    var isRefresh = false

    weak var delegate: WillWatchVCDelegate?

    let refreshControl = UIRefreshControl()

    var heightLayout: NSLayoutConstraint?

    var searchHeightLayout: NSLayoutConstraint?

    var currentHeight: CGFloat = 0

    var heightFilmGroup: CGFloat = 0

    var stackView = UIStackView()

    let searchFilmGroup = FilmGroup()

    var query: String = ""

    let headerSearchView = SearchCommonView()

    // MARK: - Life cycle

    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.layoutIfNeeded()
        view.layoutSubviews()
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

        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)

        tableView.register(AdminCollectionCell.self, forCellReuseIdentifier: AdminCollectionCell.reuseIdentifier)

        tableView.separatorStyle = .none

        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)

        self.automaticallyAdjustsScrollViewInsets = false
    }

    func refresh() {
        isRefresh = true
        delegate?.refreshes()
    }

    func setHeaderView() {

        let headerViewTitle = HeaderViewTitle()

        let fullListFilms = FullListFilms()

        let filmGroup = FilmGroup()

        heightFilmGroup = windowWidth / 4 * 3 - 53.5

        headerViewTitle.title = "Фильмы"
        headerViewTitle.heightAnchor ~= 44

        fullListFilms.delegate = self
        fullListFilms.heightAnchor ~= 35

        searchFilmGroup.delegate = self
        searchHeightLayout = searchFilmGroup.heightAnchor.constraint(equalToConstant: 0)
        searchHeightLayout?.isActive = true

        filmGroup.delegate = self
        filmGroup.heightAnchor ~= heightFilmGroup
        filmGroup.films = films

        headerSearchView.delegate = self
        headerSearchView.heightAnchor ~= 48

        let view = HeaderViewTitle()
        view.title = "Коллекции"

        var viewArray: [UIView] = []

        if films.isEmpty {
            currentHeight = 92 - 22
            viewArray = [headerSearchView, searchFilmGroup, view]
            view.heightAnchor ~= 44
        } else {
            view.heightAnchor ~= 30
            currentHeight = windowWidth / 4 * 3 + 103.5 - 22
            viewArray = [headerSearchView, searchFilmGroup, headerViewTitle, fullListFilms, filmGroup, view]
        }

        fixHeight = currentHeight

        stackView = createStackView(.vertical, .fill, .fill, 0, with: viewArray)
        widthLayout = stackView.widthAnchor.constraint(equalToConstant: UIWindow(frame: UIScreen.main.bounds).bounds.width)
        widthLayout?.isActive = true
        heightLayout = stackView.heightAnchor.constraint(equalToConstant: currentHeight)
        heightLayout?.isActive = true
//        stackView.frame = CGRect(x: 0, y: 0, width: UIWindow(frame: UIScreen.main.bounds).bounds.width, height: currentHeight)
        tableView.tableHeaderView = stackView
        tableView.tableHeaderView?.frame = CGRect(x: 0, y: 0, width: UIWindow(frame: UIScreen.main.bounds).bounds.width, height: currentHeight)

        //searchFilmGroup.isHidden = true
    }

    func setStackViewHeight() {
        heightLayout?.constant = currentHeight
        //tableView.tableHeaderView = stackView
        UIView.animate(withDuration: 0) {
            self.stackView.layoutIfNeeded()
        }
        tableView.tableHeaderView?.frame = CGRect(x: 0, y: 0, width: UIWindow(frame: UIScreen.main.bounds).bounds.width, height: currentHeight)
    }

    func setFilms(_ films: [Film], collections: [Collection]) {
        if isRefresh {
            searchFilmGroup.films = []
            headerSearchView.removeQuery()
            // headerSearchView.hiddenActivityVC()
        }
        self.films = films.reversed()
        setHeaderView()
        self.collections = collections
        tableView.reloadData()
        refreshControl.endRefreshing()
    }

    func getSearch(_ films: [Film]) {
        headerSearchView.hiddenActivityVC()
        if searchFilmGroup.films.isEmpty && !films.isEmpty {
            searchHeightLayout?.constant = heightFilmGroup
            UIView.animate(withDuration: 0) {
                self.stackView.layoutIfNeeded()
            }
            currentHeight += heightFilmGroup
            setStackViewHeight()
        }

        if !searchFilmGroup.films.isEmpty && films.isEmpty {
            searchHeightLayout?.constant = 0
            UIView.animate(withDuration: 0) {
                self.stackView.layoutIfNeeded()
            }
            currentHeight = fixHeight
            setStackViewHeight()
        }

        searchFilmGroup.films = films
        searchFilmGroup.gotoStart()

        if isRefresh {
            isRefresh = false
        } else {
            tableView.reloadData()
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        }
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
        return 35
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

    func changeStatusFilm(_ film: Film, isAdd: Bool) {

    }
}

// MARK: - FilmGroupDelegate

extension WillWatchVC: SearchCommonDelegate {
    func changeText(_ text: String) {
        if text.count >= 1 {
            if text == query {
                return
            }
            delegate?.getQuery(text)
        } else {
            delegate?.getQuery(text)
            if searchFilmGroup.films.isEmpty && query.isEmpty {

            } else {
                getSearch([])
            }
        }
        self.query = text
    }
    func tapFilter() {
        delegate?.tapFilter()
    }
}
