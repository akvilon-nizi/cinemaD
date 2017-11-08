//
// Created by 1 on 07/11/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit

class FilterViewController: ParentViewController {

    var output: FilterViewOutput!

    let saveButton = UIButton()

    let tableView = UITableView(frame: CGRect.zero, style: .grouped)

    let genres: [String]

    let years: [String]

    var genresInd: [Int]

    var yearsInd: [Int]

    var sectionsOpen: [Bool] = [false, false]

    // MARK: - Life cycle

    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    init(genres: [String], years: [String], genresInd: [Int], yearsInd: [Int]) {
        self.genres = genres
        self.years = years
        self.genresInd = genresInd
        self.yearsInd = yearsInd
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

        saveButton.setImage(Asset.Kinobase.checkMini.image, for: .normal)
        saveButton.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
        saveButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -20)
        frame = saveButton.frame
        frame.size = CGSize(width: 30, height: 100)
        saveButton.frame = frame
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: saveButton)

        titleViewLabel.text = L10n.filterTitleText
        titleViewLabel.font = UIFont.cnmFutura(size: 20)

        tableView.backgroundColor = .white
        view.addSubview(tableView.prepareForAutoLayout())
        tableView.pinEdgesToSuperviewEdges()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()

        tableView.register(FilterCell.self, forCellReuseIdentifier: FilterCell.reuseIdentifier)
    }

    // MARK: - Actions
    func didTapLeftButton() {
        output?.backButtonTap()
    }

    func didTapSaveButton() {
        output?.addFilter(genresInd: genresInd, yearsInd: yearsInd)
    }

}

// MARK: - UITableViewDataSource

extension FilterViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if sectionsOpen[section] {
            if section == 0 {
                return 1
            } else {
                return genres.count
            }
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FilterCell.reuseIdentifier, for: indexPath)
        if let collCel = cell as? FilterCell {
            collCel.indexPath = indexPath
            collCel.title = indexPath.section == 0 ? "2017" : genres[indexPath.row]
            if indexPath.section == 1 {
                if !genresInd.isEmpty {
                    if indexPath.row == genresInd[0] {
                        collCel.isDidSelect = true
                    } else {
                        collCel.isDidSelect = false
                    }
                } else {
                    collCel.isDidSelect = false
                }
            }
            if indexPath.section == 0 {
                if !yearsInd.isEmpty {
                    if indexPath.row == yearsInd[0] {
                        collCel.isDidSelect = true
                    } else {
                        collCel.isDidSelect = false
                    }
                } else {
                    collCel.isDidSelect = false
                }
            }
        }
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let collectionCell = tableView.cellForRow(at: indexPath) as? FilterCell {
            collectionCell.isDidSelect = !collectionCell.isDidSelect
            if indexPath.section == 0 {
                if !yearsInd.isEmpty && indexPath.row == yearsInd[0] {
                    yearsInd = []
                } else {
                    yearsInd = [indexPath.row]
                }
            } else {
                if !genresInd.isEmpty && indexPath.row == yearsInd[0] {
                    genresInd = []
                } else {
                     genresInd = [indexPath.row]
                }
            }
            tableView.beginUpdates()
            tableView.reloadSections(IndexSet(integersIn: indexPath.section...indexPath.section), with: UITableViewRowAnimation.none)
            tableView.endUpdates()
            UIView.setAnimationsEnabled(true)

        }
    }

}

// MARK: - UITableViewDelegate

extension FilterViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = HeaderViewOpenned()
        view.tag = section
        view.isOpen = sectionsOpen[section]
        view.delegate = self
        view.title = section == 0 ? L10n.filterFilter1Title : L10n.filterFilter2Title
        return view
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
}

// MARK: - FilterViewInput

extension FilterViewController: FilterViewInput {

    func setupInitialState() {

    }
}

// MARK: - HeaderViewOpennedDelegate

extension FilterViewController: HeaderViewOpennedDelegate {

    func open(isOpen: Bool, section: Int) {
        sectionsOpen[section] = isOpen
        UIView.setAnimationsEnabled(false)
        tableView.beginUpdates()
        tableView.reloadSections(IndexSet(integersIn: section...section), with: UITableViewRowAnimation.none)
        tableView.endUpdates()
        UIView.setAnimationsEnabled(true)
    }
}
