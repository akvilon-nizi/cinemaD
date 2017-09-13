//
// Created by Xander on 23.07.17.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation
import XCGLogger

let log = LogManager.configureLogging()

class LogManager {

    static func configureLogging() -> XCGLogger {
        let log = XCGLogger(identifier: "XCGLogger", includeDefaultDestinations: false)

        let systemLogDestination = ConsoleDestination(owner: log, identifier: "XCGLogger.console")

        switch Configurations.current {
        case .debug:
            systemLogDestination.outputLevel = .verbose
        case .internal:
            systemLogDestination.outputLevel = .info
        case .prerelease, .release:
            systemLogDestination.outputLevel = .severe
        }

        systemLogDestination.showLogIdentifier = false
        systemLogDestination.showFunctionName = true
        systemLogDestination.showThreadName = false
        systemLogDestination.showLevel = true
        systemLogDestination.showFileName = true
        systemLogDestination.showLineNumber = true
        systemLogDestination.showDate = true
        log.add(destination: systemLogDestination)

        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "HH:mm:ss.SSS"
        log.dateFormatter = dateFormatter

        return log
    }

}
