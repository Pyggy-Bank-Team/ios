//
//  ReportsRepository.swift
//  PiggyBank
//

import UIKit

protocol ReportsRepository {
    func getReportsByCategory(
        category: DomainCategoryModel.CategoryType,
        from: Date,
        to: Date,
        completion: @escaping (Result<[DomainCategoryReportModel]>) -> Void
    )
}
