//
//  ReportViewModel.swift
//  PiggyBank
//

import UIKit

final class ReportViewModel {

    struct ReportCategory {
        let color: UIColor
        let name: String
        let amount: Int64
    }

    var sign: String
    var type: CategoryViewModel.CategoryType
    var startDate: Date
    var endDate: Date
    var total: Int64
    var categoryList: [ReportCategory]

    init(sign: String,
         type: CategoryViewModel.CategoryType,
         startDate: Date,
         endDate: Date,
         total: Int64,
         categoryList: [ReportCategory]) {
        self.sign = sign
        self.type = type
        self.startDate = startDate
        self.endDate = endDate
        self.total = total
        self.categoryList = categoryList
    }
}
