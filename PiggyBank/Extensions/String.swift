//
//  String.swift
//  PiggyBank
//

import Foundation

extension String {
    func dateFromString(format: String = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS") -> Date? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = format
        return formatter.date(from: self)
    }
}
