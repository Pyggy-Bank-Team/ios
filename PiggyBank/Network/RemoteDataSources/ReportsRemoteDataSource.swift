//
//  ReportsRemoteDataSource.swift
//  PiggyBank
//

import Foundation

struct ReportsRemoteDataSource: ReportsDataSource {

    func getReportsByCategory(
        category: DomainCategoryModel.CategoryType,
        from: Date,
        to: Date,
        completion: @escaping (Result<[DomainCategoryReportModel]>) -> Void
    ) {
        let requestModel = GrandConverter.convertToRequestModel(category: category, fromDate: from, toDate: to)
        APIManager.shared.perform(request: .GetReportsByCategory(requestModel)) { (response: Result<[Reports.Response]>) in
            guard case let .success(responseModel) = response else {
                return completion(.error(APIError()))
            }
            let reports = responseModel.map { GrandConverter.convertToDomain(response: $0) }
            completion(.success(reports))
        }
    }
}
