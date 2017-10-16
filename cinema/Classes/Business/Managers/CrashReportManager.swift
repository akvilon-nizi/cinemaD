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
#if INTERNAL
        if UIDevice.current.name.range(of: "^handh\\.", options: .regularExpression) != nil {
            Bugsee.launch(token :"bd2abcca-3ae5-4954-9273-e7b64ec26b35", options: [
                BugseeShakeToReportKey: true,
                BugseeKillDetectionKey: true
            ])
        }
#endif
    }
}
