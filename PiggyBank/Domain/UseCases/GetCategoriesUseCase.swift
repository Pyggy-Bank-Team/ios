import Foundation

final class GetCategoriesUseCase {

    private let getCategoriesRepository: CategoriesRepository?

    init(getCategoriesRepository: CategoriesRepository?) {
        self.getCategoriesRepository = getCategoriesRepository
    }

    func execute(completion: @escaping (Result<[DomainCategoryModel]>) -> Void) {
        getCategoriesRepository?.getCategories(completion: completion)
    }

}
