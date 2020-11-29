import Foundation

final class OperationPresenter {
    
    private weak var view: OperationViewController?

    private let getCategoriesUseCase = GetCategoriesUseCase()
    
    init(view: OperationViewController) {
        self.view = view
    }

    func onViewDidLoad() {
        getCategoriesUseCase.execute { [weak self] categories in
            if case let .success(items) = categories {
                DispatchQueue.main.async {
                    self?.view?.itemsLoaded(items: items.map { $0.title })
                }
            }
        }
    }
}

