import Foundation

final class OperationsPresenter {
    
    class SectionItem {
        
        let emptyText: String?
        
        let headerTitle: String?
        var operations: [DomainOperationModel] = []
        
        init(title: String?) {
            self.headerTitle = title
            emptyText = nil
        }
        
        init(emptyText: String) {
            self.emptyText = emptyText
            headerTitle = nil
        }

    }
    
    private weak var view: OperationsViewController?
    
    private let getOperationsUseCase: GetOperationsUseCase

    private var sections: [SectionItem] = []
    
    init(view: OperationsViewController?, getOperationsUseCase: GetOperationsUseCase) {
        self.view = view
        self.getOperationsUseCase = getOperationsUseCase
    }
    
    func getSection(at index: Int) -> SectionItem {
        sections[index]
    }
    
    func getOperation(at indexPath: IndexPath) -> DomainOperationModel {
        sections[indexPath.section].operations[indexPath.row]
    }

    func getOperations() {
        getOperationsUseCase.execute { [weak self] response in
            self?.handleResponse(response)
        }
    }

}

private extension OperationsPresenter {
    
    func handleResponse(_ response: Result<[DomainOperationModel]>) {
        if case let .success(operations) = response {
            defer {
                DispatchQueue.main.async {
                    self.view?.sections = self.sections
                }
            }
            
            sections.removeAll()
            
            if operations.isEmpty {
                let empty = SectionItem(emptyText: "No operations")
                sections.append(empty)
                return
            }
            
            let regularOperations = SectionItem(title: nil)
            
            operations.forEach { operation in
                regularOperations.operations.append(operation)
            }
            
            sections.removeAll()
            if !regularOperations.operations.isEmpty {
                sections.append(regularOperations)
            }
        }
    }
    
}
