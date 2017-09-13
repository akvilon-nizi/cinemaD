//
// Created by Alexander Maslennikov on 21/07/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit

class RestaurantsViewController: ParentViewController {

    var output: RestaurantsViewOutput!

    let controllers: [UIViewController]

    let contentView = UIView()
    var currentStatusBarStyle: UIStatusBarStyle = .lightContent
    var currentController: UIViewController?

    // MARK: - Life cycle

    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    init(controllers: [UIViewController]) {
        self.controllers = controllers
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contentView)

        contentView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        output.viewIsReady()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return currentStatusBarStyle
    }
}

// MARK: - Fileprivate methods

private extension RestaurantsViewController {

    func willAppearController(for format: RestaurantsContentFormat) {
        guard format.rawValue < controllers.count else {
            log.warning("Controller for index \(format.rawValue) not found")
            return
        }

        let newController = controllers[format.rawValue]

        if let currentController = currentController {
            currentController.willMove(toParentViewController: nil)
            currentController.view.removeFromSuperview()
            currentController.removeFromParentViewController()
        }

        addChildViewController(newController)
        newController.view.frame = contentView.bounds
        contentView.addSubview(newController.view)
        newController.didMove(toParentViewController: self)

        currentController = newController
    }
}

// MARK: - RestaurantsViewInput

extension RestaurantsViewController: RestaurantsViewInput {

    func changeContentFormat(new format: RestaurantsContentFormat) {
        willAppearController(for: format)

        switch format {
        case .map:
            currentStatusBarStyle = .lightContent
        case .list:
            currentStatusBarStyle = .default
        }
        setNeedsStatusBarAppearanceUpdate()
    }
}
