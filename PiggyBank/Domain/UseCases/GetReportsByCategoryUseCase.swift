//
//  GetReportsByCategoryUseCase.swift
//  PiggyBank
//

import UIKit

protocol GetReportsByCategoryRepository {
    func getReportsByCategory(
        category: DomainCategoryModel.CategoryType,
        from: Date,
        to: Date,
        completion: @escaping (Result<[DomainCategoryReportModel]>) -> Void
    )
}

public final class GetReportsByCategoryUseCase {

    private let getReportsByCategoryRepository: GetReportsByCategoryRepository?

    init(getReportsByCategoryRepository: GetReportsByCategoryRepository?) {
        self.getReportsByCategoryRepository = getReportsByCategoryRepository
    }

    func execute(category: DomainCategoryModel.CategoryType, from: Date, to: Date, completion: @escaping (Result<[DomainCategoryReportModel]>) -> Void) {
        getReportsByCategoryRepository?.getReportsByCategory(category: category, from: from, to: to, completion: completion)
    }
}
