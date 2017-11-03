//
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

#if INTERNAL
import Bugsee
#endif

class CrashReportManager {

    static func configureReporting() {
        switch Configurations.current {
        case .debug, .internal:
            configureBugsee()
        default:
            break
        }
    }

    fileprivate static func configureBugsee() {

    }
}
