//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit

class ActorsViewController: ParentViewController {

    var output: ActorsViewOutput!

    let name: String

    let role: String

    let contentView = UIView()

    let imageView = UIImageView()
    
    let scrollView = UIScrollView()

    let windowWidth = UIWindow(frame: UIScreen.main.bounds).bounds.width - 160

    // MARK: - Life cycle

    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    init(name: String, role: String) {
        self.name = name
        self.role = role
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()

        view.backgroundColor = .white

        let backButton = UIButton()
        backButton.setImage(Asset.NavBar.navBarArrowBack.image, for: .normal)
        backButton.addTarget(self, action: #selector(didTapLeftButton), for: .touchUpInside)
        backButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        var frame = backButton.frame
        frame.size = CGSize(width: 30, height: 100)
        backButton.frame = frame
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)

        let homeButton = UIButton()
        homeButton.setImage(Asset.Cinema.home.image, for: .normal)
        homeButton.addTarget(self, action: #selector(didTapHomeButton), for: .touchUpInside)
        homeButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        frame = homeButton.frame
        frame.origin.x -= 9
        frame.size = CGSize(width: 30, height: 100)
        homeButton.frame = frame
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: homeButton)

        activityVC.isHidden = false
        activityVC.startAnimating()

        let titleView = UIView()
        titleView.heightAnchor ~= 88
        let titleViewLabel = UILabel()
        titleViewLabel.text = name
        titleViewLabel.lineBreakMode = .byTruncatingTail
        titleViewLabel.font = UIFont.cnmFutura(size: 20)
        titleViewLabel.textColor = UIColor.cnmGreyDark
        titleViewLabel.widthAnchor ~= windowWidth + 40
        titleViewLabel.textAlignment = .center
        titleView.addSubview(titleViewLabel.prepareForAutoLayout())
        titleViewLabel.centerXAnchor ~= titleView.centerXAnchor
        titleViewLabel.centerYAnchor ~= titleView.centerYAnchor - 7
        //titleViewLabel.topAnchor ~= titleView.topAnchor

        let titleLabel = UILabel()
        titleLabel.font = UIFont.cnmFuturaLight(size: 14)
        titleLabel.textColor = UIColor.cnmAfafaf
        titleLabel.text = role
        titleLabel.textAlignment = .center

        titleView.addSubview(titleLabel.prepareForAutoLayout())
        titleLabel.centerXAnchor ~= titleView.centerXAnchor
        titleLabel.topAnchor ~= titleViewLabel.bottomAnchor

        navigationItem.titleView = titleView
    }

    // MARK: - Actions
    func didTapLeftButton() {
        output?.backButtonTap()
    }

    func didTapHomeButton() {
        output?.homeButtonTap()
    }
}

// MARK: - ActorsViewInput

extension ActorsViewController: ActorsViewInput {

    func setupInitialState() {

    }

    func showNetworkError() {
        showAlert(message: L10n.alertCinemaNetworkErrror)
        activityVC.isHidden = true
        activityVC.stopAnimating()
    }

    func getPersonInfo(person: FullPerson) {
        activityVC.isHidden = true
        activityVC.stopAnimating()
    }
}
