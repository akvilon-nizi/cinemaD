//
// Created by Alexander Maslennikov on 25/07/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol RestaurantsListModuleInput: RestaurantsSubmoduleInput {

}

protocol RestaurantsListModuleOutput: class, RestaurantsSubmoduleOutput {

    var listInput: RestaurantsListModuleInput? { get set }
}
