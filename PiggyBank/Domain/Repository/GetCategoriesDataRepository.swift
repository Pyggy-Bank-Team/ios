//
//  GetCategoriesDataRepository.swift
//  PiggyBank
//

protocol GetCategoriesDataSource {
    func getCategories(completion: @escaping (Result<[DomainCategoryModel]>) -> Void)
}

class GetCategoriesDataRepository: GetCategoriesRepository {

    private let remoteDataSource: GetCategoriesDataSource

    init(remoteDataSource: GetCategoriesDataSource) {
        self.remoteDataSource = remoteDataSource
    }

    func getCategories(completion: @escaping (Result<[DomainCategoryModel]>) -> Void) {
        remoteDataSource.getCategories(completion: completion)
    }

}
