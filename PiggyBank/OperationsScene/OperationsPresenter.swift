import Foundation

final class OperationsPresenter {
    
    private weak var view: OperationsViewController?
    
    private let getOperationsUseCase = GetOperationsUseCase()
    private let deleteOperationUseCase = DeleteOperationUseCase()
    
    private var operations: [DomainOperationModel] = []
    
    init(view: OperationsViewController) {
        self.view = view
    }
    
    func onViewDidLoad() {
        getOperationsUseCase.execute { [weak self] response in
            guard let self = self else {
                return
            }
            
            DispatchQueue.main.async {
                if case let .success(items) = response {
                    self.operations = items
                    
                    let operationsViewModels = items.compactMap { GrandConverter.convertToViewModel(operationModel: $0) }
                    self.view?.viewDidLoad(response: .init(operationsViewModels))
                }
            }
        }
    }
    
    func onDeleteOperation(id: UInt) {
        let operation = getOperation(at: id)
        
        deleteOperationUseCase.execute(operation: operation) { response in
            DispatchQueue.main.async {
                if case .success = response {
                    self.view?.show(alert: "Operation has been successfully deleted")
                } else {
                    self.view?.show(alert: "Error")
                }
            }
        }
    }
    
}

extension OperationsPresenter {
    
    func getOperation(at id: UInt) -> DomainOperationModel {
        operations.first { $0.id == id }!
    }
    
}

