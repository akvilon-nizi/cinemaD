//
// Created by akvilon-nizi on 23/11/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class SettingsPresenter {

    weak var view: SettingsViewInput!
    var interactor: SettingsInteractorInput!
    var router: SettingsRouterInput!
    weak var output: SettingsModuleOutput?
    var locationManager: LocationManagerProtocol!
    var authTokenManager: AuthTokenManagerProtocol!
}

// MARK: - SettingsViewOutput

extension SettingsPresenter: SettingsViewOutput {

    func viewIsReady() {
        log.verbose("Settings is ready")
    }

    func backButtonTap() {
        router.close()
    }

    func saveButtonTap(_ isLocation: Bool) {
        if UserDefaults.standard.bool(forKey: "isLocation") {
            if !isLocation {
                locationManager.stopMonitoringLocation()
            }
        } else {
            if isLocation {
                locationManager.startMonitoringLocation()
            }
        }
        UserDefaults.standard.set(isLocation, forKey: "isLocation")
        UserDefaults.standard.synchronize()
        router.close()
    }

    func logoutTap() {
        interactor.logout()
    }
}

// MARK: - SettingsInteractorOutput

extension SettingsPresenter: SettingsInteractorOutput {
    func getError() {
        view.showNetworkError(message: L10n.alertCinemaNetworkErrror)
    }

    func successLogout() {
        authTokenManager.removeApiToken()
        router.start()
    }
}
