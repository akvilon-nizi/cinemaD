//
//  DateTransform.swift
//  cinema
//
//  Created by Mac on 06.09.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

class DateTransform: TransformType {
    typealias Object = Date
    typealias JSON = String

    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
//        formatter.locale = Locale(identifier: "en_US_POSIX")
//        formatter.timeZone = TimeZone(identifier: "ru_RU")
//        formatter.timeZone = TimeZone(secondsFromGMT: 60 * 60 * 3)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        return formatter
    }()

    init() {}

    func transformFromJSON(_ value: Any?) -> Date? {
        if let dateString = value as? String {
            return dateFormatter.date(from: dateString)
        }
        return nil
    }

    func transformToJSON(_ value: Date?) -> String? {
        if let date = value {
            return dateFormatter.string(from: date)
        }
        return nil
    }
}

extension Formatter {
    static let monthMedium: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM"
        formatter.locale = Locale(identifier: "ru_Ru")
        return formatter
    }()

    static let hourMinutes: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()

    static let years: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY"
        return formatter
    }()

}
extension Date {
    var monthMedium: String { return Formatter.monthMedium.string(from: self) }
    var hourMinutes: String { return Formatter.hourMinutes.string(from: self) }
    var years: String { return Formatter.years.string(from: self) }
}
