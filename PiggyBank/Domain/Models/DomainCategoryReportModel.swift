//
//  DomainOperationReportModel.swift
//  PiggyBank
//

public final class DomainCategoryReportModel {
    let categoryId: Int
    let categoryTitle: String
    let categoryHexColor: String
    let amount: Int64
    let currency: String

    init(categoryId: Int, categoryTitle: String, categoryHexColor: String, amount: Int64, currency: String) {
        self.categoryId = categoryId
        self.categoryTitle = categoryTitle
        self.categoryHexColor = categoryHexColor
        self.amount = amount
        self.currency = currency
    }
}
