//
// Created by Danila Lyahomskiy on 28/11/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit

class ReviewsViewController: ParentViewController {

    var output: ReviewsViewOutput!

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

// MARK: - ReviewsViewInput

extension ReviewsViewController: ReviewsViewInput {

    func setupInitialState() {

    }
}
