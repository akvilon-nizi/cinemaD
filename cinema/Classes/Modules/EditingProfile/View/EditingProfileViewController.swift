//
// Created by akvilon-nizi on 24/11/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit

class EditingProfileViewController: ParentViewController {

    var output: EditingProfileViewOutput!

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
    }
}

// MARK: - EditingProfileViewInput

extension EditingProfileViewController: EditingProfileViewInput {

    func setupInitialState() {

    }
}
