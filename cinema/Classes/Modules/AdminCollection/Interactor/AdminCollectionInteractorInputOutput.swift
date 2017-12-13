//
// Created by Danila Lyahomskiy on 11/12/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol AdminCollectionInteractorInput {
    func getAdminCollections(id: String)
}

protocol AdminCollectionInteractorOutput: class {
    func getCollection(_ collection: Collection)

    func getError()
}
