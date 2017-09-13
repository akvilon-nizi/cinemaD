//
// Created by Alexander Maslennikov on 21/07/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol RestaurantsViewInput: class {

    func changeContentFormat(new format: RestaurantsContentFormat)
}

protocol RestaurantsViewOutput {

    func viewIsReady()
}
