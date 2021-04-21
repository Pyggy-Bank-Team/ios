import Foundation

protocol GetCategoriesRepository {
    func getCategories(completion: @escaping (Result<[DomainCategoryModel]>) -> Void)
}

final class GetCategoriesUseCase {

    private let getCategoriesRepository: GetCategoriesRepository

    init(getCategoriesRepository: GetCategoriesRepository) {
        self.getCategoriesRepository = getCategoriesRepository
    }

    func execute(completion: @escaping (Result<[DomainCategoryModel]>) -> Void) {
        getCategoriesRepository.getCategories(completion: completion)
    }

}
