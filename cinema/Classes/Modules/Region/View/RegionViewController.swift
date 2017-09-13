//
// Created by incetro on 24/08/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit

class RegionViewController: ParentViewController {

    fileprivate let tableView: UITableView = {

        let tableView = UITableView()

        tableView.backgroundColor = .clear
        tableView.separatorColor = .clear
        tableView.clipsToBounds = false
        tableView.showsVerticalScrollIndicator = false

        return tableView
    }()

    fileprivate let continueButton: UIButton = {

        let continueButton = UIButton()

        continueButton.layer.cornerRadius = 5
        continueButton.isEnabled = false
        continueButton.alpha = 0.5

        let gradient = CAGradientLayer()
        let colorLeft = UIColor.fdlWatermelon.cgColor
        let colorRight = UIColor.fdlPeachyPink.cgColor

        gradient.colors = [colorLeft, colorRight]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.05)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.05)
        gradient.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 20, height: 48)
        gradient.cornerRadius = 5

        continueButton.titleLabel?.font = UIFont.fdlGothamProMedium(size: 15)
        continueButton.titleLabel?.textColor = .white
        continueButton.clipsToBounds = true
        continueButton.layer.insertSublayer(gradient, at: 0)

        return continueButton
    }()

    fileprivate let contentManager = RegionContentManager()

    var output: RegionViewOutput!

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

        view.addSubview(continueButton.prepareForAutoLayout())

        continueButton.leadingAnchor ~= view.leadingAnchor + 10
        continueButton.trailingAnchor ~= view.trailingAnchor - 10
        continueButton.bottomAnchor ~= view.bottomAnchor - 10
        continueButton.heightAnchor ~= 48

        continueButton.addTarget(self, action: #selector(didTapContinueButton), for: .touchUpInside)

        view.addSubview(tableView.prepareForAutoLayout())

        tableView.pinToSuperview([.left, .right])
        tableView.topAnchor ~= view.topAnchor + 50
        tableView.bottomAnchor ~= continueButton.topAnchor - 60

        let header = RegionHeaderView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 260))

        tableView.tableHeaderView = header

        contentManager.tableView = tableView
        contentManager.delegate = self
    }

    func didTapContinueButton() {

        if let region = contentManager.selectedRegion {

            output.didSelectRegion(region)
        }
    }

    func didTapLeftButton() {

        output.backButtonTapped()
    }
}

// MARK: - RegionContentManagerDelegate

extension RegionViewController: RegionContentManagerDelegate {

    func didSelectRegion(_ region: Region) {

        guard !continueButton.isEnabled else {

            return
        }

        UIView.animate(withDuration: 0.2, animations: {

            self.continueButton.alpha = 1

        }, completion: { _ in

            self.continueButton.isEnabled = true
        })
    }
}

// MARK: - RegionViewInput

extension RegionViewController: RegionViewInput {

    func setupInitialState(withRegions regions: [Region], selected: Region?, isSelect: Bool) {

        contentManager.regions = regions

        if let region = selected, let index = regions.index(where: { $0.id == region.id }) {

            continueButton.setTitle(L10n.regionChooseButtonTitle, for: .normal)

            tableView.selectRow(at: IndexPath(row: index, section: 0), animated: false, scrollPosition: .middle)

            self.didSelectRegion(regions[index])

            let backButton = UIButton()
            backButton.setImage(Asset.NavBar.navBarArrowBack.image, for: .normal)
            backButton.addTarget(self, action: #selector(didTapLeftButton), for: .touchUpInside)
            backButton.sizeToFit()
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)

        } else {

            if isSelect {

                continueButton.setTitle(L10n.regionChooseButtonTitle, for: .normal)

            } else {

                continueButton.setTitle(L10n.regionButtonTitle, for: .normal)
            }
        }
    }
}
