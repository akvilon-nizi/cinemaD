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
    }

    var youtubeURL: URL {
        guard let url = URL(string: "https://www.googleapis.com/youtube/v3") else {
            fatalError("Wrong api base url")
        }
        return url
    }

    static let linkShare: String = "https://itunes.apple.com/us/app/keynote/id361285480?mt=8"

    static let googleApi: String = "AIzaSyB11962AzbjV9dEk4sQH2nZhFbVWIicrYA"
}
