//
//  CategoriesRepository.swift
//  PiggyBank
//

protocol CategoriesRepository {
    func createCategory(request: DomainCategoryModel, completion: @escaping (Result<Void>) -> Void)
    func updateCategory(request: DomainCategoryModel, completion: @escaping (Result<Void>) -> Void)
    func deleteCategory(categoryID: Int, completion: @escaping (Result<Void>) -> Void)
    func getCategories(completion: @escaping (Result<[DomainCategoryModel]>) -> Void)
}
