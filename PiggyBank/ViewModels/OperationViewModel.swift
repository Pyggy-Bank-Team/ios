import Foundation

public final class OperationViewModel {
    
    enum OperationType: UInt {
        
        case budget = 1
        case transfer = 2
        case plan = 3
        
    }
    
    let id: UInt
    let type: OperationType
    
    init(id: UInt, type: OperationType) {
        self.id = id
        self.type = type
    }
    
}
