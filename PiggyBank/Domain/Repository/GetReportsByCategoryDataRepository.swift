//
//  GetReportsByCategoryDataRepository.swift
//  PiggyBank
//

import UIKit

protocol GetReportsByCategoryDataSource {
    func getReportsByCategory(
        category: DomainCategoryModel.CategoryType,
        from: Date,
        to: Date,
        completion: @escaping (Result<[DomainCategoryReportModel]>) -> Void
    )
}

class GetReportsByCategoryDataRepository: GetReportsByCategoryRepository {

    private let remoteDataSource: GetReportsByCategoryDataSource?

    init(remoteDataSource: GetReportsByCategoryDataSource?) {
        self.remoteDataSource = remoteDataSource
    }

    func getReportsByCategory(category: DomainCategoryModel.CategoryType, from: Date, to: Date, completion: @escaping (Result<[DomainCategoryReportModel]>) -> Void) {
        remoteDataSource?.getReportsByCategory(category: category, from: from, to: to, completion: completion)
    }
}
