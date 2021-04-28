//
//  ReportsDataRepository.swift
//  PiggyBank
//

import UIKit

protocol ReportsDataSource {
    func getReportsByCategory(
        category: DomainCategoryModel.CategoryType,
        from: Date,
        to: Date,
        completion: @escaping (Result<[DomainCategoryReportModel]>) -> Void
    )
}

class ReportsDataRepository: ReportsRepository {

    private let remoteDataSource: ReportsDataSource?

    init(remoteDataSource: ReportsDataSource?) {
        self.remoteDataSource = remoteDataSource
    }

    func getReportsByCategory(category: DomainCategoryModel.CategoryType, from: Date, to: Date, completion: @escaping (Result<[DomainCategoryReportModel]>) -> Void) {
        remoteDataSource?.getReportsByCategory(category: category, from: from, to: to, completion: completion)
    }
}
