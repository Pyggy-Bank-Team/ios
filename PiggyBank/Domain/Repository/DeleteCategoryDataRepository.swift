//
//  DeleteCategoryDataRepository.swift
//  PiggyBank
//

protocol DeleteCategoryDataSource {
    func deleteCategory(categoryID: Int, completion: @escaping (Result<Void>) -> Void)
}

class DeleteCategoryDataRepository: DeleteCategoryRepository {

    private let remoteDataSource: DeleteCategoryDataSource?

    init(remoteDataSource: DeleteCategoryDataSource?) {
        self.remoteDataSource = remoteDataSource
    }

    func deleteCategory(categoryID: Int, completion: @escaping (Result<Void>) -> Void) {
        remoteDataSource?.deleteCategory(categoryID: categoryID, completion: completion)
    }
}
