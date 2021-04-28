//
//  GetReportsByCategoryUseCase.swift
//  PiggyBank
//

import UIKit

public final class GetReportsByCategoryUseCase {

    private let getReportsByCategoryRepository: ReportsRepository?

    init(getReportsByCategoryRepository: ReportsRepository?) {
        self.getReportsByCategoryRepository = getReportsByCategoryRepository
    }

    func execute(category: DomainCategoryModel.CategoryType, from: Date, to: Date, completion: @escaping (Result<[DomainCategoryReportModel]>) -> Void) {
        getReportsByCategoryRepository?.getReportsByCategory(category: category, from: from, to: to, completion: completion)
    }
}
