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
            guard let responseModel = response.value else {
                return completion(.error(response.error ?? InternalError(string: "Cannot get responseModel for GetReportsByCategory")))
            }
            let reports = responseModel.map { GrandConverter.convertToDomain(response: $0) }
            completion(.success(reports))
        }
    }
}
