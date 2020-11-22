import Foundation

final class OperationPresenter {
    
    private weak var view: OperationViewController?
    
    init(view: OperationViewController) {
        self.view = view
    }
}

