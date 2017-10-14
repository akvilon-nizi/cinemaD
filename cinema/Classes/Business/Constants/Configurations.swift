//
// Created by Александр Масленников on 20.07.17.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

enum Configurations {

    case debug, `internal`, prerelease, release

    static var current: Configurations {
        #if DEBUG
            return .debug
        #elseif INTERNAL
            return .internal
        #elseif PRERELEASE
            return .prerelease
        #elseif RELEASE
            return .release
        #endif
    }

    var apiBaseURL: URL {
        guard let url = URL(string: "https://cinemad.pr-solution.ru/api/") else {
            fatalError("Wrong api base url")
        }
     return url
//        switch self {
//        case .debug, .internal:
//
//            return url
//        case .prerelease, .release:
//            // TODO: Find production url
//            fatalError("Need production url")
//        }
    }
}
