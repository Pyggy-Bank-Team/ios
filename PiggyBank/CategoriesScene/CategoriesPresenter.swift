import Foundation

final class CategoriesPresenter {
    
    private weak var view: CategoriesViewController?
    
    private let getCategoriesUseCase = GetCategoriesUseCase()
    private let createCategoryUseCase = CreateCategoryUseCase()
    private let deleteCategoryUseCase = DeleteCategoryUseCase()
    private let archiveCategoryUseCase = ArchiveCategoryUseCase()
    private let changeCategoryUseCase = ChangeCategoryUseCase()
    
    private var categories: [DomainCategoryModel] = []
    
    init(view: CategoriesViewController) {
        self.view = view
    }
    
    func onViewDidLoad(request: CategoriesDTOs.ViewDidLoad.Request) {
        getCategoriesUseCase.execute(request: .init()) { [weak self] response in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                if case let .success(items) = response.result {
                    self.categories = items
                    
                    let viewModels = items.map {
                        CategoryViewModel(
                            id: $0.id,
                            title: $0.title,
                            hexColor: $0.hexColor,
                            type: $0.type == .income ? .income : .outcome,
                            isArchived: $0.isArchived
                        )
                    }
                    
                    self.view?.viewDidLoad(response: .init(categories: viewModels))
                }
            }
        }
    }
    
    func onCreateCategory(request: CategoriesDTOs.CreateCategory.Request) {
        createCategoryUseCase.execute(request: .init(title: request.title, hexColor: request.color, type: request.type)) { [weak self] response in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                if case .success = response.result {
                    self.view?.showResult(str: "Category has been successfully created")
                } else {
                    self.view?.showResult(str: "Error while adding")
                }
            }
        }
    }
    
    func onArchiveCategory(request: CategoriesDTOs.OnArchiveCategory.Request) {
        let category = categories[request.index]
        
        archiveCategoryUseCase.execute(request: .init(id: category.id)) { response in
            DispatchQueue.main.async {
                if case .success = response.result {
                    self.view?.showResult(str: "Category has been successfully archived")
                } else {
                    self.view?.showResult(str: "Error while archiving")
                }
            }
        }
    }
    
    func onDeleteCategory(request: CategoriesDTOs.OnDeleteCategory.Request) {
        let category = categories[request.index]
        
        deleteCategoryUseCase.execute(request: .init(id: category.id)) { response in
            DispatchQueue.main.async {
                if case .success = response.result {
                    self.view?.showResult(str: "Category has been successfully deleted")
                } else {
                    self.view?.showResult(str: "Error while deleting")
                }
            }
        }
    }
    
    func onChangeCategory(request: CategoriesDTOs.OnChangeCategory.Request) {
        let category = categories[request.index]
        
        let requestAccount = UseCasesDTOs.ChangeCategory.Request(
            categoryID: category.id, categoryTitle: request.title, categoryColor: request.color
        )
        
        changeCategoryUseCase.execute(request: requestAccount) { response in
            DispatchQueue.main.async {
                if case .success = response.result {
                    self.view?.showResult(str: "Category has been successfully changed")
                } else {
                    self.view?.showResult(str: "Error while changing")
                }
            }
        }
    }
    
}
