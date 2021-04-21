import Foundation

protocol DeleteCategoryRepository {
    func deleteCategory(categoryID: Int, completion: @escaping (Result<Void>) -> Void)
}

final class DeleteCategoryUseCase {
    
    private let deleteCategoryRepository: DeleteCategoryRepository

    init(deleteCategoryRepository: DeleteCategoryRepository) {
        self.deleteCategoryRepository = deleteCategoryRepository
    }

    func execute(categoryID: Int, completion: @escaping (Result<Void>) -> Void) {
        deleteCategoryRepository.deleteCategory(categoryID: categoryID, completion: completion)
    }

}
