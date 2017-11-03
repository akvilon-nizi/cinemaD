//
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
//            fatalError("Need production url")
//        }
    }

    var youtubeURL: URL {
        guard let url = URL(string: "https://www.googleapis.com/youtube/v3") else {
            fatalError("Wrong api base url")
        }
        return url
        //        switch self {
        //        case .debug, .internal:
        //
        //            return url
        //        case .prerelease, .release:
        //            fatalError("Need production url")
        //        }
    }

    static let googleApi: String = "AIzaSyB11962AzbjV9dEk4sQH2nZhFbVWIicrYA"
}
