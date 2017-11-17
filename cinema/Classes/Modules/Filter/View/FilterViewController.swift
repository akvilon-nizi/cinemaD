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

    let years: [Int]

    var sectionsOpen: [Bool] = [false, false]

    var yearsOpen: [Bool] = []
    var genresOpen: [Bool] = []

    // MARK: - Life cycle

    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    init(genres: [String], years: [Int], genresInd: [Int], yearsInd: [Int]) {
        self.genres = genres
        self.years = years

        for i in 0..<self.years.count {
            if yearsInd.contains(i) {
                yearsOpen.append(true)
            } else {
                yearsOpen.append(false)
            }
        }
        for i in 0..<genres.count {
            if genresInd.contains(i) {
                genresOpen.append(true)
            } else {
                genresOpen.append(false)
            }
        }
        super.init(nibName: nil, bundle: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
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
        tableView.separatorStyle = .none

        tableView.register(FilterCell.self, forCellReuseIdentifier: FilterCell.reuseIdentifier)
    }

    // MARK: - Actions
    func didTapLeftButton() {
        output?.backButtonTap()
    }

    func didTapSaveButton() {
        var yearsInd: [Int] = []
        var genresInd: [Int] = []
        for i in 0..<genresOpen.count {
            if genresOpen[i] {
                genresInd.append(i)
            }
        }
        for i in 0..<yearsOpen.count {
            if yearsOpen[i] {
                yearsInd.append(i)
            }
        }
        output?.addFilter(genresInd: genresInd, yearsInd: yearsInd)
    }

}

// MARK: - UITableViewDataSource

extension FilterViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if sectionsOpen[section] {
            if section == 0 {
                return years.count
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
            collCel.title = indexPath.section == 0 ? String(years[indexPath.row]) : genres[indexPath.row]
            if indexPath.section == 1 {
                collCel.isDidSelect = genresOpen[indexPath.row]
            }
            if indexPath.section == 0 {
                collCel.isDidSelect = yearsOpen[indexPath.row]
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
                yearsOpen[indexPath.row] = collectionCell.isDidSelect
            } else {
                genresOpen[indexPath.row] = collectionCell.isDidSelect
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
