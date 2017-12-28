//
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit

class ParentViewController: UIViewController {

    let titleViewLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 240, height: 44))
        label.textColor = UIColor.cnmGreyDark
        label.font = UIFont.cnmFutura(size: 16)
        label.textAlignment = .center
        return label
    }()

    let activityVC = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        navigationItem.titleView = titleViewLabel
        navigationController?.navigationBar.backgroundColor = .white

        view.addSubview(activityVC.prepareForAutoLayout())
        activityVC.centerXAnchor ~= view.centerXAnchor
        activityVC.centerYAnchor ~= view.centerYAnchor
        activityVC.activityIndicatorViewStyle = .whiteLarge
        activityVC.color = UIColor.cnmGreyDark

        activityVC.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        let statusBarAlertManager = StatusBarAlertManager.sharedInstance
        statusBarAlertManager.unregistrate(viewController: self)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(false, animated: animated)

        let statusBarAlertManager = StatusBarAlertManager.sharedInstance
        statusBarAlertManager.registrate(viewController: self)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }

    func showAlert(message: String) {

        let statusBarAlertManager = StatusBarAlertManager.sharedInstance
        statusBarAlertManager.setStatusBarAlert(with: message, with: self)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            statusBarAlertManager.clear()
        }
    }

    func showMessage(message: String) {

        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: UIAlertControllerStyle.alert)

        let cancelAction = UIAlertAction(title: "OK",
                                         style: .cancel, handler: nil)

        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
}
