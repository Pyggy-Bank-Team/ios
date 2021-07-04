import Foundation

final class OperationsPresenter {
    
    class SectionItem {
        
        let emptyText: String?
        
        let headerTitle: String?
        let headerSubitle: String?
        let date: Date?
        var operations: [DomainOperationModel] = []
        
        init(title: String, headerSubitle: String, date: Date) {
            headerTitle = title
            self.headerSubitle = headerSubitle
            self.date = date
            emptyText = nil
        }
        
        init(emptyText: String) {
            self.emptyText = emptyText
            headerTitle = nil
            date = nil
            headerSubitle = nil
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
            
            var map: [Date: [DomainOperationModel]] = [:]
            for operation in operations {
                let startDate = Calendar.current.startOfDay(for: operation.date)
                
                var currentOperations = map[startDate] ?? []
                currentOperations.append(operation)
                map[startDate] = currentOperations
            }
            
            for (key, value) in map {
                var title = ""
                
                if Calendar.current.isDateInToday(key) {
                    title = "Today"
                } else if Calendar.current.isDateInYesterday(key) {
                    title = "Yesterday"
                } else {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "MMM d, yyyy"
                    title = dateFormatter.string(from: key)
                }
                
                let sum = value.reduce(0) { $0 + $1.amount }
                let currencyCode = value.first?.fromAccount.currency?.getCurrencySymbol() ?? ""
                let section = SectionItem(title: title, headerSubitle: sum.formatSign + currencyCode, date: key)
                section.operations = value
                sections.append(section)
            }
            
            sections.sort { $0.date! > $1.date! }
        }
    }
    
}
