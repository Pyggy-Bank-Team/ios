//
//  DateFormatter.swift
//  PiggyBank
//

import UIKit

extension String {
    func dateFromString(format: String = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS") -> Date? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = format
        return formatter.date(from: self)
    }
}

extension Date {
    func stringFromDate(format: String = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS") -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
