//
// Created by 1 on 07/11/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol FilterModuleOutput: class {
    func setFilters(genresInds: [Int], yearsInds: [Int])
}
