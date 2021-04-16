//
//  ReportViewModel.swift
//  PiggyBank
//

import UIKit

public final class ReportViewModel {

    struct ReportCategory {
        let color: UIColor
        let name: String
        let amount: Int64
    }

    var type: CategoryViewModel.CategoryType
    var startDate: Date
    var endDate: Date
    var total: Int64
    var categoryList: [ReportCategory]

    init(type: CategoryViewModel.CategoryType,
         startDate: Date,
         endDate: Date,
         total: Int64,
         categoryList: [ReportCategory]) {
        self.type = type
        self.startDate = startDate
        self.endDate = endDate
        self.total = total
        self.categoryList = categoryList
    }
}
