//
// Created by akvilon-nizi on 31/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit

class NewCollectionsViewController: ParentViewController {

    var output: NewCollectionsViewOutput!

    var nameCollections: String = ""

    var watched: [Film] = []

    let headerCollectionsView = HeaderCollectionsView()

    private let tableView = UITableView(frame: CGRect.zero, style: .grouped)

    let windowWidth = UIWindow(frame: UIScreen.main.bounds).bounds.width - 60

    // MARK: - Life cycle

    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()

        view.backgroundColor = .white

        let backButton = UIButton()
        backButton.setImage(Asset.NavBar.navBarArrowBack.image, for: .normal)
        backButton.addTarget(self, action: #selector(didTapLeftButton), for: .touchUpInside)
        backButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        var frame = backButton.frame
        frame.size = CGSize(width: 30, height: 100)
        backButton.frame = frame
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)

        let saveButton = UIButton()
        saveButton.setImage(Asset.Kinobase.checkMini.image, for: .normal)
        saveButton.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
        saveButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -20)
        frame = saveButton.frame
        frame.size = CGSize(width: 30, height: 100)
        saveButton.frame = frame
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: saveButton)

        titleViewLabel.text = nameCollections == "" ? "Новая коллекция" : nameCollections
        titleViewLabel.font = UIFont.cnmFutura(size: 20)

        tableView.backgroundColor = .white
        view.addSubview(tableView.prepareForAutoLayout())
        tableView.pinEdgesToSuperviewEdges()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }

    // MARK: - Actions
    func didTapLeftButton() {
        output?.backButtonTap()
    }

    func didTapSaveButton() {
        if headerCollectionsView.returnTitle().characters.count > 3 {

        } else {
            showAlert(message: "Имя коллекции должно быть больше 3 символов")
        }
    }

}

// MARK: - UITableViewDataSource

extension NewCollectionsViewController: UITableViewDataSource {

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

extension NewCollectionsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
//            if films.isEmpty {
//                return nil
//            }
            if !nameCollections.isEmpty {
                headerCollectionsView.title = nameCollections
            }
            return headerCollectionsView
        case 1:
//            if films.isEmpty {
//                return nil
//            }
            let view = HeaderViewTitle()
            view.title = "Коллекция"
            return view
        case 2:
//            if films.isEmpty {
//                return nil
//            }
            let view = FilmGroup()
//            view.films = films
            //            view.delegate = self
            return view
        case 3:
            //            if films.isEmpty {
            //                return nil
            //            }
            let view = HeaderViewTitle()
            view.title = "Избранное"
            return view

        case 4:
            //            if films.isEmpty {
            //                return nil
            //            }
            let view = FilmGroup()
            view.films = watched
            view.isCollections = true
            view.isAdd = true
            //            view.delegate = self
            return view
        default:
            return nil
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 88
        case 1:
            return 22
        case 2:
//            if films.isEmpty {
//                return 0
//            }
            return windowWidth / 4 * 3 - 80
        case 3:
            //            if films.isEmpty {
            //                return 0
            //            }
            return 22
        case 4:
            //            if films.isEmpty {
            //                return 0
            //            }
            return windowWidth / 4 * 3 - 80
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
}

// MARK: - NewCollectionsViewInput

extension NewCollectionsViewController: NewCollectionsViewInput {

    func setupInitialState() {

    }
}
