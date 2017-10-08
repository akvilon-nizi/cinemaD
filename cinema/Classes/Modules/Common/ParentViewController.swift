//
// Created by Александр Масленников on 25.07.17.
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

    let mainTabView = MainTabView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        navigationItem.titleView = titleViewLabel

        view.addSubview(mainTabView.prepareForAutoLayout())
        mainTabView.widthAnchor ~= view.widthAnchor
        mainTabView.heightAnchor ~= 80
        mainTabView.leadingAnchor ~= view.leadingAnchor
        mainTabView.bottomAnchor ~= view.bottomAnchor + 4
        mainTabView.isHidden = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
}
