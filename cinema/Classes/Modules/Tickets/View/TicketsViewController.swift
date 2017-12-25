//
// Created by Danila Lyahomskiy on 25/12/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit

class TicketsViewController: ParentViewController {

    var output: TicketsViewOutput!

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
        backButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        var frame = backButton.frame
        frame.size = CGSize(width: 30, height: 100)
        backButton.frame = frame
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)

        titleViewLabel.text = L10n.ticketsTitleText
        titleViewLabel.font = UIFont.cnmFutura(size: 20)

        let stubsView = StubsView()
        view.addSubview(stubsView.prepareForAutoLayout())
        stubsView.trailingAnchor ~= view.trailingAnchor
        stubsView.leadingAnchor ~= view.leadingAnchor
        stubsView.centerYAnchor ~= view.centerYAnchor
    }

    // MARK: - Actions
    func didTapLeftButton() {
        output?.backButtonTap()
    }
}

// MARK: - TicketsViewInput

extension TicketsViewController: TicketsViewInput {

    func setupInitialState() {

    }
}
