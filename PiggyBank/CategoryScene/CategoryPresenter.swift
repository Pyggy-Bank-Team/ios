import Foundation

final class CategoryPresenter {
    
    private let categoryDomainModel: DomainCategoryModel?
    
    private let createUpdateCategoryUseCase = CreateUpdateCategoryUseCase()
    private let deleteCategoryUseCase = DeleteCategoryUseCase()
    
    weak var view: CategoryViewController?
    
    init(categoryDomainModel: DomainCategoryModel?, view: CategoryViewController?) {
        self.categoryDomainModel = categoryDomainModel
        self.view = view
    }
    
    func loadData() {
        let categoryViewModel = GrandConverter.convertToViewModel(domainCategory: categoryDomainModel)
        view?.loadCategory(category: categoryViewModel)
    }
    
    func onSave() {
        guard let view = view else {
            fatalError("CategoryPresenter: onSave - view is nil")
        }

        let categoryID: Int?

        if let category = categoryDomainModel {
            categoryID = category.id
        } else {
            categoryID = nil
        }

        guard let categoryType = DomainCategoryModel.CategoryType(rawValue: view.categoryType) else {
            fatalError("CategoryPresenter: onSave - category type is invalid")
        }
        
        let createUpdateDomain = DomainCategoryModel(
            id: categoryID,
            title: view.categoryTitle,
            hexColor: view.categoryHex,
            type: categoryType.rawValue,
            isArchived: view.categoryArchived,
            isDeleted: false
        )

        createUpdateCategoryUseCase.execute(request: createUpdateDomain) { [weak self] result in
            guard let self = self else { return }

            if case .success = result {
                DispatchQueue.main.async {
                    self.view?.notifyFromAPI()
                }
            }
        }
    }
    
    func onDelete() {
        guard let id = categoryDomainModel?.id else {
            fatalError("AccountPresenter: onDelete - accountDomainModel?.id is nil")
        }
        
        deleteCategoryUseCase.execute(categoryID: id) { [weak self] result in
            guard let self = self else { return }
            
            if case .success = result {
                DispatchQueue.main.async {
                    self.view?.notifyFromAPI()
                }
            }
        }
    }
    
}

