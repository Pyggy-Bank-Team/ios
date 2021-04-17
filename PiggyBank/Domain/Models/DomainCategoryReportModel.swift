//
//  DomainOperationReportModel.swift
//  PiggyBank
//

public final class DomainCategoryReportModel {
    let categoryId: Int
    let categoryTitle: String
    let categoryHexColor: String
    let amount: Int64

    init(categoryId: Int, categoryTitle: String, categoryHexColor: String, amount: Int64) {
        self.categoryId = categoryId
        self.categoryTitle = categoryTitle
        self.categoryHexColor = categoryHexColor
        self.amount = amount
    }
}
