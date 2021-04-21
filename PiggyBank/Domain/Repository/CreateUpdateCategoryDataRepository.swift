//
//  CreateUpdateCategoryDataRepository.swift
//  PiggyBank
//

protocol CreateUpdateCategoryDataSource {
    func updateCategory(request: DomainCategoryModel, completion: @escaping (Result<Void>) -> Void)
    func createCategory(request: DomainCategoryModel, completion: @escaping (Result<Void>) -> Void)
}

class CreateUpdateCategoryDataRepository: CreateUpdateCategoryRepository {

    private let remoteDataSource: CreateUpdateCategoryDataSource

    init(remoteDataSource: CreateUpdateCategoryDataSource) {
        self.remoteDataSource = remoteDataSource
    }

    func updateCategory(request: DomainCategoryModel, completion: @escaping (Result<Void>) -> Void) {
        remoteDataSource.updateCategory(request: request, completion: completion)
    }

    func createCategory(request: DomainCategoryModel, completion: @escaping (Result<Void>) -> Void) {
        remoteDataSource.createCategory(request: request, completion: completion)
    }

}
