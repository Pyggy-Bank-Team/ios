import Foundation

final class DeleteCategoryUseCase {
    
    private let deleteCategoryRepository: CategoriesRepository?

    init(deleteCategoryRepository: CategoriesRepository?) {
        self.deleteCategoryRepository = deleteCategoryRepository
    }

    func execute(categoryID: Int, completion: @escaping (Result<Void>) -> Void) {
        deleteCategoryRepository?.deleteCategory(categoryID: categoryID, completion: completion)
    }

}
