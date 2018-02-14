//
//  MeetingVC.swift
//  cinema
//
//  Created by iOS on 26.12.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

class MeetingVC: ParentViewController {

    // MARK: - Life cycle

    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let stubsView = StubsView()
        view.addSubview(stubsView.prepareForAutoLayout())
        stubsView.trailingAnchor ~= view.trailingAnchor
        stubsView.leadingAnchor ~= view.leadingAnchor
        stubsView.centerYAnchor ~= view.centerYAnchor
    }
}
