//
//  GetReportsByCategoryUseCase.swift
//  PiggyBank
//

import UIKit

public final class GetReportsByCategoryUseCase {
    func execute(category: DomainCategoryModel.CategoryType, from: Date, to: Date, completion: @escaping (Result<[DomainCategoryReportModel]>) -> Void) {
        APIManager.shared.getReportsByCategory(category: category, from: from, to: to, completion: completion)
    }
}
