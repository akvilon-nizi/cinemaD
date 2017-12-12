//
// Created by Danila Lyahomskiy on 11/12/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit

class AdminCollectionViewController: ParentViewController {

    var output: AdminCollectionViewOutput!

    let name: String

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

    init(name: String) {
        self.name = name
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

        titleViewLabel.text = name
        titleViewLabel.font = UIFont.cnmFutura(size: 20)
    }

    // MARK: - Actions
    func didTapLeftButton() {
        output?.backTap()
    }

    func didTapHomeButton() {
        output?.homeTap()
    }
}

// MARK: - AdminCollectionViewInput

extension AdminCollectionViewController: AdminCollectionViewInput {

    func setupInitialState() {

    }
}
