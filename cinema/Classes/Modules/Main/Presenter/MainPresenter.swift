//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class MainPresenter {

    weak var view: MainViewInput!
    var interactor: MainInteractorInput!
    var router: MainRouterInput!
    weak var output: MainModuleOutput?
    var locationManager: LocationManagerProtocol

    init(locationManager: LocationManagerProtocol) {
        self.locationManager = locationManager
        self.locationManager.output = self
    }
}

// MARK: - MainViewOutput

extension MainPresenter: MainViewOutput {
    func refresh() {
        interactor.getData()
    }

    func openProfile(mainView: MainTabView) {
        router.openProfile(mainView: mainView)
    }

    func openRewards() {
        router.openRewards()
    }

    func tapNews(newsID: String) {
        router.openNews(newsID: newsID)
    }

    func setRootVC(_ rootVC: UINavigationController) {
        router.setRootVC(rootVC)
    }

    func viewIsReady() {
        log.verbose("Main is ready")
        interactor.getData()
    }

    func openFilm(videoID: String, name: String) {
        router.openFilm(videoId: videoID, name: name)
    }

    func openKinobase() {
        router.openKinobase()
    }

    func changeFilter(_ filters: [String]) {
        interactor.getNewsWithFilters(filters: filters)
    }

}

// MARK: - MainInteractorOutput

extension MainPresenter: MainInteractorOutput {
    func tokenError() {
        router.openStart()
    }

    func getError() {
        view.getError()
    }
    func getData(mainData: MainData) {
        view.getData(mainData)
        if UserDefaults.standard.bool(forKey: "isLocation") {
            locationManager.startMonitoringLocation()
        } else {
            locationManager.stopMonitoringLocation()
        }
    }

    func getNews(mainData: MainData) {
        view.getNews(mainData)
    }
}

// MARK: - MainInteractorOutput

extension MainPresenter: LocationManagerOutput {
    func didUpdate(location: CLLocation?) {
        if let loc = location {
            interactor.postLocation(lat: Double(loc.coordinate.latitude), log: Double(loc.coordinate.longitude))
        }
    }
}
