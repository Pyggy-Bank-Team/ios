import Foundation

final class CategoriesPresenter {
    
    class SectionItem {
        
        let headerTitle: String?
        var categories: [DomainCategoryModel] = []
        
        init(title: String?) {
            self.headerTitle = title
        }

    }

    private weak var view: CategoriesViewController?
    
    private let getCategoriesUseCase: GetCategoriesUseCase
    private let changeAndUpdateCategoriesUseCase: ChangeAndUpdateCategoriesUseCase
    private let deleteAndUpdateCategoriesUseCase: DeleteAndUpdateCategoriesUseCase

    private var sections: [SectionItem] = []

    init(
        view: CategoriesViewController?,
        getCategoriesUseCase: GetCategoriesUseCase,
        changeAndUpdateCategoriesUseCase: ChangeAndUpdateCategoriesUseCase,
        deleteAndUpdateCategoriesUseCase: DeleteAndUpdateCategoriesUseCase
    ) {
        self.view = view
        self.getCategoriesUseCase = getCategoriesUseCase
        self.changeAndUpdateCategoriesUseCase = changeAndUpdateCategoriesUseCase
        self.deleteAndUpdateCategoriesUseCase = deleteAndUpdateCategoriesUseCase
    }
    
    func getCategory(at indexPath: IndexPath) -> DomainCategoryModel {
        sections[indexPath.section].categories[indexPath.row]
    }

    func getCategories() {
        getCategoriesUseCase.execute { [weak self] response in
            self?.handleResponse(response)
        }
    }
    
    func archive(at indexPath: IndexPath) {
        let category = getCategory(at: indexPath)
        let newCategory = category.update(isArchived: !category.isArchived)
        
        changeAndUpdateCategoriesUseCase.execute(category: newCategory) { [weak self] response in
            self?.handleResponse(response)
        }
    }
    
    func delete(at indexPath: IndexPath) {
        let category = getCategory(at: indexPath)
        deleteAndUpdateCategoriesUseCase.execute(category: category) { [weak self] response in
            self?.handleResponse(response)
        }
    }
    
}

private extension CategoriesPresenter {
    
    func handleResponse(_ response: Result<[DomainCategoryModel]>) {
        if case let .success(categories) = response {
            let incomeCategories = SectionItem(title: "Income")
            let outcomeCategories = SectionItem(title: "Outcome")
            let archivedIncomeCategories = SectionItem(title: "Archive • Income")
            let archivedOutcomeCategories = SectionItem(title: "Archive • Outcome")
            
            categories.forEach { category in
                if category.type == .income {
                    if category.isArchived {
                        archivedIncomeCategories.categories.append(category)
                    } else {
                        incomeCategories.categories.append(category)
                    }
                } else {
                    if category.isArchived {
                        archivedOutcomeCategories.categories.append(category)
                    } else {
                        outcomeCategories.categories.append(category)
                    }
                }
            }
            
            self.sections = [incomeCategories, outcomeCategories, archivedIncomeCategories, archivedOutcomeCategories]
            self.sections = self.sections.filter { !$0.categories.isEmpty }
            
            DispatchQueue.main.async {
                self.view?.sections = self.sections
            }
        }
    }
    
}
