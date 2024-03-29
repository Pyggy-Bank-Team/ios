//
//  DateFormatter.swift
//  PiggyBank
//

import UIKit

extension Date {
    func stringFromDate(format: String = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS") -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
