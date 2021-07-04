import Foundation

final class CategoriesPresenter {
    
    class SectionItem {
        
        let emptyText: String?
        
        let headerTitle: String?
        var categories: [DomainCategoryModel] = []
        
        init(title: String?) {
            self.headerTitle = title
            emptyText = nil
        }
        
        init(emptyText: String) {
            self.emptyText = emptyText
            headerTitle = nil
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
    
    func getSection(at index: Int) -> SectionItem {
        sections[index]
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
            defer {
                DispatchQueue.main.async {
                    self.view?.sections = self.sections
                }
            }
            
            sections.removeAll()
            
            if categories.isEmpty {
                let empty = SectionItem(emptyText: "No categories")
                sections.append(empty)
                return
            }
            
            let regularCategories = SectionItem(title: nil)
            let archivedCategories = SectionItem(title: "Archive")
            
            categories.forEach { category in
                if category.isArchived {
                    archivedCategories.categories.append(category)
                } else {
                    regularCategories.categories.append(category)
                }
            }
            
            sections.removeAll()
            if !regularCategories.categories.isEmpty {
                sections.append(regularCategories)
            }
            if !archivedCategories.categories.isEmpty {
                sections.append(archivedCategories)
            }
        }
    }
    
}
