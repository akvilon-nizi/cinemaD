//
// Created by akvilon-nizi on 16/11/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit
import RxMoya

class NewsViewController: ParentViewController {

    var output: NewsViewOutput!

    // MARK: - Life cycle

    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()

        let backButton = UIButton()
        backButton.setImage(Asset.NavBar.navBarArrowBack.image, for: .normal)
        backButton.addTarget(self, action: #selector(didTapLeftButton), for: .touchUpInside)
        backButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        var frame = backButton.frame
        frame.size = CGSize(width: 30, height: 100)
        backButton.frame = frame
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)

        titleViewLabel.text = L10n.newsTitleText
        titleViewLabel.font = UIFont.cnmFutura(size: 20)

        activityVC.isHidden = false
        activityVC.startAnimating()
    }

    func loadData(_ news: News) {

    }

    // MARK: - Actions
    func didTapLeftButton() {
        output?.backButtonTap()
    }
}

// MARK: - NewsViewInput

extension NewsViewController: NewsViewInput {
    func openNews(_ news: News) {
        activityVC.isHidden = true
        activityVC.stopAnimating()
        loadData(news)
    }

    func showNetworkError() {
        showAlert(message: L10n.alertCinemaNetworkErrror)
        activityVC.isHidden = true
        activityVC.stopAnimating()
    }

    func setupInitialState() {

    }
}
