//
//  WatchedVC.swift
//  cinema
//
//  Created by User on 31.10.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

protocol WatchedFilmDelegate: class {
    func openFullAlls(_ films: [Film])
    func openCollectionFromId(id: String)
    func removeCollectionFromId(id: String)
    func newCollection()
    func settingsCollection(id: String, name: String)
    func openFilmID(_ filmID: String, name: String)
    func refresh()
    func getQueryWatched(_ query: String)
    func tapFilterWatched()
}

class WatchedVC: ParentViewController {

    let refreshControl = UIRefreshControl()

    let tableView = UITableView(frame: CGRect.zero, style: .plain)

    let windowWidth = UIWindow(frame: UIScreen.main.bounds).bounds.width - 60

    let windowWidth2 = (UIWindow(frame: UIScreen.main.bounds).bounds.width - 40) / 9 * 4

    var colHeaderTitle: String = ""
    var colFilms: [Film] = []

    var films: [Film] = []
    var collections: [Collection] = []
    var selectedIndex: Int?

    var heightLayout: NSLayoutConstraint?

    var searchHeightLayout: NSLayoutConstraint?

    var widthLayout: NSLayoutConstraint?

    var currentHeight: CGFloat = 0

    var fixHeight: CGFloat = 0

    var heightFilmGroup: CGFloat = 0

    var stackView = UIStackView()

    let searchFilmGroup = FilmGroup()

    var tableSizeHeight: CGFloat = 0

    var query: String = ""

    let headerSearchView = SearchCommonView()

    var isRefresh = false

//    var isFirstStart = true

    weak var delegate: WatchedFilmDelegate?

    // MARK: - Life cycle

    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView.prepareForAutoLayout())
        tableView.topAnchor ~= view.topAnchor
        tableView.leadingAnchor ~= view.leadingAnchor
        tableView.trailingAnchor ~= view.trailingAnchor
        tableView.bottomAnchor ~= view.bottomAnchor

        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)

        tableView.register(CollectionCell.self, forCellReuseIdentifier: CollectionCell.reuseIdentifier)

        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self

        tableView.separatorStyle = .none

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
        tableView.tableHeaderView = stackView
        tableView.tableHeaderView?.frame = CGRect(x: 0, y: 0, width: UIWindow(frame: UIScreen.main.bounds).bounds.width, height: currentHeight)

        tableSizeHeight = tableView.contentSize.height
    }

    func setFilmsAndCol(_ films: [Film], col: [Collection]) {
        if isRefresh {
            searchFilmGroup.films = []
            headerSearchView.removeQuery()
           // headerSearchView.hiddenActivityVC()
        }
        self.films = films.reversed()
        self.collections = col
        colFilms = []
        selectedIndex = nil
        setHeaderView()
        tableView.reloadData()
        refreshControl.endRefreshing()
    }

    func openCollection(_ collection: Collection) {
        colHeaderTitle = collection.name
        colFilms = []
        if let colFilmsArray = collection.films {
            for filmColW in colFilmsArray {
                var rate: Int = 0
                if let rating = filmColW.rate {
                    rate = Int(rating)
                }
                let film = Film(id: filmColW.id, name: filmColW.name, imageUrl: filmColW.imageUrl, rate: Double(rate))
                colFilms.append(film)
            }
        }
        UIView.setAnimationsEnabled(false)
        tableView.beginUpdates()
        tableView.reloadSections(IndexSet(integersIn: 0...2), with: UITableViewRowAnimation.none)
        tableView.endUpdates()
        UIView.setAnimationsEnabled(true)

        var offset = tableView.contentOffset
        offset.y = tableView.contentSize.height - tableView.frame.size.height
        tableView.setContentOffset(offset, animated: true)
    }

    func refresh() {
        isRefresh = true
        delegate?.refresh()
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

        if isRefresh {
            isRefresh = false
        } else {
            tableView.reloadData()
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        }

    }

    func setStackViewHeight() {
        heightLayout?.constant = currentHeight
        //tableView.tableHeaderView = stackView
        UIView.animate(withDuration: 0) {
            self.stackView.layoutIfNeeded()
        }
        tableView.tableHeaderView?.frame = CGRect(x: 0, y: 0, width: UIWindow(frame: UIScreen.main.bounds).bounds.width, height: currentHeight)
       // UIView.animate(withDuration: 0) {
//            tableView.layoutSubviews()
//            tableView.layoutIfNeeded()
      //  }
    }
}

// MARK: - UITableViewDataSource

extension WatchedVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return collections.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CollectionCell.reuseIdentifier, for: indexPath)
            if let collCel = cell as? CollectionCell {
                collCel.indexPath = indexPath.row
                collCel.title = collections[indexPath.row].name
                collCel.delegate = self
            }
            return cell
        }

        let cell = UITableViewCell()

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if ((tableView.cellForRow(at: indexPath) as? CollectionCell) != nil), selectedIndex != indexPath.row {
            selectedIndex = indexPath.row
            delegate?.openCollectionFromId(id: collections[indexPath.row].id)
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

}

// MARK: - UITableViewDelegate

extension WatchedVC: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 44
        }
        return 0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let view = MakeNewCollections()
            view.delegate = self
            return view
        case 1:
            if colFilms.isEmpty {
                return UIView()
            }
            let view = HeaderViewTitle()
            view.title = colHeaderTitle
            view.withoutLine()
            return view
        case 2:
//            if colFilms.count < 1 {
//                return UIView()
//            }
            let view = FilmGroup()
            view.films = colFilms
            view.delegate = self
            return view
        default:
            return UIView()
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 55
        case 1:
            if colFilms.isEmpty {
                return 1
            }
            return 44
        case 2:
            if colFilms.count < 1 {
                return 1
            }
            return windowWidth / 4 * 3 - 80
        default:
            return 1
        }
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}

extension WatchedVC: FullListFilmsDelegate {
    func openFullList() {
        delegate?.openFullAlls(films)
    }
}

extension WatchedVC: MakeNewCollDelegate {
    func newCollections() {
        delegate?.newCollection()
    }
}

// MARK: - FilmGroupDelegate
extension WatchedVC: FilmGroupDelegate {
    func openFilmID(_ filmID: String, name: String) {
        delegate?.openFilmID(filmID, name: name)
    }

    func changeStatusFilm(_ film: Film, isAdd: Bool) {

    }
}

extension WatchedVC: CollectionCellDelegate {
    func tapButtonSetting(_ index: Int) {
        delegate?.settingsCollection(id: collections[index].id, name: collections[index].name)
    }
}

// MARK: - SearchCommonDelegate

extension WatchedVC: SearchCommonDelegate {
    func changeText(_ text: String) {
        if text.count >= 2 {
            if text == query {
                return
            }
            delegate?.getQueryWatched(text)
        } else {
            if searchFilmGroup.films.isEmpty && query.isEmpty {

            } else {
                getSearch([])
            }
        }
        self.query = text
    }

    func tapFilter() {
//        delegate?.tapFilter()
    }
}
