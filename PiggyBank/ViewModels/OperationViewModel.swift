import Foundation

final class OperationViewModel {
    
    enum OperationType: UInt {
        
        case budget = 1
        case transfer
        case plan
        
    }
    
    let id: UInt
    let type: OperationType
    
    init(id: UInt, type: OperationType) {
        self.id = id
        self.type = type
    }
    
}
