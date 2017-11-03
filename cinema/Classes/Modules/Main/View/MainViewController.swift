//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit
import RxMoya
import RxSwift

class MainViewController: ParentViewController {

    var output: MainViewOutput!

    let header = MainVCHeader()

    var provider: RxMoyaProvider<FoodleTarget>!

    let tableView = UITableView(frame: CGRect.zero, style: .grouped)

    let windowWidth = UIWindow(frame: UIScreen.main.bounds).bounds.width - 60

    let windowWidth2 = (UIWindow(frame: UIScreen.main.bounds).bounds.width - 40) / 9 * 4

    var mainData = MainData()
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

        view.addSubview(mainTabView.prepareForAutoLayout())
        mainTabView.widthAnchor ~= view.widthAnchor
        mainTabView.heightAnchor ~= 80
        mainTabView.leadingAnchor ~= view.leadingAnchor
        mainTabView.bottomAnchor ~= view.bottomAnchor

        view.addSubview(tableView.prepareForAutoLayout())
        tableView.topAnchor ~= view.topAnchor
        tableView.leadingAnchor ~= view.leadingAnchor
        tableView.trailingAnchor ~= view.trailingAnchor
        tableView.bottomAnchor ~= mainTabView.topAnchor

        mainTabView.delegate = self

        view.bringSubview(toFront: activityVC)
        activityVC.isHidden = false
        activityVC.startAnimating()
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
        return 0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            if mainData.trailers.isEmpty {
                return nil
            }
            header.trailers = mainData.trailers
            return header
        case 1:
            if mainData.now.isEmpty {
                return nil
            }
            let view = HeaderViewTitle()
            view.title = "Сейчас в кино"
            return view
        case 2:
            if mainData.now.isEmpty {
                return nil
            }
            let view = FilmGroup()
            view.films = mainData.now
            view.delegate = self
            return view
        case 3:
            if mainData.recomend.isEmpty {
                return nil
            }
            let view = HeaderViewTitle()
            view.title = "Рекомендации"
            return view
        default:
            if mainData.recomend.isEmpty {
                return nil
            }
            let view = FilmGroup()
            view.films = mainData.recomend
            view.delegate = self
            return view
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            if mainData.trailers.isEmpty {
                return 0
            }
            return windowWidth / 4 * 3 + 20
        case 1:
            if mainData.now.isEmpty {
                return 0
            }
            return 27
        case 2:
            if mainData.now.isEmpty {
                return 0
            }
            return windowWidth2
        case 3:
            if mainData.recomend.isEmpty {
                return 0
            }
            return 27
        default:
            if mainData.recomend.isEmpty {
                return 0
            }
            return windowWidth2
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

    func getError() {
        showAlert(message: L10n.alertCinemaNetworkErrror)
        activityVC.isHidden = true
        activityVC.stopAnimating()
    }
    func getData(_ mainData: MainData) {
        self.mainData = mainData
        activityVC.isHidden = true
        activityVC.stopAnimating()
        tableView.reloadData()
//        view.getData(mainData)
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
        output.openKinobase()
    }
}

// MARK: - FilmGroupDelegate
extension MainViewController: FilmGroupDelegate {
    func openFilmID(_ filmID: String, name: String) {
        output.openFilm(videoID: filmID, name: name)
    }
}
