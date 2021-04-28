import Foundation

final class CategoriesPresenter {

    private weak var view: CategoriesViewController?
    private let getCategoriesUseCase: GetCategoriesUseCase?

    private var categories: [DomainCategoryModel] = []

    init(view: CategoriesViewController?, getCategoriesUseCase: GetCategoriesUseCase?) {
        self.view = view
        self.getCategoriesUseCase = getCategoriesUseCase
    }

    func onViewDidLoad() {
        getCategoriesUseCase?.execute { [weak self] response in
            guard let self = self else {
                return
            }
            
            DispatchQueue.main.async {
                if case let .success(items) = response {
                    self.categories = items
                    
                    let categoriesViewModels = items.compactMap { GrandConverter.convertToViewModel(domainCategory: $0) }
                    self.view?.viewDidLoad(categories: categoriesViewModels)
                }
            }
        }
    }

    func onAdd() {
        view?.push(viewController: DependencyProvider.shared.get(screen: .category(nil)))
    }

    func onSelect(id: Int) {
        view?.push(viewController: DependencyProvider.shared.get(screen: .category(getCategory(at: id))))
    }
}

extension CategoriesPresenter {
    
    func getCategory(at id: Int) -> DomainCategoryModel {
        categories.first { $0.id == id }!
    }
    
}
