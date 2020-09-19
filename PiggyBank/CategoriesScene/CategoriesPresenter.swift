import Foundation

final class CategoriesPresenter {
    
    private weak var view: CategoriesViewController?
    
    private let getCategoriesUseCase = GetCategoriesUseCase()
    
    private var categories: [DomainCategoryModel] = []
    
    init(view: CategoriesViewController) {
        self.view = view
    }
    
    func onViewDidLoad() {
        getCategoriesUseCase.execute { [weak self] response in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                if case let .success(items) = response {
                    self.categories = items
                    
                    let categoriesViewModels = items.compactMap { GrandConverter.convertToViewModel(domainCategory: $0) }
                    self.view?.viewDidLoad(categories: categoriesViewModels)
                }
            }
        }
    }
    
}
