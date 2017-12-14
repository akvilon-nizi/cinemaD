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

    let tableView = UITableView(frame: CGRect.zero, style: .grouped)

    let windowWidth = UIWindow(frame: UIScreen.main.bounds).bounds.width - 60

    let windowWidth2 = (UIWindow(frame: UIScreen.main.bounds).bounds.width - 40) / 9 * 4

    var colHeaderTitle: String = ""
    var colFilms: [Film] = []

    var films: [Film] = []
    var collections: [Collection] = []
    var selectedIndex: Int?

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

        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self

        view.addSubview(tableView.prepareForAutoLayout())
        tableView.topAnchor ~= view.topAnchor
        tableView.leadingAnchor ~= view.leadingAnchor
        tableView.trailingAnchor ~= view.trailingAnchor
        tableView.bottomAnchor ~= view.bottomAnchor
        tableView.separatorStyle = .none

        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)

        tableView.register(CollectionCell.self, forCellReuseIdentifier: CollectionCell.reuseIdentifier)
    }

    func setHeaderTableView() {
//        switch section {
//        case 4:
//            if films.isEmpty {
//                return nil
//            }
//            let view = HeaderViewTitle()
//            view.title = "Коллекции"
//            return view
//        case 5:
//            if films.isEmpty {
//                return nil
//            }
//            let view = MakeNewCollections()
//            view.delegate = self
//            return view
//        case 6:
//            if colFilms.isEmpty {
//                return nil
//            }
//            let view = HeaderViewTitle()
//            view.title = colHeaderTitle
//            view.withoutLine()
//            return view
//        case 7:
//            //            if colFilms.count < 1 {
//            //                return UIView()
//            //            }
//            let view = FilmGroup()
//            view.films = colFilms
//            view.delegate = self
//            return view
//        case 0:
//            if films.isEmpty {
//                return nil
//            }
//            let view = HeaderViewTitle()
//            view.title = "Фильмы"
//            return view
//        case 1:
//            if films.isEmpty {
//                return nil
//            }
//            let view = FullListFilms()
//            view.delegate = self
//            return view
//        case 3:
//            if films.isEmpty {
//                return nil
//            }
//            let view = FilmGroup()
//            view.films = films
//            view.delegate = self
//            return view
//        case 2:
//            if films.isEmpty {
//                return nil
//            }
//            let view = HeaderSearchView()
//            view.delegate = self
//            return view
//        default:
//            return nil
//        }

//        switch section {
//        case 4:
//            return 22
//        case 5:
//            return 55
//        case 6:
//            if colFilms.isEmpty {
//                return 1
//            }
//            return 22
//        case 7:
//            if colFilms.count < 1 {
//                return 1
//            }
//            return windowWidth / 4 * 3 - 80
//        case 0:
//            if films.isEmpty {
//                return 0.1
//            }
//            return 22
//        case 1:
//            return 22
//        case 2:
//            return 33
//        case 3:
//            if films.isEmpty {
//                return 0
//            }
//            return windowWidth / 4 * 3 - 80
//
//        default:
//            return 0
//        }
    }

    func setFilmsAndCol(_ films: [Film], col: [Collection]) {
        self.films = films
        self.collections = col
        colFilms = []
        selectedIndex = nil
        tableView.reloadData()
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
                let film = Film(id: filmColW.id, name: filmColW.name, imageUrl: filmColW.imageUrl, rate: rate)
                colFilms.append(film)
            }
        }
        UIView.setAnimationsEnabled(false)
        tableView.beginUpdates()
        tableView.reloadSections(IndexSet(integersIn: 5...7), with: UITableViewRowAnimation.none)
        tableView.endUpdates()
        UIView.setAnimationsEnabled(true)

        var offset = tableView.contentOffset
        offset.y = tableView.contentSize.height - tableView.frame.size.height
        tableView.setContentOffset(offset, animated: true)
    }

    func refresh() {
        delegate?.refresh()
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

extension WatchedVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 5 {
            return collections.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 5 {
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
        return 8
    }

}

// MARK: - UITableViewDelegate

extension WatchedVC: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 5 {
            return 44
        }
        return 0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 4:
            if films.isEmpty {
                return nil
            }
            let view = HeaderViewTitle()
            view.title = "Коллекции"
            return view
        case 5:
            if films.isEmpty {
                return nil
            }
            let view = MakeNewCollections()
            view.delegate = self
            return view
        case 6:
            if colFilms.isEmpty {
                return nil
            }
            let view = HeaderViewTitle()
            view.title = colHeaderTitle
            view.withoutLine()
            return view
        case 7:
//            if colFilms.count < 1 {
//                return UIView()
//            }
            let view = FilmGroup()
            view.films = colFilms
            view.delegate = self
            return view
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
        case 4:
            return 22
        case 5:
            return 55
        case 6:
            if colFilms.isEmpty {
                return 1
            }
            return 22
        case 7:
            if colFilms.count < 1 {
                return 1
            }
            return windowWidth / 4 * 3 - 80
        case 0:
            if films.isEmpty {
                return 0.1
            }
            return 22
        case 1:
            return 22
        case 2:
            return 33
        case 3:
            if films.isEmpty {
                return 0
            }
            return windowWidth / 4 * 3 - 80

        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
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
}

extension WatchedVC: CollectionCellDelegate {
    func tapButtonSetting(_ index: Int) {
        delegate?.settingsCollection(id: collections[index].id, name: collections[index].name)
    }
}

// MARK: - FilmGroupDelegate

extension WatchedVC: HeaderSearchDelegate {
    func changeText(_ text: String) {
        delegate?.getQueryWatched(text)
    }
    func tapFilter() {
        delegate?.tapFilterWatched()
    }
}
