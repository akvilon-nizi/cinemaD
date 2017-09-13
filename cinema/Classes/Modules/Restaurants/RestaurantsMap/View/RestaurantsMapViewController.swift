//
// Created by Alexander Maslennikov on 25/07/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps

class RestaurantsMapViewController: ParentViewController {

    var output: RestaurantsMapViewOutput!

    fileprivate let mapView = GMSMapView()
    fileprivate let locateButton = UIButton(type: .custom)
    fileprivate let swipeableCards = SwipeableCards()

    fileprivate var userCoordinate: CLLocationCoordinate2D? {
        didSet {
            if let coordinate = userCoordinate {
                userMarker.position = coordinate
                userMarker.map = mapView
            } else {
                userMarker.map = nil
            }
            locateButton.isHidden = userCoordinate == nil
        }
    }
    fileprivate lazy var userMarker: GMSMarker = {
        let marker = GMSMarker()
        marker.icon = Asset.Map.mapPinIconMyGeo.image
        return marker
    }()

    fileprivate var displayItems: [RestaurantsDisplayItem] = []
    fileprivate var markers: [GMSMarker] = []
    fileprivate var currentAnnotationIndex: Int = 0
    fileprivate var currentMarker: GMSMarker?

    fileprivate var locateButtonBottom: NSLayoutConstraint?
    fileprivate let mapBottomPadding: CGFloat = 144

    // MARK: - Life cycle

    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.titleView = UIImageView(image: (Asset.NavBar.navBarLogo.image).withRenderingMode(.alwaysTemplate))

        let menuButton = UIButton(type: .system)
        menuButton.setImage(Asset.NavBar.navBarMenu.image, for: .normal)
        menuButton.sizeToFit()
        menuButton.addTarget(self, action: #selector(handleMenuButtonTapped), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: menuButton)

        let listButton = UIButton(type: .system)
        listButton.addTarget(self, action: #selector(handleListButtonPressed), for: .touchUpInside)
        listButton.setImage(Asset.NavBar.navBarList.image, for: .normal)
        listButton.sizeToFit()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: listButton)

        mapView.delegate = self
        mapView.padding = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        if let styleURL = Bundle.main.url(forResource: "mapStyle", withExtension: "json") {
            mapView.mapStyle = try? GMSMapStyle(contentsOfFileURL: styleURL)
        }
        view.addSubview(mapView.prepareForAutoLayout())
        mapView.pinEdgesToSuperviewEdges()

        locateButton.addTarget(self, action: #selector(handleLocateButtonPressed), for: .touchUpInside)
        locateButton.setImage(Asset.Map.mapButtonMyGeo.image, for: .normal)
        locateButton.backgroundColor = UIColor.fdlWarmGrey.withAlphaComponent(0.4)
        locateButton.layer.cornerRadius = 22
        locateButton.isHidden = true
        view.addSubview(locateButton.prepareForAutoLayout())
        locateButton.trailingAnchor ~= view.trailingAnchor - 18
        locateButtonBottom = locateButton.bottomAnchor ~= view.bottomAnchor - 16
        locateButton.widthAnchor ~= 44
        locateButton.heightAnchor ~= locateButton.widthAnchor

        swipeableCards.dataSource = self
        swipeableCards.delegate = self
        swipeableCards.isHidden = true
        view.addSubview(swipeableCards.prepareForAutoLayout())
        swipeableCards.pinEdgesToSuperviewEdges(excluding: .top)
        swipeableCards.heightAnchor ~= 144

        output.viewIsReady()
    }

    // MARK: - Action

    func handleMenuButtonTapped() {

        output.pressMenuButton()
    }

    func handleListButtonPressed() {
        output.pressListButton()
    }

    func handleLocateButtonPressed() {
        if let coordinate = userCoordinate {
            let camera = GMSCameraPosition.camera(withTarget: coordinate, zoom: 15)
            mapView.animate(to: camera)
        }
    }
}

// MARK: - RestaurantsMapViewInput

extension RestaurantsMapViewController: RestaurantsMapViewInput {

    func updateUserMarker(with coordinate: CLLocationCoordinate2D?) {
        userCoordinate = coordinate
    }

    func show(displayItems: [RestaurantsDisplayItem]) {
        self.displayItems = displayItems

        swipeableCards.isHidden = displayItems.isEmpty
        swipeableCards.reloadData()

        mapView.padding = UIEdgeInsets(
            top: 20,
            left: 0,
            bottom: !displayItems.isEmpty ? mapBottomPadding : 0,
            right: 0
        )
        locateButtonBottom?.constant = !displayItems.isEmpty ? -mapBottomPadding - 16 : -16

        for (index, item) in displayItems.enumerated() {
            let marker = GMSMarker()
            marker.position = item.coordinate
            marker.icon = index == 0 ? Asset.Map.mapPinIconSelected.image : Asset.Map.mapPinIcon.image
            marker.isFlat = true
            marker.title = item.name
            marker.snippet = item.address
            marker.map = mapView
            markers.append(marker)

            if index == 0 {
                currentMarker = marker

                let camera = GMSCameraPosition.camera(withTarget: marker.position, zoom: 13)
                mapView.animate(to: camera)
            }
        }
    }
}

// MARK: - GMSMapViewDelegate

extension RestaurantsMapViewController: GMSMapViewDelegate {

    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        if let marker = currentMarker {
            marker.icon = Asset.Map.mapPinIcon.image
        }

        marker.icon = Asset.Map.mapPinIconSelected.image
        currentMarker = marker

        let camera = GMSCameraPosition.camera(withTarget: marker.position, zoom: 13)
        mapView.animate(to: camera)

        if let index = markers.index(where: { $0 == marker }) {
            currentAnnotationIndex = index
            swipeableCards.swipe(to: currentAnnotationIndex)
        }

        return true
    }
}

// MARK: - SwipeableCardsDataSource

extension RestaurantsMapViewController: SwipeableCardsDataSource {

    func numberOfTotalCards(in cards: SwipeableCards) -> Int {
        return displayItems.count
    }

    func view(for cards: SwipeableCards, index: Int, reusingView: UIView?) -> UIView {
        let card = reusingView as? AnnotationCardView ?? AnnotationCardView()
        card.frame = CGRect(x: 0, y: 0, width: cards.frame.width - 11 * 2, height: 106)
        card.update(with: displayItems[index])
        return card
    }
}

// MARK: - SwipeableCardsDelegate

extension RestaurantsMapViewController: SwipeableCardsDelegate {

    func cards(_ cards: SwipeableCards, beforeSwipingItemAt index: Int) {
        let item = displayItems[currentAnnotationIndex]

        let camera = GMSCameraPosition.camera(withTarget: item.coordinate, zoom: 13)
        mapView.animate(to: camera)
    }

    func cards(_ cards: SwipeableCards, didRemovedItemAt index: Int) {
        currentAnnotationIndex = index + 1 < displayItems.count ? index + 1 : 0

        let item = displayItems[currentAnnotationIndex]

        if let marker = currentMarker {
            marker.icon = Asset.Map.mapPinIcon.image
        }

        let marker = markers[currentAnnotationIndex]
        marker.icon = Asset.Map.mapPinIconSelected.image
        currentMarker = marker

        let camera = GMSCameraPosition.camera(withTarget: item.coordinate, zoom: 13)
        mapView.animate(to: camera)
    }
}
