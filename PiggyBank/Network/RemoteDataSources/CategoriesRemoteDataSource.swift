//
//  CategoriesRemoteDataSource.swift
//  PiggyBank
//

import Foundation

struct CategoriesRemoteDataSource: CategoriesDataSource {

    func getCategories(completion: @escaping (Result<[DomainCategoryModel]>) -> Void) {
        APIManager.shared.perform(request: .GetCategories) { (response: Result<[Category.Response]>) in
            guard case let .success(responseModel) = response else {
                return completion(.error(APIError()))
            }
            let categories = responseModel.map { GrandConverter.convertToDomain(response: $0) }
            completion(.success(categories))
        }
    }

    func createCategory(request: DomainCategoryModel, completion: @escaping (Result<Void>) -> Void) {
        let requestModel = GrandConverter.convertToRequestModel(domain: request)
        APIManager.shared.perform(request: .CreateCategory(requestModel), completion: completion)
    }

    func updateCategory(request: DomainCategoryModel, completion: @escaping (Result<Void>) -> Void) {
        guard let id = request.id else {
            fatalError("APIManager: updateCategory - ID can't be null")
        }
        let requestModel = GrandConverter.convertToRequestModel(domain: request)
        APIManager.shared.perform(request: .UpdateCategory(id, requestModel), completion: completion)
    }

    func deleteCategory(categoryID: Int, completion: @escaping (Result<Void>) -> Void) {
        APIManager.shared.perform(request: .DeleteCategory(categoryID), completion: completion)
    }
}
