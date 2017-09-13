//
// Created by Александр Масленников on 10.08.17.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import CoreLocation

protocol LocationManagerProtocol {

    var location: CLLocation? { get }

    weak var output: LocationManagerOutput? { get set }

    func startMonitoringLocation()

    func stopMonitoringLocation()
}

protocol LocationManagerOutput: class {

    func didUpdate(location: CLLocation?)
}

class LocationManager: NSObject, LocationManagerProtocol {

    weak var output: LocationManagerOutput?

    fileprivate(set) var location: CLLocation? {
        didSet {
            output?.didUpdate(location: location)
        }
    }

    private let locationManager = CLLocationManager()

    override init() {
        super.init()

        locationManager.delegate = self
    }

    func startMonitoringLocation() {
        log.info("Start monitoring location")

        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()

        location = locationManager.location
        locationManager.requestLocation()
    }

    func stopMonitoringLocation() {
        log.info("Stop monitoring location")

        locationManager.stopMonitoringSignificantLocationChanges()
    }
}

// MARK: - CLLocationManagerDelegate

extension LocationManager: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.last
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        log.debug("Change authorization status: \(status.rawValue)")

        switch status {
        case .notDetermined, .denied, .restricted:
            location = nil
        default:
            manager.requestLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        log.error("Location manager error: \(error)")
    }
}
