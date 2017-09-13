//
// Created by incetro on 24/08/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol RegionViewInput: class {

    func setupInitialState(withRegions regions: [Region], selected: Region?, isSelect: Bool)
}

protocol RegionViewOutput {

    func viewIsReady()

    func didSelectRegion(_ region: Region)

    func backButtonTapped()
}
