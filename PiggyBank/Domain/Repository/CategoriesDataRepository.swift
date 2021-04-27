//
//  CategoriesDataRepository.swift
//  PiggyBank
//

protocol CategoriesDataSource {
    func createCategory(request: DomainCategoryModel, completion: @escaping (Result<Void>) -> Void)
    func updateCategory(request: DomainCategoryModel, completion: @escaping (Result<Void>) -> Void)
    func deleteCategory(categoryID: Int, completion: @escaping (Result<Void>) -> Void)
    func getCategories(completion: @escaping (Result<[DomainCategoryModel]>) -> Void)
}

class CategoriesDataRepository: CategoriesRepository {

    private let remoteDataSource: CategoriesDataSource?

    init(remoteDataSource: CategoriesDataSource?) {
        self.remoteDataSource = remoteDataSource
    }

    func createCategory(request: DomainCategoryModel, completion: @escaping (Result<Void>) -> Void) {
        remoteDataSource?.createCategory(request: request, completion: completion)
    }

    func updateCategory(request: DomainCategoryModel, completion: @escaping (Result<Void>) -> Void) {
        remoteDataSource?.updateCategory(request: request, completion: completion)
    }

    func deleteCategory(categoryID: Int, completion: @escaping (Result<Void>) -> Void) {
        remoteDataSource?.deleteCategory(categoryID: categoryID, completion: completion)
    }

    func getCategories(completion: @escaping (Result<[DomainCategoryModel]>) -> Void) {
        remoteDataSource?.getCategories(completion: completion)
    }
}
